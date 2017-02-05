<?php
/**
 * Copyright © 2015 Magento. All rights reserved.
 * See COPYING.txt for license details.
 */
namespace Unirgy\DropshipMultiPrice\Model\PriceIndexer;

/**
 * Default Product Type Price Indexer Resource model
 * For correctly work need define product type id
 *
 * @author      Magento Core Team <core@magentocommerce.com>
 */
class DefaultPrice extends \Magento\Catalog\Model\ResourceModel\Product\Indexer\Price\DefaultPrice
{
    protected $_hlp;
    protected $_scopeConfig;
    protected $_multiPriceSrc;
    public function __construct(
        \Unirgy\Dropship\Helper\Data $udropshipHelper,
        \Magento\Framework\App\Config\ScopeConfigInterface $scopeConfig,
        \Unirgy\DropshipMultiPrice\Model\Source $multiPriceSrc,
        \Magento\Framework\Model\ResourceModel\Db\Context $context,
        \Magento\Framework\Indexer\Table\StrategyInterface $tableStrategy,
        \Magento\Eav\Model\Config $eavConfig,
        \Magento\Framework\Event\ManagerInterface $eventManager,
        \Magento\Framework\Module\Manager $moduleManager,
        $connectionName = null
    ) {
        $this->_hlp = $udropshipHelper;
        $this->_multiPriceSrc = $multiPriceSrc;
        $this->_scopeConfig = $scopeConfig;
        parent::__construct($context, $tableStrategy, $eavConfig, $eventManager, $moduleManager, $connectionName);
    }
    /**
     * Get Table strategy
     *
     * @return \Magento\Framework\Indexer\Table\StrategyInterface
     */
    public function getTableStrategy()
    {
        return $this->tableStrategy;
    }

    /**
     * Define main price index table
     *
     * @return void
     */
    protected function _construct()
    {
        $this->_init('catalog_product_index_price', 'entity_id');
    }

    /**
     * Set Product Type code
     *
     * @param string $typeCode
     * @return $this
     */
    public function setTypeId($typeCode)
    {
        $this->_typeId = $typeCode;
        return $this;
    }

    /**
     * Retrieve Product Type Code
     *
     * @return string
     * @throws \Magento\Framework\Exception\LocalizedException
     */
    public function getTypeId()
    {
        if ($this->_typeId === null) {
            throw new \Magento\Framework\Exception\LocalizedException(
                __('A product type is not defined for the indexer.')
            );
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
        $this->_isComposite = (bool)$flag;
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
     * Reindex temporary (price result data) for all products
     *
     * @return $this
     * @throws \Exception
     */
    public function reindexAll()
    {
        $this->tableStrategy->setUseIdxTable(true);
        $this->beginTransaction();
        try {
            $this->reindex();
            $this->commit();
        } catch (\Exception $e) {
            $this->rollBack();
            throw $e;
        }
        return $this;
    }

    /**
     * Reindex temporary (price result data) for defined product(s)
     *
     * @param int|array $entityIds
     * @return \Magento\Catalog\Model\ResourceModel\Product\Indexer\Price\DefaultPrice
     */
    public function reindexEntity($entityIds)
    {
        $this->reindex($entityIds);
        return $this;
    }

    /**
     * @param null|int|array $entityIds
     * @return \Magento\Catalog\Model\ResourceModel\Product\Indexer\Price\DefaultPrice
     */
    protected function reindex($entityIds = null)
    {
        if ($this->hasEntity() || !empty($entityIds)) {
            $this->_prepareFinalPriceData($entityIds);
            $this->_applyCustomOption();
            $this->_movePriceDataToIndexTable();
        }
        return $this;
    }

    /**
     * Retrieve final price temporary index table name
     *
     * @see _prepareDefaultFinalPriceTable()
     *
     * @return string
     */
    protected function _getDefaultFinalPriceTable()
    {
        return $this->tableStrategy->getTableName('catalog_product_index_price_final');
    }

    /**
     * Prepare final price temporary index table
     *
     * @return $this
     */
    protected function _prepareDefaultFinalPriceTable()
    {
        $this->getConnection()->delete($this->_getDefaultFinalPriceTable());
        return $this;
    }

    /**
     * Retrieve website current dates table name
     *
     * @return string
     */
    protected function _getWebsiteDateTable()
    {
        return $this->getTable('catalog_product_index_website');
    }

    /**
     * Prepare products default final price in temporary index table
     *
     * @param int|array $entityIds the entity ids limitation
     * @return $this
     * @SuppressWarnings(PHPMD.ExcessiveMethodLength)
     */
    protected function _prepareFinalPriceData($entityIds = null)
    {
        return $this->prepareFinalPriceDataForType($entityIds, $this->getTypeId());
    }

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
     * Prepare products default final price in temporary index table
     *
     * @param int|array $entityIds the entity ids limitation
     * @param string|null $type product type, all if null
     * @return $this
     * @throws \Magento\Framework\Exception\LocalizedException
     * @SuppressWarnings(PHPMD.ExcessiveMethodLength)
     */
    protected function prepareFinalPriceDataForType($entityIds, $type)
    {
        $this->_prepareDefaultFinalPriceTable();

        $write = $connection = $this->getConnection();

        $cfgMinQty = (int)$this->_getMinQty();
        $stockQtyExpr = $write->getCheckSql(
            'cisi.use_config_min_qty>0',
            'uvp.stock_qty>'.$cfgMinQty, 'uvp.stock_qty>cisi.min_qty'
        );
        if ((int)$this->_isBackordersEnabled()) {
            $_statusExpr = $write->getCheckSql(
                'uvp.backorders=-1 AND (cisi.use_config_backorders>0 OR cisi.backorders>0)'
                .' OR uvp.backorders>0 OR uvp.stock_qty IS NULL OR '.$stockQtyExpr,
                '1', '0'
            );
        } else {
            $_statusExpr = $write->getCheckSql(
                'uvp.backorders=-1 AND (cisi.use_config_backorders=0 AND cisi.backorders>0)'
                .' OR uvp.backorders>0 OR uvp.stock_qty IS NULL OR '.$stockQtyExpr,
                '1', '0'
            );
        }

        $select = $connection->select()->from(
            ['e' => $this->getTable('catalog_product_entity')],
            ['entity_id']
        )->joinLeft(
            ['cisi' => $this->getTable('cataloginventory_stock_item')],
            'cisi.product_id = e.entity_id',
            []
        )->joinLeft(
            ['uvp'=>$this->getTable('udropship_vendor_product')],
            'uvp.product_id=e.entity_id AND uvp.status>0 AND '.$_statusExpr,
            []
        )->joinLeft(
            ['uv'=>$this->getTable('udropship_vendor')],
            'uv.vendor_id=uvp.vendor_id AND uv.status=\'A\'',
            []
        )->join(
            ['cg' => $this->getTable('customer_group')],
            '',
            ['customer_group_id']
        )->join(
            ['cw' => $this->getTable('store_website')],
            '',
            ['website_id']
        )->join(
            ['cwd' => $this->_getWebsiteDateTable()],
            'cw.website_id = cwd.website_id',
            []
        )->join(
            ['csg' => $this->getTable('store_group')],
            'csg.website_id = cw.website_id AND cw.default_group_id = csg.group_id',
            []
        )->join(
            ['cs' => $this->getTable('store')],
            'csg.default_store_id = cs.store_id AND cs.store_id != 0',
            []
        )->join(
            ['pw' => $this->getTable('catalog_product_website')],
            'pw.product_id = e.entity_id AND pw.website_id = cw.website_id',
            []
        )->joinLeft(
            ['tp' => $this->_getTierPriceIndexTable()],
            'tp.entity_id = e.entity_id AND tp.website_id = cw.website_id' .
            ' AND tp.customer_group_id = cg.customer_group_id',
            []
        );

        if ($type !== null) {
            $select->where('e.type_id = ?', $type);
        }

        // add enable products limitation
        $statusCond = $connection->quoteInto(
            '=?',
            \Magento\Catalog\Model\Product\Attribute\Source\Status::STATUS_ENABLED
        );
        $this->_addAttributeToSelect($select, 'status', 'e.entity_id', 'cs.store_id', $statusCond, true);
        if ($this->moduleManager->isEnabled('Magento_Tax')) {
            $taxClassId = $this->_addAttributeToSelect($select, 'tax_class_id', 'e.entity_id', 'cs.store_id');
        } else {
            $taxClassId = new \Zend_Db_Expr('0');
        }
        $select->columns(['tax_class_id' => $taxClassId]);

        $price = $this->_addAttributeToSelect($select, 'price', 'e.entity_id', 'cs.store_id');
        $specialPrice = $this->_addAttributeToSelect($select, 'special_price', 'e.entity_id', 'cs.store_id');
        $specialFrom = $this->_addAttributeToSelect($select, 'special_from_date', 'e.entity_id', 'cs.store_id');
        $specialTo = $this->_addAttributeToSelect($select, 'special_to_date', 'e.entity_id', 'cs.store_id');
        $currentDate = $connection->getDatePartSql('cwd.website_date');

        $specialFromDate = $connection->getDatePartSql($specialFrom);
        $specialToDate = $connection->getDatePartSql($specialTo);

        $specialFromUse = $connection->getCheckSql("{$specialFromDate} <= {$currentDate}", '1', '0');
        $specialToUse = $connection->getCheckSql("{$specialToDate} >= {$currentDate}", '1', '0');
        $specialFromHas = $connection->getCheckSql("{$specialFrom} IS NULL", '1', "{$specialFromUse}");
        $specialToHas = $connection->getCheckSql("{$specialTo} IS NULL", '1', "{$specialToUse}");
        $finalPrice = $connection->getCheckSql(
            "{$specialFromHas} > 0 AND {$specialToHas} > 0" . " AND {$specialPrice} < {$price}",
            $specialPrice,
            $price
        );

        $select->columns(
            [
                'orig_price' => $connection->getIfNullSql($price, 0),
                'price' => $connection->getIfNullSql($finalPrice, 0),
                'min_price' => $connection->getIfNullSql($finalPrice, 0),
                'max_price' => $connection->getIfNullSql($finalPrice, 0),
                'tier_price' => new \Zend_Db_Expr('tp.min_price'),
                'base_tier' => new \Zend_Db_Expr('tp.min_price'),
            ]
        );

        $umpSrc = $this->_multiPriceSrc;
        $canStates = $umpSrc->setPath('vendor_product_state_canonic')->toOptionHash();

        $uvPrice        = 'uvp.vendor_price';
        $uvSpecialPrice = 'uvp.special_price';
        $uvSpecialFrom  = 'uvp.special_from_date';
        $uvSpecialTo    = 'uvp.special_to_date';

        $uvSpecialFromDate    = $write->getDatePartSql($uvSpecialFrom);
        $uvSpecialToDate      = $write->getDatePartSql($uvSpecialTo);

        $uvSpecialFromUse     = $write->getCheckSql("{$uvSpecialFromDate} <= {$currentDate}", '1', '0');
        $uvSpecialToUse       = $write->getCheckSql("{$uvSpecialToDate} >= {$currentDate}", '1', '0');
        $uvSpecialFromHas     = $write->getCheckSql("{$uvSpecialFrom} IS NULL", '1', "{$uvSpecialFromUse}");
        $uvSpecialToHas       = $write->getCheckSql("{$uvSpecialTo} IS NULL", '1', "{$uvSpecialToUse}");
        $uvFinalPrice         = $write->getCheckSql("{$uvSpecialFromHas} > 0 AND {$uvSpecialToHas} > 0"
            . " AND {$uvSpecialPrice} < {$uvPrice}", $uvSpecialPrice, $uvPrice);

        $regPrice = $write->getCheckSql("uvp.vendor_price is null", $price, $uvPrice);
        $csPrice = $write->getCheckSql("uvp.vendor_price is null", $finalPrice, $uvFinalPrice);
        foreach ($canStates as $csKey=>$csLbl) {
            $csMinKey = 'udmp_'.$csKey.'_min_price';
            $csMaxKey = 'udmp_'.$csKey.'_max_price';
            $csCntKey = 'udmp_'.$csKey.'_cnt';
            $extStates = $umpSrc->getCanonicExtStates($csKey);
            if (empty($extStates)) {
                $select->columns([$csMinKey=>new \Zend_Db_Expr('NULL')]);
                $select->columns([$csMaxKey=>new \Zend_Db_Expr('NULL')]);
                $select->columns([$csCntKey=>new \Zend_Db_Expr('NULL')]);
                continue;
            }
            $extStatesSql = sprintf("'%s'", implode(',', $extStates));
            $csCaseResults = $csCaseResultsCnt = [];
            foreach ($extStates as $extState) {
                $csCaseResults["'$extState'"] = $csPrice;
                $csCaseResultsCnt["'$extState'"] = 1;
            }
            $csMinPriceSql = sprintf('IF(FIND_IN_SET(uvp.state,%s),%s,999999)', $extStatesSql, $csPrice);
            $csMaxPriceSql = sprintf('IF(FIND_IN_SET(uvp.state,%s),%s,-999999)', $extStatesSql, $csPrice);
            $csCntSql = sprintf('IF(FIND_IN_SET(uvp.state,%s),1,0)', $extStatesSql, $csPrice);
            $csMinPrice = sprintf('IF(MIN(%1$s)=999999,null,MIN(%1$s))', $csMinPriceSql);
            $csMaxPrice = sprintf('IF(MAX(%1$s)=-999999,null,MAX(%1$s))', $csMaxPriceSql);
            $csCnt = sprintf('IF(SUM(%1$s)=0,null,SUM(%1$s))', $csCntSql);
            $select->columns([$csMinKey=>$csMinPrice]);
            $select->columns([$csMaxKey=>$csMaxPrice]);
            $select->columns([$csCntKey=>$csCnt]);
        }

        $columns = $select->getPart(\Zend_Db_Select::COLUMNS);
        foreach ($columns as &$column) {
            if (@$column[2] == 'orig_price') {
                $column[1] = new \Zend_Db_Expr(sprintf('MIN(%s)', $regPrice));
            } elseif (@$column[2] == 'price') {
                $column[1] = new \Zend_Db_Expr(sprintf('MIN(%s)', $csPrice));
            } elseif (@$column[2] == 'min_price') {
                $column[1] = new \Zend_Db_Expr(sprintf('MIN(%s)', $csPrice));
            } elseif (@$column[2] == 'max_price') {
                $column[1] = new \Zend_Db_Expr(sprintf('MAX(%s)', $csPrice));
            }
        }
        unset($column);
        $select->setPart(\Zend_Db_Select::COLUMNS, $columns);

        if ($entityIds !== null) {
            $select->where('e.entity_id IN(?)', $entityIds);
        }

        $select->group(['entity_id', 'customer_group_id', 'website_id']);

        /**
         * Add additional external limitation
         */
        $this->_eventManager->dispatch(
            'prepare_catalog_product_index_select',
            [
                'select' => $select,
                'entity_field' => new \Zend_Db_Expr('e.entity_id'),
                'website_field' => new \Zend_Db_Expr('cw.website_id'),
                'store_field' => new \Zend_Db_Expr('cs.store_id')
            ]
        );

        $query = $select->insertFromSelect($this->_getDefaultFinalPriceTable(), [], false);
        $connection->query($query);
        return $this;
    }

    /**
     * Retrieve table name for custom option temporary aggregation data
     *
     * @return string
     */
    protected function _getCustomOptionAggregateTable()
    {
        return $this->tableStrategy->getTableName('catalog_product_index_price_opt_agr');
    }

    /**
     * Retrieve table name for custom option prices data
     *
     * @return string
     */
    protected function _getCustomOptionPriceTable()
    {
        return $this->tableStrategy->getTableName('catalog_product_index_price_opt');
    }

    /**
     * Prepare table structure for custom option temporary aggregation data
     *
     * @return $this
     */
    protected function _prepareCustomOptionAggregateTable()
    {
        $this->getConnection()->delete($this->_getCustomOptionAggregateTable());
        return $this;
    }

    /**
     * Prepare table structure for custom option prices data
     *
     * @return $this
     */
    protected function _prepareCustomOptionPriceTable()
    {
        $this->getConnection()->delete($this->_getCustomOptionPriceTable());
        return $this;
    }

    /**
     * Apply custom option minimal and maximal price to temporary final price index table
     *
     * @return $this
     * @SuppressWarnings(PHPMD.ExcessiveMethodLength)
     */
    protected function _applyCustomOption()
    {
        $connection = $this->getConnection();
        $coaTable = $this->_getCustomOptionAggregateTable();
        $copTable = $this->_getCustomOptionPriceTable();

        $this->_prepareCustomOptionAggregateTable();
        $this->_prepareCustomOptionPriceTable();

        $select = $connection->select()->from(
            ['i' => $this->_getDefaultFinalPriceTable()],
            ['entity_id', 'customer_group_id', 'website_id']
        )->join(
            ['cw' => $this->getTable('store_website')],
            'cw.website_id = i.website_id',
            []
        )->join(
            ['csg' => $this->getTable('store_group')],
            'csg.group_id = cw.default_group_id',
            []
        )->join(
            ['cs' => $this->getTable('store')],
            'cs.store_id = csg.default_store_id',
            []
        )->join(
            ['o' => $this->getTable('catalog_product_option')],
            'o.product_id = i.entity_id',
            ['option_id']
        )->join(
            ['ot' => $this->getTable('catalog_product_option_type_value')],
            'ot.option_id = o.option_id',
            []
        )->join(
            ['otpd' => $this->getTable('catalog_product_option_type_price')],
            'otpd.option_type_id = ot.option_type_id AND otpd.store_id = 0',
            []
        )->joinLeft(
            ['otps' => $this->getTable('catalog_product_option_type_price')],
            'otps.option_type_id = otpd.option_type_id AND otpd.store_id = cs.store_id',
            []
        )->group(
            ['i.entity_id', 'i.customer_group_id', 'i.website_id', 'o.option_id']
        );

        $optPriceType = $connection->getCheckSql('otps.option_type_price_id > 0', 'otps.price_type', 'otpd.price_type');
        $optPriceValue = $connection->getCheckSql('otps.option_type_price_id > 0', 'otps.price', 'otpd.price');
        $minPriceRound = new \Zend_Db_Expr("ROUND(i.price * ({$optPriceValue} / 100), 4)");
        $minPriceExpr = $connection->getCheckSql("{$optPriceType} = 'fixed'", $optPriceValue, $minPriceRound);
        $minPriceMin = new \Zend_Db_Expr("MIN({$minPriceExpr})");
        $minPrice = $connection->getCheckSql("MIN(o.is_require) = 1", $minPriceMin, '0');

        $tierPriceRound = new \Zend_Db_Expr("ROUND(i.base_tier * ({$optPriceValue} / 100), 4)");
        $tierPriceExpr = $connection->getCheckSql("{$optPriceType} = 'fixed'", $optPriceValue, $tierPriceRound);
        $tierPriceMin = new \Zend_Db_Expr("MIN({$tierPriceExpr})");
        $tierPriceValue = $connection->getCheckSql("MIN(o.is_require) > 0", $tierPriceMin, 0);
        $tierPrice = $connection->getCheckSql("MIN(i.base_tier) IS NOT NULL", $tierPriceValue, "NULL");

        $maxPriceRound = new \Zend_Db_Expr("ROUND(i.price * ({$optPriceValue} / 100), 4)");
        $maxPriceExpr = $connection->getCheckSql("{$optPriceType} = 'fixed'", $optPriceValue, $maxPriceRound);
        $maxPrice = $connection->getCheckSql(
            "(MIN(o.type)='radio' OR MIN(o.type)='drop_down')",
            "MAX({$maxPriceExpr})",
            "SUM({$maxPriceExpr})"
        );

        $select->columns(
            [
                'min_price' => $minPrice,
                'max_price' => $maxPrice,
                'tier_price' => $tierPrice,
            ]
        );

        $query = $select->insertFromSelect($coaTable);
        $connection->query($query);

        $select = $connection->select()->from(
            ['i' => $this->_getDefaultFinalPriceTable()],
            ['entity_id', 'customer_group_id', 'website_id']
        )->join(
            ['cw' => $this->getTable('store_website')],
            'cw.website_id = i.website_id',
            []
        )->join(
            ['csg' => $this->getTable('store_group')],
            'csg.group_id = cw.default_group_id',
            []
        )->join(
            ['cs' => $this->getTable('store')],
            'cs.store_id = csg.default_store_id',
            []
        )->join(
            ['o' => $this->getTable('catalog_product_option')],
            'o.product_id = i.entity_id',
            ['option_id']
        )->join(
            ['opd' => $this->getTable('catalog_product_option_price')],
            'opd.option_id = o.option_id AND opd.store_id = 0',
            []
        )->joinLeft(
            ['ops' => $this->getTable('catalog_product_option_price')],
            'ops.option_id = opd.option_id AND ops.store_id = cs.store_id',
            []
        );

        $optPriceType = $connection->getCheckSql('ops.option_price_id > 0', 'ops.price_type', 'opd.price_type');
        $optPriceValue = $connection->getCheckSql('ops.option_price_id > 0', 'ops.price', 'opd.price');

        $minPriceRound = new \Zend_Db_Expr("ROUND(i.price * ({$optPriceValue} / 100), 4)");
        $priceExpr = $connection->getCheckSql("{$optPriceType} = 'fixed'", $optPriceValue, $minPriceRound);
        $minPrice = $connection->getCheckSql("{$priceExpr} > 0 AND o.is_require > 1", $priceExpr, 0);

        $maxPrice = $priceExpr;

        $tierPriceRound = new \Zend_Db_Expr("ROUND(i.base_tier * ({$optPriceValue} / 100), 4)");
        $tierPriceExpr = $connection->getCheckSql("{$optPriceType} = 'fixed'", $optPriceValue, $tierPriceRound);
        $tierPriceValue = $connection->getCheckSql("{$tierPriceExpr} > 0 AND o.is_require > 0", $tierPriceExpr, 0);
        $tierPrice = $connection->getCheckSql("i.base_tier IS NOT NULL", $tierPriceValue, "NULL");

        $select->columns(
            [
                'min_price' => $minPrice,
                'max_price' => $maxPrice,
                'tier_price' => $tierPrice,
            ]
        );

        $query = $select->insertFromSelect($coaTable);
        $connection->query($query);

        $select = $connection->select()->from(
            [$coaTable],
            [
                'entity_id',
                'customer_group_id',
                'website_id',
                'min_price' => 'SUM(min_price)',
                'max_price' => 'SUM(max_price)',
                'tier_price' => 'SUM(tier_price)',
            ]
        )->group(
            ['entity_id', 'customer_group_id', 'website_id']
        );
        $query = $select->insertFromSelect($copTable);
        $connection->query($query);

        $table = ['i' => $this->_getDefaultFinalPriceTable()];
        $select = $connection->select()->join(
            ['io' => $copTable],
            'i.entity_id = io.entity_id AND i.customer_group_id = io.customer_group_id' .
            ' AND i.website_id = io.website_id',
            []
        );
        $select->columns(
            [
                'min_price' => new \Zend_Db_Expr('i.min_price + io.min_price'),
                'max_price' => new \Zend_Db_Expr('i.max_price + io.max_price'),
                'tier_price' => $connection->getCheckSql(
                    'i.tier_price IS NOT NULL',
                    'i.tier_price + io.tier_price',
                    'NULL'
                ),
            ]
        );
        $canStates = $this->_multiPriceSrc
            ->setPath('vendor_product_state_canonic')
            ->toOptionHash();
        foreach ($canStates as $csKey=>$csLbl) {
            $select->columns([
                'udmp_'.$csKey.'_min_price' => new \Zend_Db_Expr('i.udmp_'.$csKey.'_min_price + io.min_price'),
                'udmp_'.$csKey.'_max_price' => new \Zend_Db_Expr('i.udmp_'.$csKey.'_max_price + io.max_price'),
            ]);
        }
        $query = $select->crossUpdateFromSelect($table);
        $connection->query($query);

        $connection->delete($coaTable);
        $connection->delete($copTable);

        return $this;
    }

    /**
     * Mode Final Prices index to primary temporary index table
     *
     * @param int[]|null $entityIds
     * @return $this
     */
    protected function _movePriceDataToIndexTable($entityIds = null)
    {
        $columns = [
            'entity_id' => 'entity_id',
            'customer_group_id' => 'customer_group_id',
            'website_id' => 'website_id',
            'tax_class_id' => 'tax_class_id',
            'price' => 'orig_price',
            'final_price' => 'price',
            'min_price' => 'min_price',
            'max_price' => 'max_price',
            'tier_price' => 'tier_price',
        ];

        $canStates = $this->_multiPriceSrc
            ->setPath('vendor_product_state_canonic')
            ->toOptionHash();
        foreach ($canStates as $csKey=>$csLbl) {
            $columns['udmp_'.$csKey.'_min_price'] = 'udmp_'.$csKey.'_min_price';
            $columns['udmp_'.$csKey.'_max_price'] = 'udmp_'.$csKey.'_max_price';
            $columns['udmp_'.$csKey.'_cnt']       = 'udmp_'.$csKey.'_cnt';
        }

        $connection = $this->getConnection();
        $table = $this->_getDefaultFinalPriceTable();
        $select = $connection->select()->from($table, $columns);

        if ($entityIds !== null) {
            $select->where('entity_id in (?)', count($entityIds) > 0 ? $entityIds : 0);
        }

        $query = $select->insertFromSelect($this->getIdxTable(), [], false);
        $connection->query($query);

        $connection->delete($table);

        return $this;
    }

    /**
     * Retrieve table name for product tier price index
     *
     * @return string
     */
    protected function _getTierPriceIndexTable()
    {
        return $this->getTable('catalog_product_index_tier_price');
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
        return $this->tableStrategy->getTableName('catalog_product_index_price');
    }

    /**
     * @return bool
     */
    protected function hasEntity()
    {
        $reader = $this->getConnection();

        $select = $reader->select()->from(
            [$this->getTable('catalog_product_entity')],
            ['count(entity_id)']
        )->where(
            'type_id=?',
            $this->getTypeId()
        );

        return (int)$reader->fetchOne($select) > 0;
    }
}
