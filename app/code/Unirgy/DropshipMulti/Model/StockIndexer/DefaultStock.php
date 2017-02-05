<?php
/**
 * Copyright © 2015 Magento. All rights reserved.
 * See COPYING.txt for license details.
 */

namespace Unirgy\DropshipMulti\Model\StockIndexer;

use Magento\Catalog\Model\ResourceModel\Product\Indexer\AbstractIndexer;
use Magento\CatalogInventory\Model\ResourceModel\Indexer\Stock\StockInterface;

/**
 * CatalogInventory Default Stock Status Indexer Resource Model
 */
class DefaultStock extends AbstractIndexer implements StockInterface
{
    /**
     * Current Product Type Id
     *
     * @var string
     */
    protected $_typeId;

    /**
     * Product Type is composite flag
     *
     * @var bool
     */
    protected $_isComposite = false;

    /**
     * Core store config
     *
     * @var \Magento\Framework\App\Config\ScopeConfigInterface
     */
    protected $_scopeConfig;

    /**
     * Class constructor
     *
     * @param \Magento\Framework\Model\ResourceModel\Db\Context $context
     * @param \Magento\Framework\Indexer\Table\StrategyInterface $tableStrategy
     * @param \Magento\Eav\Model\Config $eavConfig
     * @param \Magento\Framework\App\Config\ScopeConfigInterface $scopeConfig
     * @param string $connectionName
     */
    protected $_hlp;
    public function __construct(
        \Unirgy\Dropship\Helper\Data $udropshipHelper,
        \Magento\Framework\Model\ResourceModel\Db\Context $context,
        \Magento\Framework\Indexer\Table\StrategyInterface $tableStrategy,
        \Magento\Eav\Model\Config $eavConfig,
        \Magento\Framework\App\Config\ScopeConfigInterface $scopeConfig,
        $connectionName = null
    ) {
        $this->_hlp = $udropshipHelper;
        $this->_scopeConfig = $scopeConfig;
        parent::__construct($context, $tableStrategy, $eavConfig, $connectionName);
    }

    /**
     * Initialize connection and define main table name
     *
     * @return void
     */
    protected function _construct()
    {
        $this->_init('cataloginventory_stock_status', 'product_id');
    }

    /**
     * Reindex all stock status data for default logic product type
     *
     * @return $this
     * @throws \Exception
     */
    public function reindexAll()
    {
        $this->tableStrategy->setUseIdxTable(true);
        $this->beginTransaction();
        try {
            $this->_prepareIndexTable();
            $this->commit();
        } catch (\Exception $e) {
            $this->rollBack();
            throw $e;
        }
        return $this;
    }

    /**
     * Reindex stock data for defined product ids
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
     * Set active Product Type Id
     *
     * @param string $typeId
     * @return $this
     */
    public function setTypeId($typeId)
    {
        $this->_typeId = $typeId;
        return $this;
    }

    /**
     * Retrieve active Product Type Id
     *
     * @return string
     * @throws \Magento\Framework\Exception\LocalizedException
     */
    public function getTypeId()
    {
        if ($this->_typeId === null) {
            throw new \Magento\Framework\Exception\LocalizedException(__('Undefined product type'));
        }
        return $this->_typeId;
    }

    /**
     * Set Product Type Composite flag
     *
     * @param bool $flag
     * @return $this
     */
    public function setIsComposite($flag)
    {
        $this->_isComposite = (bool) $flag;
        return $this;
    }

    /**
     * Check product type is composite
     *
     * @return bool
     * @SuppressWarnings(PHPMD.BooleanGetMethodName)
     */
    public function getIsComposite()
    {
        return $this->_isComposite;
    }

    /**
     * Retrieve is Global Manage Stock enabled
     *
     * @return bool
     */
    protected function _isManageStock()
    {
        return $this->_scopeConfig->isSetFlag(
            \Magento\CatalogInventory\Model\Configuration::XML_PATH_MANAGE_STOCK,
            \Magento\Store\Model\ScopeInterface::SCOPE_STORE
        );
    }

    protected function _isBackordersEnabled()
    {
        return $this->_scopeConfig->isSetFlag(
            \Magento\CatalogInventory\Model\Configuration::XML_PATH_BACKORDERS,
            \Magento\Store\Model\ScopeInterface::SCOPE_STORE
        );
    }

    protected function _getMinQty()
    {
        return $this->_scopeConfig->getValue(
            \Magento\CatalogInventory\Model\Configuration::XML_PATH_MIN_QTY,
            \Magento\Store\Model\ScopeInterface::SCOPE_STORE
        );
    }


    /**
     * Get the select object for get stock status by product ids
     *
     * @param int|array $entityIds
     * @param bool $usePrimaryTable use primary or temporary index table
     * @return \Magento\Framework\DB\Select
     * @SuppressWarnings(PHPMD.UnusedFormalParameter)
     */
    protected function _getStockStatusSelect($entityIds = null, $usePrimaryTable = false)
    {
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
            ['uvp'=>$this->getTable('udropship_vendor_product')],
            'uvp.product_id=e.entity_id AND uvp.status>0',
            []
        )->joinLeft(
            ['uv'=>$this->getTable('udropship_vendor')],
            "uv.vendor_id=uvp.vendor_id AND uv.status='A'",
            []
        );
        $select->group(['e.entity_id',$websiteIdColumn,'cis.stock_id']);

        $_qtyExpr = $connection->getCheckSql(
            'uvp.stock_qty IS NULL',
            '10000', $connection->getCheckSql('uvp.stock_qty>0', 'uvp.stock_qty', '0')
        );
        $qtyExpr = sprintf('MAX(%s)',
            $connection->getCheckSql('uvp.vendor_product_id IS NULL OR uv.vendor_id IS NULL', '0', $_qtyExpr)
        );

        $cfgMinQty = (int)$this->_getMinQty();

        $stockQtyExpr = $connection->getCheckSql(
            'cisi.use_config_min_qty>0',
            'uvp.stock_qty>'.$cfgMinQty, 'uvp.stock_qty>cisi.min_qty'
        );

        if ($this->_isBackordersEnabled()) {
            $_statusExpr = $connection->getCheckSql(
                'uvp.backorders=-1 AND (cisi.use_config_backorders>0 OR cisi.backorders>0)'
                .' OR uvp.backorders>0 OR uvp.stock_qty IS NULL OR '.$stockQtyExpr,
                '1', '0'
            );
        } else {
            $_statusExpr = $connection->getCheckSql(
                'uvp.backorders=-1 AND (cisi.use_config_backorders=0 AND cisi.backorders>0)'
                .' OR uvp.backorders>0 OR uvp.stock_qty IS NULL OR '.$stockQtyExpr,
                '1', '0'
            );
        }
        $statusExpr = sprintf('MAX(%s)',
            $connection->getCheckSql('uvp.vendor_product_id IS NULL OR uv.vendor_id IS NULL', '0', $_statusExpr)
        );
        $select->columns(['qty' => $qtyExpr, 'status' => $statusExpr])
            ->where('e.type_id = ?', $this->getTypeId());

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

        if ($entityIds !== null) {
            $select->where('e.entity_id IN(?)', $entityIds);
        }

        return $select;
    }

    /**
     * Prepare stock status data in temporary index table
     *
     * @param int|array $entityIds the product limitation
     * @return $this
     */
    protected function _prepareIndexTable($entityIds = null)
    {
        $connection = $this->getConnection();
        $this->_syncUdmWithStockItem($entityIds);
        $select = $this->_getStockStatusSelect($entityIds);
        $query = $select->insertFromSelect($this->getIdxTable());
        $connection->query($query);

        return $this;
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

        $uvpColumns = $adapter->describeTable($this->getTable('udropship_vendor_product'));
        $uvpCond = 'uvp.product_id=e.entity_id';
        if (array_key_exists('status', $uvpColumns)) {
            $uvpCond .= ' AND uvp.status>0';
        }
        $select->joinLeft(
            ['uvp'=>$this->getTable('udropship_vendor_product')],
            $uvpCond,
            []
        )->joinLeft(
            ['uv'=>$this->getTable('udropship_vendor')],
            'uv.vendor_id=uvp.vendor_id AND uv.status=\'A\'',
            []
        );
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
            'cisi.use_config_min_qty>0',
            'uvp.stock_qty>'.$cfgMinQty, 'uvp.stock_qty>cisi.min_qty'
        );

        if ($this->_isBackordersEnabled()) {
            $_statusExpr = $adapter->getCheckSql(
                'uvp.backorders=-1 AND (cisi.use_config_backorders>0 OR cisi.backorders>0)'
                .' OR uvp.backorders>0 OR uvp.stock_qty IS NULL OR '.$stockQtyExpr,
                '1', '0'
            );
        } else {
            $_statusExpr = $adapter->getCheckSql(
                'uvp.backorders=-1 AND (cisi.use_config_backorders=0 AND cisi.backorders>0)'
                .' OR uvp.backorders>0 OR uvp.stock_qty IS NULL OR '.$stockQtyExpr,
                '1', '0'
            );
        }
        $statusExpr = sprintf('MAX(%s)',
            $adapter->getCheckSql('uvp.vendor_product_id IS NULL OR uv.vendor_id IS NULL', '0', $_statusExpr)
        );
        $select->columns(['item_id' => 'cisi.item_id', 'product_id' => 'cisi.product_id', 'stock_id' => 'cisi.stock_id', 'qty' => $qtyExpr, 'is_in_stock' => $statusExpr]);

        if (!is_null($entityIds)) {
            $select->where('e.entity_id IN(?)', $entityIds);
        }

        $query = $select->insertFromSelect($this->getTable('cataloginventory_stock_item'), ['item_id', 'product_id', 'stock_id', 'qty', 'is_in_stock'], true);
        $adapter->query($query);

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
        $connection = $this->getConnection();
        $this->_syncUdmWithStockItem($entityIds);
        $select = $this->_getStockStatusSelect($entityIds, true);
        $query = $connection->query($select);

        $i = 0;
        $data = [];
        while ($row = $query->fetch(\PDO::FETCH_ASSOC)) {
            $i++;
            $data[] = [
                'product_id' => (int)$row['entity_id'],
                'website_id' => (int)$row['website_id'],
                'stock_id' => (int)$row['stock_id'],
                'qty' => (double)$row['qty'],
                'stock_status' => (int)$row['status'],
            ];
            if ($i % 1000 == 0) {
                $this->_updateIndexTable($data);
                $data = [];
            }
        }
        $this->_updateIndexTable($data);

        return $this;
    }

    /**
     * Update stock status index table (INSERT ... ON DUPLICATE KEY UPDATE ...)
     *
     * @param array $data
     * @return $this
     */
    protected function _updateIndexTable($data)
    {
        if (empty($data)) {
            return $this;
        }

        $connection = $this->getConnection();
        $connection->insertOnDuplicate($this->getMainTable(), $data, ['qty', 'stock_status']);

        return $this;
    }

    /**
     * Retrieve temporary index table name
     *
     * @param string $table
     * @return string
     * @SuppressWarnings(PHPMD.UnusedFormalParameter)
     */
    public function getIdxTable($table = null)
    {
        return $this->tableStrategy->getTableName('cataloginventory_stock_status');
    }
}
