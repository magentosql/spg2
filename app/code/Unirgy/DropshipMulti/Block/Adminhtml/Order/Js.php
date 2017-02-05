<?php

namespace Unirgy\DropshipMulti\Block\Adminhtml\Order;

use Magento\Backend\Block\Template;
use Magento\Backend\Block\Template\Context;
use Magento\Catalog\Model\ProductFactory;
use Magento\Directory\Model\CurrencyFactory;
use Magento\Framework\App\ObjectManager;
use Magento\Framework\Registry;
use Magento\Quote\Model\Quote\Item\AbstractItem;
use Magento\Sales\Model\OrderFactory;
use Magento\Store\Model\ScopeInterface;
use Magento\Store\Model\StoreManagerInterface;
use Unirgy\DropshipMulti\Helper\Data as DropshipMultiHelperData;
use Unirgy\Dropship\Helper\Data as HelperData;
use Unirgy\Dropship\Helper\ProtectedCode;
use Unirgy\Dropship\Model\Vendor;

class Js extends Template
{
    /**
     * @var Registry
     */
    protected $_registry;

    /**
     * @var OrderFactory
     */
    protected $_orderFactory;

    /**
     * @var HelperData
     */
    protected $_hlp;

    /**
     * @var ProtectedCode
     */
    protected $_hlpPr;

    /**
     * @var DropshipMultiHelperData
     */
    protected $_multiHlp;

    /**
     * @var ProductFactory
     */
    protected $_productFactory;

    /**
     * @var CurrencyFactory
     */
    protected $_modelCurrencyFactory;

    public function __construct(Context $context, 
        Registry $frameworkRegistry, 
        OrderFactory $modelOrderFactory, 
        HelperData $helperData, 
        ProtectedCode $helperProtectedCode, 
        DropshipMultiHelperData $dropshipMultiHelperData, 
        ProductFactory $modelProductFactory,
        CurrencyFactory $modelCurrencyFactory, 
        array $data = [])
    {
        $this->_registry = $frameworkRegistry;
        $this->_orderFactory = $modelOrderFactory;
        $this->_hlp = $helperData;
        $this->_hlpPr = $helperProtectedCode;
        $this->_multiHlp = $dropshipMultiHelperData;
        $this->_productFactory = $modelProductFactory;
        $this->_modelCurrencyFactory = $modelCurrencyFactory;

        parent::__construct($context, $data);
    }

    protected $_store = null;
    protected $_vendors = null;
    protected $_vendorCounts = null;
    protected $_vendorCosts = null;
    protected $_stockCollection = [];
    protected $_vMethods = [];
    protected $_extraOrderVendors = [];
    protected $_productAttributeVendors = [];
    protected $_reassignSkipStockcheck;
    protected $_items = [];
    protected $_itemsById = [];
    protected $_stockChecked = false;
    protected $_order;

    public function setOrder($order)
    {
        $this->_order = $order;
        return $this;
    }
    public function getOrder()
    {
        $order = $this->_registry->registry('current_order');
        if ($this->_order) {
            $order = $this->_order;
        }
        return $order;
    }

    public function initItems($order)
    {
        $this->_items = $order->getAllItems();
        $stockChecked = false;
        foreach ($this->_items as $item) {
            $stockChecked = $stockChecked || $item->hasData('_udropship_stock_levels');
            $this->_itemsById[$item->getId()] = $item;
        }
        if (!$stockChecked) {
            //$this->checkStockAvailability($order);
        }
        if (!$this->getSkipStockCheck()) $this->checkStockAvailability($order);
        return $this;
    }

    public function checkStockAvailability($order)
    {
        $items = $this->_orderFactory->create()->load($order->getId())->getAllItems();
        foreach ($items as $_item) {
            $_item->setUdpoCreateQty(
                $this->_hlp->getOrderItemById($order, $_item->getId())->getUdpoCreateQty()
            );
        }

        $this->_hlpPr->reassignApplyStockAvailability($items);

        foreach ($items as $item) {
            $this->_hlp->getOrderItemById($order, $item->getId())->setData(
                '_udropship_stock_levels', $item->getData('udropship_stock_levels')
            );
        }
        return $this;
    }

    protected function _initVendors($reload=false)
    {
        if (is_null($this->_vendors) || $reload) {
            $order = $this->getOrder();
            $this->initItems($order);
            $this->_stockCollection = $this->_multiHlp->getMultiVendorData($this->_items, true);
            $this->_vendors = [];
            $this->_store = $this->_storeManager->getStore($order->getStoreId());
            $this->_reassignSkipStockcheck = $this->_scopeConfig->isSetFlag('udropship/stock/reassign_skip_stockcheck', ScopeInterface::SCOPE_STORE, $this->_store);
            $this->_extraOrderVendors = $this->_hlp->getSalesEntityVendors($order);
            $this->_productAttributeVendors = $this->getProductAttributeVendors($order);
            foreach ($this->_items as $item) {
                if ($this->isShipDummy($item)) continue;
                if ($item->getHasChildren()) {
                    $children = $item->getChildrenItems() ? $item->getChildrenItems() : $item->getChildren();
                    $childCount = 0;
                    foreach ($children as $child) {
                        $this->_getItemVendors($child, $item->getId());
                        $childCount++;
                    }
                    if (!empty($this->_vendorCounts[$item->getId()])) {
                        foreach ($this->_vendorCounts[$item->getId()] as $vId=>$vCounts) {
                            $vCount = count($vCounts);
                            if ($vCount<$childCount
                                && $vId != $this->_vendors[$item->getId()]['current']
                            ) {
                                unset($this->_vendors[$item->getId()]['all'][$vId]);
                            }
                        }
                    } else {
                        $this->_vendors[$item->getId()]['all'] = [];
                    }
                } else {
                    $this->_getItemVendors($item);
                }
            }
            if ($this->_isAllowedViewCost([])) {
                foreach ($this->_vendors as &$vendors) {
                    foreach ($vendors['all'] as &$vData) {
                        $vData['name'] = $vData['name'].' - '.$this->formatBasePrice($this->getOrder(), $vData['cost']);
                    }
                }
            }
            $this->_filterVendors();
            $this->_initVendorShippingMethods();
        }
        return $this;
    }

    public function isShipDummy($item)
    {
        if ($item instanceof AbstractItem) {
            if ($item->getHasChildren() && $item->isShipSeparately()) {
                return true;
            }

            if ($item->getHasChildren() && !$item->isShipSeparately()) {
                return false;
            }

            if ($item->getParentItem() && $item->isShipSeparately()) {
                return false;
            }

            if ($item->getParentItem() && !$item->isShipSeparately()) {
                return true;
            }
        } else {
            return $item->isDummy(true);
        }
    }

    public function getProductAttributeVendors($order)
    {
        $hlp = $this->_hlp;
        $pIdByItemId = [];
        foreach ($order->getAllItems() as $item) {
            $pIdByItemId[$item->getId()] = $item->getProductId();
        }
        $vendorsByItemId = [];
        $products = $this->_productFactory->create()->getCollection()
            ->addAttributeToSelect('udropship_vendor')
            ->addIdFilter($pIdByItemId);
        foreach ($pIdByItemId as $itemId=>$pId) {
            if ($p = $products->getItemById($pId)) {
                $vId = $p->getUdropshipVendor();
                if (!$hlp->getVendor($vId)->getId()) {
                    $vId = $this->_scopeConfig->getValue('udropship/vendor/local_vendor', ScopeInterface::SCOPE_STORE, $order->getStoreId());
                }
                if ($hlp->getVendor($vId)->getId()) {
                    $vendorsByItemId[$itemId] = $vId;
                }
            }
        }
        return $vendorsByItemId;
    }

    public function getVendorsJson()
    {
        $this->_initVendors();
        return \Zend_Json::encode($this->_vendors);
    }

    public function getVendorCostsJson()
    {
        $this->_initVendors();
        return \Zend_Json::encode($this->_vendorCosts);
    }

    public function getItemVendorSelect($itemId, $data)
    {
        $this->_initVendors();
        $data['options'] = @$this->_vendors[$itemId]['all'];
        $data['selected'] = @$this->_vendors[$itemId]['current'];
        return $this->_multiHlp->getVendorSelect($data);
    }

    protected function _filterVendors()
    {
        if ($this->_scopeConfig->getValue('udropship/stock/manual_udpo_hide_failed_vendors', ScopeInterface::SCOPE_STORE, $this->_store)) {
            foreach ($this->_vendors as $itemId => &$vData) {
                $unsVids = [];
                foreach ($vData['all'] as $vId => $dummy) {
                    $item = $this->_itemsById[$itemId];
                    if ($vId != $vData['current'] && $item->hasData('_udropship_stock_levels')) {
                        if ($item->getProductType()=='configurable') {
                            $children = $item->getChildrenItems() ? $item->getChildrenItems() : $item->getChildren();
                            foreach ($children as $child) {
                                if (!$child->getData("_udropship_stock_levels/$vId/status")
                                    && $child->getUdropshipVendor()!=$vId
                                ) {
                                    $unsVids[] = $vId;
                                }
                                break;
                            }
                        } else {
                            if (!$item->getData("_udropship_stock_levels/$vId/status")
                                && !$item->getUdropshipVendor()!=$vId
                            ) {
                                $unsVids[] = $vId;
                            }
                        }
                    }
                }
                foreach ($unsVids as $vId) {
                    unset($vData['all'][$vId]);
                }
            }
        }
        return $this;
    }

    public function getIsPoPage()
    {
        return $this->_registry->registry('current_udpo') || $this->_registry->registry('is_udpo_page');
    }

    protected function _isAllowedViewCost($vp)
    {
        return $this->getIsPoPage()
            ? ObjectManager::getInstance()->get('Magento\Backend\Model\Auth\Session')->isAllowed('sales/order/actions/udpo_view_cost')
            : ObjectManager::getInstance()->get('Magento\Backend\Model\Auth\Session')->isAllowed('sales/order/actions/udpo_view_order_cost');
    }

    protected function _addVendorNameCost(&$aggregator, $vp, $priceItem, $escape=true)
    {
        $hlp = $this->_hlp;
        if ($vp instanceof Vendor) {
            $cost = $hlp->getItemBaseCost($priceItem);
        } else {
            if ($this->_hlp->isUdmultiPriceAvailable()) {
                $cost = $hlp->getItemBaseCost($priceItem, $vp->getVendorPrice());
            } else {
                $cost = $hlp->getItemBaseCost($priceItem, $vp->getVendorCost());
            }
        }
        $aggregator['cost'] = $cost;
        $name = $vp->getVendorName();
        if ($this->_isAllowedViewCost($vp)) {
            $name .= ' - '.$this->formatBasePrice($this->getOrder(), $cost);
        }
        $aggregator['name'] = $this->escapeHtml($name);
        return $aggregator;
    }
    protected function _getItemVendors($item, $aItemId=null)
    {
        $hlp = $this->_hlp;
        $itemId = !is_null($aItemId) ? $aItemId : $item->getId();
        $priceItem = (($parentItem = $item->getParentItem()) && $parentItem->getProductType()=='configurable') ? $parentItem : $item;
        $currentVendor = $item->hasUdpoUdropshipVendor() ? $item->getUdpoUdropshipVendor() : $item->getUdropshipVendor();
        $this->_vendors[$itemId]['current'] = $currentVendor;
        foreach ($this->_stockCollection as $vp) {
            $vpVid = $vp->getVendorId();
            $v = $hlp->getVendor($vpVid);
            if ($vp->getProductId()==$item->getProductId()
                && ($vpVid==$currentVendor
                    || is_null($vp->getStockQty())
                    || $vp->getStockQty()>=$item->getQtyOrdered()
                    || $v->getStockcheckCallback()
                    || $this->_reassignSkipStockcheck
                )
            ) {
                if (empty($this->_vMethods[$vpVid])) {
                    $this->_vMethods[$vpVid] = [];
                }
                if (empty($this->_vendors[$itemId]['all'][$vpVid])) {
                    $this->_vendors[$itemId]['all'][$vpVid] = [
                        'name' => $this->escapeHtml($vp->getVendorName()),
                        'vendor_sku' => $vp->getVendorSku() ? $vp->getVendorSku() : $item->getSku(),
                        'methods' => &$this->_vMethods[$vpVid],
                    ];
                }
                if ($this->_hlp->isUdmultiPriceAvailable()) {
                    $this->_vendorCosts[$item->getId()][$vpVid] = $hlp->getItemBaseCost($priceItem, $vp->getVendorPrice());
                } else {
                    $this->_vendorCosts[$item->getId()][$vpVid] = $hlp->getItemBaseCost($priceItem, $vp->getVendorCost());
                }
                if ($aItemId) {
                    if (empty($this->_vendors[$itemId]['all'][$vpVid]['cost'])) {
                        $this->_vendors[$itemId]['all'][$vpVid]['cost'] = 0;
                    }
                    $this->_vendorCounts[$itemId][$vpVid][$item->getId()] = 1;
                    $this->_vendors[$itemId]['all'][$vpVid]['cost'] += $this->_vendorCosts[$item->getId()][$vpVid];
                } else {
                    $this->_vendors[$itemId]['all'][$vpVid]['cost'] = $this->_vendorCosts[$itemId][$vpVid];
                }
            }
        }
        if (empty($this->_vendors[$itemId]['current'])) {
            if (!empty($this->_vendors[$itemId]['all'])) {
                reset($this->_vendors[$itemId]['all']);
                $currentVendor = $this->_vendors[$itemId]['current'] = key($this->_vendors[$itemId]['all']);
            }
        }
        if (empty($this->_vendors[$itemId]['all'][$currentVendor])) {
            $v = $hlp->getVendor($currentVendor);
            $this->_vendors[$itemId]['all'][$currentVendor] = [
                'name' => $this->escapeHtml($v->getVendorName()),
                'methods' => &$this->_vMethods[$currentVendor]
            ];
            if (!isset($this->_vendorCosts[$item->getId()][$currentVendor])) {
                $this->_vendorCosts[$item->getId()][$currentVendor] = $hlp->getItemBaseCost($priceItem);
                if ($aItemId) {
                    if (empty($this->_vendors[$itemId]['all'][$currentVendor]['cost'])) {
                        $this->_vendors[$itemId]['all'][$currentVendor]['cost'] = 0;
                    }
                    $this->_vendorCounts[$itemId][$currentVendor][$item->getId()] = 1;
                    $this->_vendors[$itemId]['all'][$currentVendor]['cost'] += $this->_vendorCosts[$item->getId()][$currentVendor];
                } else {
                    $this->_vendors[$itemId]['all'][$currentVendor]['cost'] = $this->_vendorCosts[$itemId][$currentVendor];
                }
            }
        }
        if (!empty($this->_extraOrderVendors[$itemId])) {
            foreach ($this->_extraOrderVendors[$itemId] as $vId=>$_dummy) {
                if (empty($this->_vendors[$itemId]['all'][$vId])) {
                    $v = $hlp->getVendor($vId);
                    $this->_vendors[$itemId]['all'][$vId] = [
                        'name' => $this->escapeHtml($v->getVendorName()),
                        'methods' => &$this->_vMethods[$vId]
                    ];
                    if (!isset($this->_vendorCosts[$item->getId()][$vId])) {
                        $this->_vendorCosts[$item->getId()][$vId] = $hlp->getItemBaseCost($priceItem);
                        if ($aItemId) {
                            if (empty($this->_vendors[$itemId]['all'][$vId]['cost'])) {
                                $this->_vendors[$itemId]['all'][$vId]['cost'] = 0;
                            }
                            $this->_vendorCounts[$itemId][$vId][$item->getId()] = 1;
                            $this->_vendors[$itemId]['all'][$vId]['cost'] += $this->_vendorCosts[$item->getId()][$vId];
                        } else {
                            $this->_vendors[$itemId]['all'][$vId]['cost'] = $this->_vendorCosts[$itemId][$vId];
                        }
                    }
                }
            }
        }
        if (!empty($this->_productAttributeVendors[$itemId])) {
            $vId = $this->_productAttributeVendors[$itemId];
            if (empty($this->_vendors[$itemId]['all'][$vId])) {
                $v = $hlp->getVendor($vId);
                $this->_vendorCounts[$itemId][$vId][$item->getId()] = 1;
                $this->_vendors[$itemId]['all'][$vId] = [
                    'methods' => &$this->_vMethods[$vId]
                ];
                $this->_addVendorNameCost(
                    $this->_vendors[$itemId]['all'][$vId],
                    $v, $priceItem
                );
            }
        }

    }

    public function formatBasePrice($order, $cost)
    {
        if (!$order->getBaseCurrency()) {
            $order->setBaseCurrency($this->_modelCurrencyFactory->create()->load($order->getBaseCurrencyCode()));
        }
        return $order->getBaseCurrency()->formatTxt($cost);
    }

    protected function _initVendorShippingMethods()
    {
        $this->_hlp->initVendorShippingMethodsForHtmlSelect($this->getOrder(), $this->_vMethods);
    }
}