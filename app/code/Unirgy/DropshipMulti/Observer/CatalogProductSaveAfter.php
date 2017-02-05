<?php

namespace Unirgy\DropshipMulti\Observer;

use Magento\Customer\Model\Group;
use Magento\CatalogInventory\Api\StockConfigurationInterface;
use Magento\CatalogInventory\Api\StockIndexInterface;
use Magento\CatalogInventory\Api\StockItemRepositoryInterface;
use Magento\CatalogInventory\Api\StockRegistryInterface;
use Magento\Framework\Event\Observer as EventObserver;

class CatalogProductSaveAfter extends \Magento\CatalogInventory\Observer\SaveInventoryDataObserver
{
    protected $_hlp;
    protected $_multiHlp;

    public function __construct(
        \Unirgy\DropshipMulti\Helper\Data $udmultiHelper,
        \Unirgy\Dropship\Helper\Data $udropshipHelper,
        StockIndexInterface $stockIndex,
        StockConfigurationInterface $stockConfiguration,
        StockRegistryInterface $stockRegistry,
        StockItemRepositoryInterface $stockItemRepository
    )
    {
        $this->_multiHlp = $udmultiHelper;
        $this->_hlp = $udropshipHelper;

        parent::__construct($stockIndex, $stockConfiguration, $stockRegistry, $stockItemRepository);
    }

    public function execute(EventObserver $observer)
    {
        $product = $observer->getEvent()->getProduct();

        $data = $product->getUpdateUdmultiVendors();
        if (!(empty($data['delete']) && empty($data['insert']) && empty($data['update']))) {

            $res = $this->_hlp->rHlp();
            $write = $res->getConnection();
            $table = $res->getTableName('udropship_vendor_product');

            if (!empty($data['delete'])) {
                $write->delete($table, $write->quoteInto('vendor_product_id in (?)', $data['delete']));
            }

            if (!empty($data['insert'])) {
                foreach ($data['insert'] as $v) {
                    $v['product_id'] = $product->getId();
                    if (!array_key_exists('status', $v)) {
                        $v['status'] = $this->_multiHlp->getDefaultMvStatus();
                    }
                    $_v = $this->_hlp->rHlp()->myPrepareDataForTable($table, $v);
                    $write->insert($table, $_v);
                    $lastUvpId = $write->lastInsertId();
                    if (isset($v['group_price']) && is_array($v['group_price'])) {
                        $gpTable = $res->getTableName('udmulti_group_price');
                        foreach ($v['group_price'] as $gpKey => $gp) {
                            if ($gpKey==='$ROW' || $gpKey==='$$ROW') continue;
                            $gp['vendor_id'] = $v['vendor_id'];
                            $gp['product_id'] = $product->getId();
                            $gp['all_groups'] = 0;
                            if ($gp['customer_group_id'] == Group::CUST_GROUP_ALL) {
                                $gp['all_groups'] = 1;
                                $gp['customer_group_id'] = 0;
                            }
                            $gp['vendor_product_id'] = $lastUvpId;
                            $insertGroup = $this->_hlp->rHlp()->myPrepareDataForTable($gpTable, $gp);
                            $write->insert($gpTable, $insertGroup);
                        }
                    }
                    if (isset($v['tier_price']) && is_array($v['tier_price'])) {
                        $tpTable = $res->getTableName('udmulti_tier_price');
                        foreach ($v['tier_price'] as $tpKey => $tp) {
                            if ($tpKey==='$ROW' || $tpKey==='$$ROW') continue;
                            $tp['vendor_id'] = $v['vendor_id'];
                            $tp['product_id'] = $product->getId();
                            $tp['all_groups'] = 0;
                            if ($tp['customer_group_id'] == Group::CUST_GROUP_ALL) {
                                $tp['all_groups'] = 1;
                                $tp['customer_group_id'] = 0;
                            }
                            $tp['vendor_product_id'] = $lastUvpId;
                            $insertGroup = $this->_hlp->rHlp()->myPrepareDataForTable($tpTable, $tp);
                            $write->insert($tpTable, $insertGroup);
                        }
                    }
                }
            }

            if (!empty($data['update'])) {
                foreach ($data['update'] as $id=>$v) {
                    $_v = $this->_hlp->rHlp()->myPrepareDataForTable($table, $v);
                    $write->update($table, $_v, 'vendor_product_id='.(int)$id);
                    if (isset($v['group_price']) && is_array($v['group_price'])) {
                        $gpTable = $res->getTableName('udmulti_group_price');
                        $_gpValIds = [];
                        foreach ($v['group_price'] as $gpKey => $gp) {
                            if ($gpKey==='$ROW' || $gpKey==='$$ROW') continue;
                            if (isset($gp['value_id'])) $_gpValIds[] = $gp['value_id'];
                        }
                        $gpDelCond = ['vendor_id=?'=>$v['vendor_id'],'product_id=?'=>$product->getId()];
                        if ($_gpValIds) {
                            $gpDelCond['value_id not in (?)']=$_gpValIds;
                        }
                        $write->delete($gpTable, $gpDelCond);
                        foreach ($v['group_price'] as $gpKey => $gp) {
                            if ($gpKey==='$ROW' || $gpKey==='$$ROW') continue;
                            $gp['vendor_id'] = $v['vendor_id'];
                            $gp['product_id'] = $product->getId();
                            $gp['all_groups'] = 0;
                            if ($gp['customer_group_id'] == Group::CUST_GROUP_ALL) {
                                $gp['all_groups'] = 1;
                                $gp['customer_group_id'] = 0;
                            }
                            $gp['vendor_product_id'] = $id;
                            $insertGroup = $this->_hlp->rHlp()->myPrepareDataForTable($gpTable, $gp);
                            if (!empty($gp['value_id'])) {
                                $write->update($gpTable, $insertGroup, 'value_id='.(int)$gp['value_id']);
                            } else {
                                $write->insert($gpTable, $insertGroup);
                            }
                        }
                    }
                    if (isset($v['tier_price']) && is_array($v['tier_price'])) {
                        $tpTable = $res->getTableName('udmulti_tier_price');
                        $_tpValIds = [];
                        foreach ($v['tier_price'] as $tpKey => $tp) {
                            if ($tpKey==='$ROW' || $tpKey==='$$ROW') continue;
                            if (isset($tp['value_id'])) $_tpValIds[] = $tp['value_id'];
                        }
                        $tpDelCond = ['vendor_id=?'=>$v['vendor_id'],'product_id=?'=>$product->getId()];
                        if ($_tpValIds) {
                            $tpDelCond['value_id not in (?)']=$_tpValIds;
                        }
                        $write->delete($tpTable, $tpDelCond);
                        foreach ($v['tier_price'] as $tpKey => $tp) {
                            if ($tpKey==='$ROW' || $tpKey==='$$ROW') continue;
                            $tp['vendor_id'] = $v['vendor_id'];
                            $tp['product_id'] = $product->getId();
                            $tp['all_groups'] = 0;
                            if ($tp['customer_group_id'] == Group::CUST_GROUP_ALL) {
                                $tp['all_groups'] = 1;
                                $tp['customer_group_id'] = 0;
                            }
                            $tp['vendor_product_id'] = $id;
                            $insertTier = $this->_hlp->rHlp()->myPrepareDataForTable($tpTable, $tp);
                            if (!empty($tp['value_id'])) {
                                $write->update($tpTable, $insertTier, 'value_id='.(int)$tp['value_id']);
                            } else {
                                $write->insert($tpTable, $insertTier);
                            }
                        }

                    }
                }
            }
        }
        return parent::execute($observer);
    }
}
