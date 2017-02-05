<?php
/**
 * Copyright © 2016 Magento. All rights reserved.
 * See COPYING.txt for license details.
 */

// @codingStandardsIgnoreFile

namespace Unirgy\DropshipMultiPrice\Model\PriceIndexer;

/**
 * GiftCard product price indexer resource model
 *
 * @author      Magento Core Team <core@magentocommerce.com>
 */
class GiftCard extends DefaultPrice
{
    /**
     * Prepare giftCard products prices in temporary index table
     *
     * @param int|array $entityIds  the entity ids limitation
     * @return $this
     * @SuppressWarnings(PHPMD.ExcessiveMethodLength)
     */
    protected function _prepareFinalPriceData($entityIds = null)
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

        $rowIdField = $this->_hlp->rowIdField();

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
        );
        $this->_addWebsiteJoinToSelect($select, true);
        $this->_addProductWebsiteJoinToSelect($select, 'cw.website_id', 'e.entity_id');
        $select->columns(
            ['website_id'],
            'cw'
        )->columns(
            ['tax_class_id' => new \Zend_Db_Expr('0')]
        )->where(
            'e.type_id = ?',
            $this->getTypeId()
        );

        // add enable products limitation
        $statusCond = $connection->quoteInto('=?', \Magento\Catalog\Model\Product\Attribute\Source\Status::STATUS_ENABLED);
        $this->_addAttributeToSelect($select, 'status', 'e.'.$rowIdField, 'cs.store_id', $statusCond, true);

        $allowOpenAmount = $this->_addAttributeToSelect($select, 'allow_open_amount', 'e.'.$rowIdField, 'cs.store_id');
        $openAmountMin = $this->_addAttributeToSelect($select, 'open_amount_min', 'e.'.$rowIdField, 'cs.store_id');
        //        $openAmounMax    = $this->_addAttributeToSelect($select, 'open_amount_max', 'e.entity_id', 'cs.store_id');


        $attrAmounts = $this->_getAttribute('giftcard_amounts');
        // join giftCard amounts table
        $select->joinLeft(
            ['gca' => $this->getTable('magento_giftcard_amount')],
            "gca.{$rowIdField} = e.{$rowIdField} AND gca.attribute_id = " .
            $attrAmounts->getAttributeId() .
            ' AND (gca.website_id = cw.website_id OR gca.website_id = 0)',
            []
        );

        $amountsExpr = 'MIN(' . $connection->getCheckSql('gca.value_id IS NULL', 'NULL', 'gca.value') . ')';

        $openAmountExpr = 'MIN(' . $connection->getCheckSql(
                $allowOpenAmount . ' = 1',
                $connection->getCheckSql($openAmountMin . ' > 0', $openAmountMin, '0'),
                'NULL'
            ) . ')';

        $priceExpr = new \Zend_Db_Expr(
            'ROUND(' . $connection->getCheckSql(
                $openAmountExpr . ' IS NULL',
                $connection->getCheckSql($amountsExpr . ' IS NULL', '0', $amountsExpr),
                $connection->getCheckSql(
                    $amountsExpr . ' IS NULL',
                    $openAmountExpr,
                    $connection->getCheckSql($openAmountExpr . ' > ' . $amountsExpr, $amountsExpr, $openAmountExpr)
                )
            ) . ', 4)'
        );

        $select->group(
            ['e.entity_id', 'cg.customer_group_id', 'cw.website_id']
        )->columns(
            [
                'price' => new \Zend_Db_Expr('NULL'),
                'final_price' => $priceExpr,
                'min_price' => $priceExpr,
                'max_price' => new \Zend_Db_Expr('NULL'),
                'tier_price' => new \Zend_Db_Expr('NULL'),
                'base_tier' => new \Zend_Db_Expr('NULL'),
            ]
        );

        $canStates = $this->_multiPriceSrc
            ->setPath('vendor_product_state_canonic')
            ->toOptionHash();
        $csPrice = $priceExpr;
        foreach ($canStates as $csKey=>$csLbl) {
            $csMinKey = 'udmp_'.$csKey.'_min_price';
            $csMaxKey = 'udmp_'.$csKey.'_max_price';
            $csCntKey = 'udmp_'.$csKey.'_cnt';
            $extStates = $this->_multiPriceSrc->getCanonicExtStates($csKey);
            if (empty($extStates)) {
                $select->columns(array($csMinKey=>new \Zend_Db_Expr('NULL')));
                $select->columns(array($csMaxKey=>new \Zend_Db_Expr('NULL')));
                $select->columns(array($csCntKey=>new \Zend_Db_Expr('NULL')));
                continue;
            }
            $extStatesSql = sprintf("'%s'", implode(',', $extStates));
            $csCaseResults = $csCaseResultsCnt = array();
            foreach ($extStates as $extState) {
                $csCaseResults["'$extState'"] = $csPrice;
                $csCaseResultsCnt["'$extState'"] = 1;
            }
            $csMinPriceSql = sprintf('IF(FIND_IN_SET(uvp.state,%s),%s,999999)', $extStatesSql, $csPrice);
            $csMaxPriceSql = sprintf('IF(FIND_IN_SET(uvp.state,%s),%s,-999999)', $extStatesSql, $csPrice);
            $csCntSql = sprintf('IF(FIND_IN_SET(uvp.state,%s),1,0)', $extStatesSql);
            //$csMinPrice = sprintf('IF(MIN(%1$s)=999999,null,MIN(%1$s))', $csMinPriceSql);
            //$csMaxPrice = sprintf('IF(MAX(%1$s)=-999999,null,MAX(%1$s))', $csMaxPriceSql);
            $csCnt = sprintf('IF(SUM(%1$s)=0,null,SUM(%1$s))', $csCntSql);
            $select->columns(array($csMinKey=>new \Zend_Db_Expr('NULL')));
            $select->columns(array($csMaxKey=>new \Zend_Db_Expr('NULL')));
            $select->columns(array($csCntKey=>new \Zend_Db_Expr('NULL')));
        }

        $columns = $select->getPart(\Zend_Db_Select::COLUMNS);
        foreach ($columns as &$column) {
            if (@$column[2] == 'min_price') {
                $column[1] = new \Zend_Db_Expr(sprintf('%s', $csPrice));
            } elseif (@$column[2] == 'max_price') {
                $column[1] = new \Zend_Db_Expr(sprintf('%s', $csPrice));
            }
        }
        unset($column);
        $select->setPart(\Zend_Db_Select::COLUMNS, $columns);

        if (!is_null($entityIds)) {
            $select->where('e.entity_id IN(?)', $entityIds);
        }

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

        $query = $select->insertFromSelect($this->_getDefaultFinalPriceTable());
        $connection->query($query);

        return $this;
    }
}
