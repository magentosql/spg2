<?php
/**
 * Copyright � 2015 Magento. All rights reserved.
 * See COPYING.txt for license details.
 */
namespace Unirgy\DropshipMulti\Model\StockIndexer;

/**
 * Bundle Stock Status Indexer Resource Model
 *
 * @author      Magento Core Team <core@magentocommerce.com>
 */
class Bundle extends DefaultStock
{
    /**
     * Reindex temporary (price result data) for defined product(s)
     *
     * @param int|array $entityIds
     * @return $this
     */
    public function reindexEntity($entityIds)
    {
        $this->_updateIndex($entityIds);

        return $this;
    }

    /**
     * Retrieve table name for temporary bundle option stock index
     *
     * @return string
     */
    protected function _getBundleOptionTable()
    {
        return $this->getTable('catalog_product_bundle_stock_index');
    }

    /**
     * Prepare stock status per Bundle options, website and stock
     *
     * @param int|array $entityIds
     * @param bool $usePrimaryTable use primary or temporary index table
     * @return $this
     */
    protected function _prepareBundleOptionStockData($entityIds = null, $usePrimaryTable = false)
    {
        $this->_cleanBundleOptionStockData();
        $idxTable = $usePrimaryTable ? $this->getMainTable() : $this->getIdxTable();
        $connection = $this->getConnection();
        $select = $connection->select()->from(
            ['bo' => $this->getTable('catalog_product_bundle_option')],
            ['parent_id']
        );
        $this->_addWebsiteJoinToSelect($select, false);
        $status = new \Zend_Db_Expr(
            'MAX(' . $connection->getCheckSql('e.required_options = 0', 'i.stock_status', '0') . ')'
        );
        $websiteIdColumn = $this->_hlp->hasMageFeature('stock_website') ? 'cis.website_id' : 'cw.website_id';
        $select->join(
            ['cis' => $this->getTable('cataloginventory_stock')],
            '',
            [$websiteIdColumn, 'stock_id']
        )->joinLeft(
            ['bs' => $this->getTable('catalog_product_bundle_selection')],
            'bs.option_id = bo.option_id',
            []
        )->joinLeft(
            ['i' => $idxTable],
            "i.product_id = bs.product_id AND i.website_id = $websiteIdColumn AND i.stock_id = cis.stock_id",
            []
        )->joinLeft(
            ['e' => $this->getTable('catalog_product_entity')],
            'e.entity_id = bs.product_id',
            []
        )->group(
            ['bo.parent_id', $websiteIdColumn, 'cis.stock_id', 'bo.option_id']
        )->columns(
            ['option_id' => 'bo.option_id', 'status' => $status]
        );

        if ($this->_hlp->hasMageFeature('stock_website')) {
            $select->where('cis.website_id = 0');
        } else {
            $select->where('cw.website_id != 0');
        }

        if ($entityIds !== null) {
            $select->where('bo.parent_id IN(?)', $entityIds);
        }

        // clone select for bundle product without required bundle options
        $selectNonRequired = clone $select;

        $select->where('bo.required = ?', 1);
        $selectNonRequired->where('bo.required = ?', 0)->having($status . ' = 1');
        $query = $select->insertFromSelect($this->_getBundleOptionTable());
        $connection->query($query);

        $query = $selectNonRequired->insertFromSelect($this->_getBundleOptionTable());
        $connection->query($query);

        return $this;
    }

    /**
     * Get the select object for get stock status by product ids
     *
     * @param int|array $entityIds
     * @param bool $usePrimaryTable use primary or temporary index table
     * @return \Magento\Framework\DB\Select
     */
    protected function _getStockStatusSelect($entityIds = null, $usePrimaryTable = false)
    {
        $this->_prepareBundleOptionStockData($entityIds, $usePrimaryTable);

        $connection = $this->getConnection();
        $select = $connection->select()->from(
            ['e' => $this->getTable('catalog_product_entity')],
            ['entity_id']
        );
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
            ['o' => $this->_getBundleOptionTable()],
            "o.entity_id = e.entity_id AND o.website_id = $websiteIdColumn AND o.stock_id = cis.stock_id",
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

        // add limitation of status
        if (!$this->_hlp->hasMageFeature('stock_website')) {
            $condition = $connection->quoteInto(
                '=?',
                \Magento\Catalog\Model\Product\Attribute\Source\Status::STATUS_ENABLED
            );
            $this->_addAttributeToSelect($select, 'status', 'e.entity_id', 'cs.store_id', $condition);
        }

        if ($this->_isManageStock()) {
            $statusExpr = $connection->getCheckSql(
                'cisi.use_config_manage_stock = 0 AND cisi.manage_stock = 0',
                '1',
                'cisi.is_in_stock'
            );
        } else {
            $statusExpr = $connection->getCheckSql(
                'cisi.use_config_manage_stock = 0 AND cisi.manage_stock = 1',
                'cisi.is_in_stock',
                '1'
            );
        }

        $select->columns(
            [
                'status' => $connection->getLeastSql(
                    [
                        new \Zend_Db_Expr(
                            'MIN(' . $connection->getCheckSql('o.stock_status IS NOT NULL', 'o.stock_status', '0') . ')'
                        ),
                        new \Zend_Db_Expr('MIN(' . $statusExpr . ')'),
                    ]
                ),
            ]
        );

        if ($entityIds !== null) {
            $select->where('e.entity_id IN(?)', $entityIds);
        }

        return $select;
    }

    /**
     * Prepare stock status data in temporary index table
     *
     * @param int|array $entityIds  the product limitation
     * @return $this
     */
    protected function _prepareIndexTable($entityIds = null)
    {
        parent::_prepareIndexTable($entityIds);
        $this->_cleanBundleOptionStockData();

        return $this;
    }

    /**
     * Update Stock status index by product ids
     *
     * @param array|int $entityIds
     * @return $this
     */
    protected function _updateIndex($entityIds)
    {
        parent::_updateIndex($entityIds);
        $this->_cleanBundleOptionStockData();

        return $this;
    }

    /**
     * Clean temporary bundle options stock data
     *
     * @return $this
     */
    protected function _cleanBundleOptionStockData()
    {
        $this->getConnection()->delete($this->_getBundleOptionTable());
        return $this;
    }
}
