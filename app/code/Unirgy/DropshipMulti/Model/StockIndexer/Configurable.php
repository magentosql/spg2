<?php
/**
 * CatalogInventory Configurable Products Stock Status Indexer Resource Model
 *
 * Copyright © 2015 Magento. All rights reserved.
 * See COPYING.txt for license details.
 */
namespace Unirgy\DropshipMulti\Model\StockIndexer;

/**
 * CatalogInventory Configurable Products Stock Status Indexer Resource Model
 *
 * @author      Magento Core Team <core@magentocommerce.com>
 */
use Magento\Catalog\Model\Product\Attribute\Source\Status as ProductStatus;

class Configurable extends DefaultStock
{
    /**
     * Get the select object for get stock status by configurable product ids
     *
     * @param int|array $entityIds
     * @param bool $usePrimaryTable use primary or temporary index table
     * @return \Magento\Framework\DB\Select
     */
    protected function _getStockStatusSelect($entityIds = null, $usePrimaryTable = false)
    {
        $connection = $this->getConnection();
        $idxTable = $usePrimaryTable ? $this->getMainTable() : $this->getIdxTable();
        $select = $connection->select()->from(['e' => $this->getTable('catalog_product_entity')], ['entity_id']);
        if (!$this->_hlp->hasMageFeature('stock_website')) {
            $this->_addWebsiteJoinToSelect($select, true);
            $this->_addProductWebsiteJoinToSelect($select, 'cw.website_id', 'e.entity_id');
        }
        $websiteIdColumn = $this->_hlp->hasMageFeature('stock_website') ? 'cis.website_id' : 'cw.website_id';
        $select->join(
            ['cis' => $this->getTable('cataloginventory_stock')],
            '',
            [$websiteIdColumn, 'stock_id']
        )->joinLeft(
            ['cisi' => $this->getTable('cataloginventory_stock_item')],
            'cisi.stock_id = cis.stock_id AND cisi.product_id = e.entity_id',
            []
        )->joinLeft(
            ['l' => $this->getTable('catalog_product_super_link')],
            'l.parent_id = e.entity_id',
            []
        )->join(
            ['le' => $this->getTable('catalog_product_entity')],
            'le.entity_id = l.product_id',
            []
        )->joinLeft(
            ['i' => $idxTable],
            "i.product_id = l.product_id AND $websiteIdColumn = i.website_id AND cis.stock_id = i.stock_id",
            []
        )->columns(
            ['qty' => new \Zend_Db_Expr('0')]
        )->where(
            'e.type_id = ?',
            $this->getTypeId()
        )->group(
            ['e.entity_id', $websiteIdColumn, 'cis.stock_id']
        );

        if ($this->_hlp->hasMageFeature('stock_website')) {
            $select->where('cis.website_id = 0');
        } else {
            $select->where('cw.website_id != 0');
        }

        if ($this->_isManageStock()) {
            $statusExpr = $connection->getCheckSql(
                'cisi.use_config_manage_stock = 0 AND cisi.manage_stock = 0',
                1,
                'cisi.is_in_stock'
            );
        } else {
            $statusExpr = $connection->getCheckSql(
                'cisi.use_config_manage_stock = 0 AND cisi.manage_stock = 1',
                'cisi.is_in_stock',
                1
            );
        }

        if (!$this->_hlp->hasMageFeature('stock_website')) {
            $psExpr = $this->_addAttributeToSelect($select, 'status', 'e.entity_id', 'cs.store_id');
            $psCond = $connection->quoteInto($psExpr . '=?', ProductStatus::STATUS_ENABLED);
            $optExpr = $connection->getCheckSql("{$psCond} AND le.required_options = 0", 'i.stock_status', 0);
        } else {
            $optExpr = $connection->getCheckSql("le.required_options = 0", 'i.stock_status', 0);
        }

        $stockStatusExpr = $connection->getLeastSql(["MAX({$optExpr})", "MIN({$statusExpr})"]);

        $select->columns(['status' => $stockStatusExpr]);

        if ($entityIds !== null) {
            $select->where('e.entity_id IN(?)', $entityIds);
        }

        return $select;
    }
    protected function _syncUdmWithStockItem($entityIds)
    {
        $adapter = $this->getConnection();
        $select  = $adapter->select()
            ->from(['cisi' => $this->getTable('cataloginventory_stock_item')], [])
            ->join(['e' => $this->getTable('catalog_product_entity')],
                'cisi.stock_id = '.(int)\Magento\CatalogInventory\Model\Stock::DEFAULT_STOCK_ID
                .' AND cisi.product_id = e.entity_id',
                []);
        $select->where('e.type_id = ?', $this->getTypeId());

        $select->joinLeft(
            ['l' => $this->getTable('catalog_product_super_link')],
            'l.parent_id = e.entity_id',
            [])
            ->joinLeft(
                ['le' => $this->getTable('catalog_product_entity')],
                'le.entity_id = l.product_id',
                [])
            ->joinLeft(
                ['ssi' => $this->getTable('cataloginventory_stock_item')],
                'ssi.product_id = le.entity_id AND cisi.stock_id = ssi.stock_id',
                []);

        $uvpColumns = $adapter->describeTable($this->getTable('udropship_vendor_product'));
        $uvpCond = 'uvp.product_id=ssi.product_id';
        if (array_key_exists('status', $uvpColumns)) {
            $uvpCond .= ' AND uvp.status>0';
        }
        $select->joinLeft(
            ['uvp'=>$this->getTable('udropship_vendor_product')],
            $uvpCond,
            [])
            ->joinLeft(
                ['uv'=>$this->getTable('udropship_vendor')],
                'uv.vendor_id=uvp.vendor_id AND uv.status=\'A\'',
                []);
        $select->group(['cisi.item_id']);
        $_qtyExpr = $adapter->getCheckSql(
            'uvp.stock_qty IS NULL',
            '10000', $adapter->getCheckSql('uvp.stock_qty>0', 'uvp.stock_qty', '0')
        );
        $qtyExpr = sprintf('MAX(%s)',
            $adapter->getCheckSql('uvp.vendor_product_id IS NULL OR uv.vendor_id IS NULL', '0', $_qtyExpr)
        );

        $cfgMinQty = (int)$this->_getMinQty();

        $stockQtyExpr = $adapter->getCheckSql(
            'ssi.use_config_min_qty>0',
            'uvp.stock_qty>'.$cfgMinQty, 'uvp.stock_qty>ssi.min_qty'
        );

        if ($this->_isBackordersEnabled()) {
            $_statusExpr = $adapter->getCheckSql(
                'uvp.backorders=-1 AND (ssi.use_config_backorders>0 OR ssi.backorders>0)'
                .' OR uvp.backorders>0 OR uvp.stock_qty IS NULL OR '.$stockQtyExpr,
                '1', '0'
            );
        } else {
            $_statusExpr = $adapter->getCheckSql(
                'uvp.backorders=-1 AND (ssi.use_config_backorders=0 AND ssi.backorders>0)'
                .' OR uvp.backorders>0 OR uvp.stock_qty IS NULL OR '.$stockQtyExpr,
                '1', '0'
            );
        }
        $statusExpr = sprintf('IF(MAX(%s)>0,1,0)',
            $adapter->getCheckSql('uvp.vendor_product_id IS NULL OR uv.vendor_id IS NULL', '0', $_statusExpr)
        );
        $select->columns(['item_id' => 'cisi.item_id', 'product_id' => 'cisi.product_id', 'stock_id' => 'cisi.stock_id', 'qty' => new \Zend_Db_Expr('0'), 'is_in_stock' => $statusExpr]);

        if (!is_null($entityIds)) {
            $select->where('e.entity_id IN(?)', $entityIds);
        }

        $query = $select->insertFromSelect($this->getTable('cataloginventory_stock_item'), ['item_id', 'product_id', 'stock_id', 'qty', 'is_in_stock'], true);
        $adapter->query($query);

        return $this;
    }
}
