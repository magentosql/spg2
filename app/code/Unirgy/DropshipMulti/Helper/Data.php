<?php
/**
 * Unirgy LLC
 *
 * NOTICE OF LICENSE
 *
 * This source file is subject to the EULA
 * that is bundled with this package in the file LICENSE.txt.
 * It is also available through the world-wide-web at this URL:
 * http://www.unirgy.com/LICENSE-M1.txt
 *
 * @category   Unirgy
 * @package    Unirgy_DropshipSplit
 * @copyright  Copyright (c) 2008-2009 Unirgy LLC (http://www.unirgy.com)
 * @license    http:///www.unirgy.com/LICENSE-M1.txt
 */

namespace Unirgy\DropshipMulti\Helper;

use Magento\CatalogInventory\Helper\Data as CatalogInventoryHelperData;
use Magento\CatalogInventory\Model\Stock;
use Magento\CatalogInventory\Model\Stock\Item;
use Magento\CatalogInventory\Model\Stock\ItemFactory;
use Magento\Catalog\Model\Product;
use Magento\Customer\Model\GroupFactory;
use Magento\Framework\App\Helper\AbstractHelper;
use Magento\Framework\App\Helper\Context;
use Magento\Framework\DataObject;
use Magento\Framework\Event\ManagerInterface;
use Magento\Sales\Model\Convert\OrderFactory as ConvertOrderFactory;
use Magento\Sales\Model\OrderFactory;
use Magento\Sales\Model\ResourceModel\Order\Shipment\Collection;
use Magento\Store\Model\ScopeInterface;
use Unirgy\Dropship\Helper\Data as HelperData;
use Unirgy\Dropship\Model\Source;
use Unirgy\Dropship\Model\Vendor\ProductFactory;

class Data extends AbstractHelper
{
    public $isUdmultiLoadToCollection = true;
    /**
     * @var GroupFactory
     */
    protected $_customerGroupFactory;

    /**
     * @var ProductFactory
     */
    protected $_vendorProductFactory;

    /**
     * @var Source
     */
    protected $_src;

    /**
     * @var HelperData
     */
    protected $_hlp;

    /**
     * @var ItemFactory
     */
    protected $_stockItemFactory;

    /**
     * @var OrderFactory
     */
    protected $_orderFactory;

    /**
     * @var Collection
     */
    protected $_shipmentCollection;

    /**
     * @var ConvertOrderFactory
     */
    protected $_convertOrderFactory;

    /**
     * @var CatalogInventoryHelperData
     */
    protected $_catalogInventoryHelperData;

    protected $_tpFactory;

    public function __construct(Context $context, 
        GroupFactory $modelGroupFactory, 
        ProductFactory $vendorProductFactory,
        Source $udropshipSource,
        HelperData $udropshipHelper,
        ItemFactory $stockItemFactory, 
        OrderFactory $modelOrderFactory, 
        Collection $shipmentCollection, 
        ConvertOrderFactory $convertOrderFactory,
        CatalogInventoryHelperData $catalogInventoryHelperData,
        \Unirgy\DropshipMulti\Model\TierPriceFactory $tierPriceFactory
    )
    {
        $this->_customerGroupFactory = $modelGroupFactory;
        $this->_vendorProductFactory = $vendorProductFactory;
        $this->_src = $udropshipSource;
        $this->_hlp = $udropshipHelper;
        $this->_stockItemFactory = $stockItemFactory;
        $this->_orderFactory = $modelOrderFactory;
        $this->_shipmentCollection = $shipmentCollection;
        $this->_convertOrderFactory = $convertOrderFactory;
        $this->_catalogInventoryHelperData = $catalogInventoryHelperData;
        $this->_tpFactory = $tierPriceFactory;

        parent::__construct($context);
    }

    protected $_customerGroups;
    public function getCustomerGroups()
    {
        if ($this->_customerGroups===null) {
            $this->_customerGroups = [];
            $collection = $this->_customerGroupFactory->create()->getCollection();
            foreach ($collection as $item) {
                $this->_customerGroups[$item->getId()] = $item->getCustomerGroupCode();
            }
        }
        return $this->_customerGroups;
    }

    protected $_multiVendorData = [];

    public function isActive($store=null)
    {
        $method = $this->_hlp->getScopeConfig('udropship/stock/availability', $store);
        $config = $this->_hlp->config()->getAvailabilityMethod($method);
        return $config && @$config['multi'];
    }
    public function isActiveReassign($store=null)
    {
        $method = $this->_hlp->getScopeConfig('udropship/stock/reassign_availability', $store);
        $config = $this->_hlp->config()->getAvailabilityMethod($method);
        return $config && @$config['multi'];
    }

    public function clearMultiVendorData()
    {
        $this->_multiVendorData = [];
        return $this;
    }

    public function getVendorSku($pId, $vId, $defaultSku=null)
    {
        $collection = $this->_vendorProductFactory->create()->getCollection()
            ->addProductFilter($pId)
            ->addVendorFilter($vId);
        foreach ($collection as $item) {
            return $item->getVendorSku() ? $item->getVendorSku() : $defaultSku;
        }
        return $defaultSku;
    }

    public function getActiveMultiVendorData($items, $joinVendors=false, $force=false)
    {
        return $this->_getMultiVendorData($items, $joinVendors, $force, true);
    }

    public function getMultiVendorData($items, $joinVendors=false, $force=false)
    {
        return $this->_getMultiVendorData($items, $joinVendors, $force, false);
    }
    protected function _getMultiVendorData($items, $joinVendors=false, $force=false, $isActive=false)
    {
        $key = $joinVendors ? 'vendors,' : 'novendors,';
        $key .= $isActive ? 'active,' : 'inactive,';
        $productIds = [];
        foreach ($items as $item) {
            if ($item instanceof DataObject) {
                $pId = $item->hasProductId() ? $item->getProductId() : $item->getEntityId();
                $key .= $pId.':'.$item->getQty().',';
                $productIds[] = $pId;
            } elseif (is_scalar($item)) {
                $key .= $item;
                $productIds[] = $item;
            }
        }
        if (empty($this->_multiVendorData[$key]) || $force) {
            $collection = $this->_vendorProductFactory->create()->getCollection()
                ->addProductFilter($productIds);
            if ($isActive) {
                $collection->getSelect()->where('main_table.status>0');
            }
            if ($joinVendors || $isActive) {
                $res = $this->_hlp->rHlp();
                $collection->getSelect()
                    ->join(
                        ['v'=>$res->getTableName('udropship_vendor')],
                        'v.vendor_id=main_table.vendor_id',
                        $joinVendors ? '*' : []
                    );
                if ($isActive) {
                    $collection->getSelect()->where("v.status='A'");
                }
            }
            $this->_multiVendorData[$key] = $collection;
        }
        return $this->_multiVendorData[$key];
    }

    public function getActiveMvGroupPrice($items, $joinVendors=false, $force=false)
    {
        return $this->_getMvGroupPrice($items, $joinVendors, $force, true);
    }
    public function getMvGroupPrice($items, $joinVendors=false, $force=false)
    {
        return $this->_getMvGroupPrice($items, $joinVendors, $force, false);
    }
    protected $_mvGroupPrice = [];
    protected function _getMvGroupPrice($items, $joinVendors=false, $force=false, $isActive=false)
    {
        $key = $joinVendors ? 'vendors,' : 'novendors,';
        $key .= $isActive ? 'active,' : 'inactive,';
        $productIds = [];
        foreach ($items as $item) {
            if ($item instanceof DataObject) {
                $pId = $item->hasProductId() ? $item->getProductId() : $item->getEntityId();
                $key .= $pId.':'.$item->getQty().',';
                $productIds[] = $pId;
            } elseif (is_scalar($item)) {
                $key .= $item;
                $productIds[] = $item;
            }
        }
        if (empty($this->_mvGroupPrice[$key]) || $force) {
            $collection = $this->_modelGrouppriceFactory->create()->getCollection()
                ->joinMultiVendorData($isActive, $joinVendors)
                ->addProductFilter($productIds);
            $this->_mvGroupPrice[$key] = $collection;
        }
        return $this->_mvGroupPrice[$key];
    }

    public function getActiveMvTierPrice($items, $joinVendors=false, $force=false)
    {
        return $this->_getMvTierPrice($items, $joinVendors, $force, true);
    }
    public function getMvTierPrice($items, $joinVendors=false, $force=false)
    {
        return $this->_getMvTierPrice($items, $joinVendors, $force, false);
    }
    protected $_mvTierPrice = [];
    protected function _getMvTierPrice($items, $joinVendors=false, $force=false, $isActive=false)
    {
        $key = $joinVendors ? 'vendors,' : 'novendors,';
        $key .= $isActive ? 'active,' : 'inactive,';
        $productIds = [];
        foreach ($items as $item) {
            if ($item instanceof DataObject) {
                $pId = $item->hasProductId() ? $item->getProductId() : $item->getEntityId();
                $key .= $pId.':'.$item->getQty().',';
                $productIds[] = $pId;
            } elseif (is_scalar($item)) {
                $key .= $item;
                $productIds[] = $item;
            }
        }
        if (empty($this->_mvTierPrice[$key]) || $force) {
            $collection = $this->_tpFactory->create()->getCollection()
                ->joinMultiVendorData($isActive, $joinVendors)
                ->addProductFilter($productIds);
            $this->_mvTierPrice[$key] = $collection;
        }
        return $this->_mvTierPrice[$key];
    }

    public function getActiveUdmultiStock($productId, $force=false)
    {
        return $this->_getUdmultiStock($productId, $force, true);
    }

    public function getUdmultiStock($productId, $force=false)
    {
        return $this->_getUdmultiStock($productId, $force, false);
    }

    protected function _getUdmultiStock($productId, $force=false, $isActive=false)
    {
        $vCollection = $this->_getMultiVendorData([$productId], false, $force, $isActive);
        $udmArr = [];
        $qty = 0;
        foreach ($vCollection as $vp) {
            $udmArr[$vp->getVendorId()] = $vp->getStockQty();
        }
        return $udmArr;
    }

    public function getActiveUdmultiAvail($productId, $force=false)
    {
        return $this->_getUdmultiAvail($productId, $force, true);
    }

    public function getUdmultiAvail($productId, $force=false)
    {
        return $this->_getUdmultiAvail($productId, $force, false);
    }

    protected function _getUdmultiAvail($productId, $force=false, $isActive=false)
    {
        $vCollection = $this->_getMultiVendorData([$productId], false, $force, $isActive);
        $udmArr = [];
        foreach ($vCollection as $vp) {
            $udmArr[$vp->getVendorId()] = [
                'product_id'  => $vp->getProductId(),
                'stock_qty'   => $vp->getStockQty(),
                'backorders'  => $vp->getData('backorders'),
                'status'      => $vp->getData('status'),
            ];
        }
        return $udmArr;
    }

    /**
    * Add or subtract qty from vendor-product stock
    *
    * @param mixed $item
    * @param float $qty use negative to subtract stock
    */
    public function updateItemStock($item, $qty, $transaction=null)
    {
        $pId = $item->getProductId();
        $vId = $item->getUdropshipVendor();
        if (!$vId && $item->getOrderItem()) {
            $vId = $item->getOrderItem()->getUdropshipVendor();
        }

        if (!$pId || !$vId) {
            // should never happen
            return;
            throw new \Exception(__('Invalid data: vendor_id=%1, product_id=%2', $vId, $pId));
        }

        $v = $this->_hlp->getVendor($vId);
        if ($v->getStockcheckMethod()) {
            return; // custom stock notification used
        }

        $collection = $this->_vendorProductFactory->create()->getCollection()
            ->addVendorFilter($vId)
            ->addProductFilter($pId);

        if ($collection->count()!==1) {
            // for now silent fail, if the vendor-product association was deleted after order
            return;
            throw new \Exception(__('Failed to update vendor stock: vendor is not associated with this item (%1)', $item->getSku()));
        }

        $totMethod = $this->scopeConfig->getValue('udropship/stock/total_qty_method', ScopeInterface::SCOPE_STORE);
        foreach ($collection as $vp) {
            if (is_null($vp->getStockQty())) {
                continue;
            }
            $vp->setStockQty($vp->getStockQty()+$qty);
            if ($transaction) {
                $transaction->addObject($vp);
            } else {
                $vp->save();
            }
            $oItem = $item->getOrderItem();
            $pId = $item->getProductId();
            if (!$pId && $oItem) {
                $pId = $oItem->getProductId();
            }
            if ($item->getProduct()) {
                $product = $item->getProduct();
            } elseif ($item->getOrderItem() && $item->getOrderItem()->getProduct()) {
                $product = $item->getOrderItem()->getProduct();
            }
            $stockItem = null;
            if (!empty($product)) {
                $stockItem = $this->_hlp->getStockItem($product);
            }
            if ($stockItem) {
                $stockQty = max($stockItem->getQty()+$qty, 0);
                $stockItem->setQty($stockQty)->setIsInStock($stockQty>0);
                if ($transaction) {
                    $transaction->addObject($stockItem);
                } else {
                    $stockItem->save();
                }
            }
        }

        return $this;
    }

    public function updateOrderItemsVendors($orderId, $vendors)
    {
        // load order
        $order = $this->_orderFactory->create()->load($orderId);

        // load order items
        $items = $order->getAllItems();

        $isUdpo = $this->_hlp->isModuleActive('udpo');
        // retrieve all order shipments
        if (!$isUdpo) {
            $shipments = $this->_shipmentCollection
                ->setOrderFilter($order);
            $shipmentsByVendor = [];
            foreach ($shipments as $s) {
                $s->setOrder($order);
                $shipmentsByVendor[$s->getUdropshipVendor()][] = $s;
            }
        }

        // start save and delete transaction
        $save = $this->_hlp->transactionFactory()->create();
        $delete = $this->_hlp->transactionFactory()->create();

        $changed = false;
        $vendorIds = [];
        // iterate order items
        foreach ($items as $item) {
            // if no vendor update for the item, continue
            if (empty($vendors[$item->getId()])) {
                continue;
            }
            // get new vendor info
            $v = $vendors[$item->getId()];
            $vId = $v['id'];
            // if vendor didn't change, continue
            if ($vId==$item->getUdropshipVendor()) {
                continue;
            }
            $changed = true;
            // if shipment for the item was generated, collect item and vendor ids
            if (!$isUdpo && !empty($shipmentsByVendor[$item->getUdropshipVendor()])) {
                $vendorIds[$item->getId()] = $vId;
            }
            // calculate item qty to update stock with
            $qty = $this->_hlp->getItemStockCheckQty($item);
            // update stock for old vendor shipment
            if ($qty) {
                $this->updateItemStock($item, $qty, $save);
            }
            // update order item with new vendor and cost
            $item->setUdropshipVendor($vId);
            $item->setUdmOrigBaseCost($item->getBaseCost());
            if (!is_null($v['cost'])) {
                $item->setBaseCost($v['cost']);
            }
            // update stock for new vendor shipment
            if ($qty) {
                $this->updateItemStock($item, -$qty, $save);
            }
            // add item to save transaction
            $save->addObject($item);

            if ($item->getHasChildren()) {
                $children = $item->getChildrenItems() ? $item->getChildrenItems() : $item->getChildren();
                foreach ($children as $child) {
                    // calculate item qty to update stock with
                    $qty = $this->_hlp->getItemStockCheckQty($child);
                    // update stock for old vendor shipment
                    if ($qty) {
                        $this->updateItemStock($child, $qty, $save);
                    }
                    // update order item with new vendor and cost
                    $child->setUdropshipVendor($vId);
                    $child->setUdmOrigBaseCost($child->getBaseCost());
                    if (!is_null($v['cost'])) {
                        $child->setBaseCost($v['cost']);
                    }
                    // update stock for new vendor shipment
                    if ($qty) {
                        $this->updateItemStock($child, -$qty, $save);
                    }
                    // add item to save transaction
                    $save->addObject($child);
                }
            }
        }

        $shippedItemIds = [];
        if (!$isUdpo) {
            // in case we'll need to generate new shipments
            $convertor = $this->_convertOrderFactory->create();

            // clone shipments to avoid affecting the loop by adding a new shipment
            $oldShipments = clone $shipments;
            // iterate shipment items
            foreach ($oldShipments as $oldShipment) {
                $sItems = $oldShipment->getAllItems();
                foreach ($sItems as $sItem) {
                    $orderItemId = $sItem->getOrderItemId();
                    // no changes needed for this order item
                    if (empty($vendorIds[$orderItemId])) {
                        continue;
                    }
                    // get new vendor id
                    $vId = $vendorIds[$orderItemId];
                    $vendor = $this->_hlp->getVendor($vId);
                    // safeguard against changing vendor twice
                    if ($vId==$oldShipment->getUdropshipVendor()) {
                        continue;
                    }
                    // update old shipment
                    $udmOrigBaseCost = $sItem->getOrderItem()->getUdmOrigBaseCost();
                    $baseCost = $sItem->getOrderItem()->getBaseCost();
                    $oldShipment->setTotalCost($oldShipment->getTotalCost()-$sItem->getQty()*$udmOrigBaseCost);
                    $oldShipment->setTotalQty($oldShipment->getTotalQty()-$sItem->getQty());
                    $oldShipment->getItemsCollection()->removeItemByKey($sItem->getId());
                    // if target shipment already exists, use it
                    if (!empty($shipmentsByVendor[$vId])) {
                        $newShipment = current($shipmentsByVendor[$vId]);
                    } else {
                        // otherwise create a new one
                        $shipmentStatus = $this->scopeConfig->getValue('udropship/vendor/default_shipment_status', ScopeInterface::SCOPE_STORE, $order->getStoreId());
                        if ('999' != $vendor->getData('initial_shipment_status')) {
                            $shipmentStatus = $vendor->getData('initial_shipment_status');
                        }
                        $newShipment = $convertor->toShipment($order)
                            ->setUdropshipVendor($vId)
                            ->setUdropshipStatus($shipmentStatus);
                        // and add it to collection
                        $shipments->addItem($newShipment);
                        $shipmentsByVendor[$vId][] = $newShipment;
                    }
                    // update the new shipment
                    $newShipment->setTotalCost($newShipment->getTotalCost()+$sItem->getQty()*$baseCost);
                    $newShipment->setTotalQty($newShipment->getTotalQty()+$sItem->getQty());
                    $newShipment->setUdropshipMethod($vendors[$orderItemId]['method']);
                    $newShipment->setUdropshipMethodDescription($vendors[$orderItemId]['method_name']);
                    // retrieve shipment items before adding a new one
                    $newShipment->getItemsCollection();
                    // a little hack to force magento add item into shipment items collection
                    $sItemId = $sItem->getId();
                    $sItem->setId(null);
                    $sItem->setBaseCost($baseCost);
                    $newShipment->addItem($sItem);
                    $sItem->setId($sItemId);
                    // remember the shipment to save and send notification
                    $newShipment->setUdmultiSave(true)->setUdmultiSend(true);
                    // old save is in the internal loop to make sure that it's skipped when dup safeguard is triggered
                    $oldShipment->setUdmultiSave(true);
                    $shippedItemIds[] = $orderItemId;
                }
            }
            $sendNotifications = [];
            foreach ($shipments as $s) {
                if (!$s->getUdmultiSave()) {
                    continue;
                }
                if (count($s->getAllItems())>0) {
                    $save->addObject($s);
                    if ($s->getUdmultiSend()) {
                        $sendNotifications[] = $s;
                    }
                } else {
                    // if any shipments/vendors have no more products, delete them
                    $delete->addObject($s);
                }
            }

            // commit transactions
            $save->save();
            $delete->delete();

            $vendorRates = [];
            $shippingMethod = explode('_', $order->getShippingMethod(), 2);
            $shippingDetails = $order->getUdropshipShippingDetails();
            $details = \Zend_Json::decode($shippingDetails);
            if (!empty($details) && !empty($shippingMethod[1])) {
                if (!empty($details['methods'][$shippingMethod[1]])) {
                    $vendorRates = &$details['methods'][$shippingMethod[1]]['vendors'];
                } elseif (!empty($details['methods'])) {
                    $vendorRates = &$details['methods'];
                }
            }

            foreach ($vendors as $orderItemId=>$vData) {
                if (in_array($orderItemId, $shippedItemIds)) continue;
                if (empty($vendorRates[$vData['id']]) && @$vData['method_name']) {
                    list($carrierTitle, $methodTitle) = explode('-', $vData['method_name'], 2);
                    $vendorRates[$vData['id']] = [
                        'cost'  => 0,
                        'price' => 0,
                        'code'  => $vData['method'],
                        'carrier_title' => @$carrierTitle,
                        'method_title'  => @$methodTitle
                    ];
                }
            }

            $order->setUdropshipShippingDetails(\Zend_Json::encode($details));
            $order->getResource()->saveAttribute($order, 'udropship_shipping_details');

            // send pending notifications
            foreach ($sendNotifications as $s) {
                $this->_hlp->sendVendorNotification($s);
            }
        } else {
            $save->save();
        }

        return $changed;
    }

	public function saveThisVendorProducts($data, $v)
    {
        return $this->_saveVendorProducts($data, false, $v);
    }
    public function saveVendorProducts($data)
    {
        return $this->_saveVendorProducts($data, false);
    }
	public function saveThisVendorProductsPidKeys($data, $v)
    {
        return $this->_saveVendorProducts($data, true, $v);
    }
    public function saveVendorProductsPidKeys($data)
    {
        return $this->_saveVendorProducts($data, true);
    }
    public function setReindexFlag($flag)
    {
        $this->_hlp->getObj('\Unirgy\DropshipMulti\Helper\ProtectedCode')->setReindexFlag($flag);
        return $this;
    }
    protected function _saveVendorProducts($data, $pidKeys=false, $v=null)
    {
        return $this->_hlp->getObj('\Unirgy\DropshipMulti\Helper\ProtectedCode')->saveVendorProducts($data, $pidKeys, $v);
    }

    public function isVendorProductShipping($vendor=null)
    {
        $result = false;
        static $transport;
        if ($transport === null) {
            $transport = new DataObject;
        }
        $transport->setEnabled($result);
        $this->_eventManager->dispatch('udmulti_isVendorProductShipping', ['vendor' => $vendor, 'transport' => $transport]);
        return $transport->getEnabled();
    }

    public function getVendorSelect($data)
    {
        $escaper = $this->_hlp->getObj('\Magento\Framework\Escaper');
        $html = '<select name="'.@$data['name'].'" id="'.@$data['id'].'" class="'
            .@$data['class'].'" title="'.@$data['title'].'" '.@$data['extra'].' onchange="try{if (this.selectedIndex>-1) {$(\''.@$data['cost_id'].'\').value=this.options[this.selectedIndex].title}}catch(e){}">';
        if (is_array($data['options'])) {
            foreach ($data['options'] as $vId => $opt) {
                $selectedHtml = $vId == @$data['selected'] ? ' selected="selected"' : '';
                $html .= '<option value="'.$vId.'" title="'.@$opt['cost'].'" '.$selectedHtml.'>'.$escaper->escapeHtml(@$opt['name']).'</option>';
            }
        }
        $html.= '</select>';
        $html.= '<input type="hidden" name="'.@$data['cost_name'].'" id="'.@$data['cost_id'].'" value="'.@$data['options'][@$data['selected']]['cost'].'" class="'.@$data['cost_class'].'" />';
        return $html;
    }

    public function getStockItemUdropshipVendor($item)
    {
        $vId = $item->getForcedUdropshipVendor();
        if (!$vId && $item->getProduct()) {
            $vId = $item->getProduct()->getForcedUdropshipVendor();
        }
        return $vId;
    }

    public function attachMultivendorData($products, $isActive, $reload=false)
    {
        $pIds = [];
        foreach ($products as $product) {
            if ($product->hasUdmultiStock() && !$reload || !$product->getId()) {
                $stockItem = $this->_hlp->getStockItem($product);
                if ($stockItem) {
                    $stockItem->setUdmultiStock($product->getUdmultiStock());
                    $stockItem->setUdmultiAvail($product->getUdmultiAvail());
                }
                continue;
            }
            $pIds[] = $product->getId();
        }
        $loadMethod = $isActive ? 'getActiveMultiVendorData' : 'getMultiVendorData';
        $vendorData = $this->$loadMethod($pIds);
        $gpLoadMethod = $isActive ? 'getActiveMvGroupPrice' : 'getMvGroupPrice';
        $gpData = [];//$this->$gpLoadMethod($pIds);
        $tpLoadMethod = $isActive ? 'getActiveMvTierPrice' : 'getMvTierPrice';
        $tpData = [];
        if ($this->_hlp->isUdmultiPriceAvailable()) {
            $tpData = $this->$tpLoadMethod($pIds);
        }
        foreach ($products as $product) {
            if ($product->hasUdmultiStock() && !$reload || !$product->getId()) continue;
            $udmData = $udmAvail = $udmStock = [];
            foreach ($vendorData as $vp) {
                if ($vp->getProductId() != $product->getId()) continue;
                $udmGroupPrice = $udmTierPrice = [];
                $udmStock[$vp->getVendorId()] = $vp->getStockQty();
                $udmData[$vp->getVendorId()] = $vp->getData();
                $udmAvail[$vp->getVendorId()] = [
                    'product_id'  => $vp->getProductId(),
                    'stock_qty'   => $vp->getStockQty(),
                    'backorders'  => $vp->getData('backorders'),
                    'status'      => $vp->getData('status'),
                ];
                foreach ($gpData as $__gpd) {
                    if ($vp->getProductId() != $__gpd->getProductId() || $vp->getVendorId() != $__gpd->getVendorId()) continue;
                    $udmGroupPrice[] = $__gpd->getData();
                }
                foreach ($tpData as $__tpd) {
                    if ($vp->getProductId() != $__tpd->getProductId() || $vp->getVendorId() != $__tpd->getVendorId()) continue;
                    $udmTierPrice[] = $__tpd->getData();
                }
                $udmData[$vp->getVendorId()]['group_price'] = $udmGroupPrice;
                $udmData[$vp->getVendorId()]['tier_price'] = $udmTierPrice;
            }
            $product->setMultiVendorData($udmData);
            $product->setAllMultiVendorData($udmData);
            $product->setUdmultiStock($udmStock);
            $product->setUdmultiAvail($udmAvail);
            $stockItem = $this->_hlp->getStockItem($product);
            if ($stockItem) {
                $stockItem->setUdmultiStock($udmStock);
                $stockItem->setUdmultiAvail($udmAvail);
            }
            if ($isActive && $this->scopeConfig->isSetFlag('udropship/stock/hide_out_of_stock', ScopeInterface::SCOPE_STORE)) {
                $vendorsToHide = [];
                foreach ($udmData as $vId=>$dummy) {
                    if (!$this->isSalableByVendorData($product, $vId, $dummy)) {
                        $vendorsToHide[$vId] = $vId;
                    }
                }
                if (!empty($vendorsToHide)) {
                    foreach ($vendorsToHide as $vId) {
                        unset($udmStock[$vId], $udmData[$vId], $udmAvail[$vId]);
                    }
                    $product->setMultiVendorData($udmData);
                    $product->setUdmultiStock($udmStock);
                    $product->setUdmultiAvail($udmAvail);
                    $stockItem = $this->_hlp->getStockItem($product);
                    if ($stockItem) {
                        $stockItem->setUdmultiStock($udmStock);
                        $stockItem->setUdmultiAvail($udmAvail);
                    }
                }
            }
            if ($this->_hlp->isUdmultiPriceAvailable()) {
                $minPrice = PHP_INT_MAX;
                $minVendorId = 0;
                $multiPriceHlp = $this->_hlp->getObj('\Unirgy\DropshipMultiPrice\Helper\Data');
                foreach ($udmData as $vp) {
                    $vendorPrice = $this->_getProductFinalPrice($product);
                    if (null !== $vp['vendor_price']) {
                        $multiPriceHlp->useVendorPrice($product, $vp);
                        $vendorPrice = $product->getFinalPrice();
                        $multiPriceHlp->revertVendorPrice($product);
                    }
                    if ($minPrice>$vendorPrice) {
                        $minPrice = min($minPrice, $vendorPrice);
                        $minVendorId = $vp['vendor_id'];
                    }
                }
                if ($minPrice == PHP_INT_MAX) {
                    $minPrice = $this->_getProductFinalPrice($product);
                }
                $product->setUdmultiBestVendor($minVendorId);
                $product->setUdmultiBestPrice($minPrice);
            }
        }
        return $this;
    }

    protected function _getProductFinalPrice($product)
    {
        try {
            $finalPrice = 0;
            $finalPrice = $product->getFinalPrice();
        } catch (\Exception $e) {

        }
        return $finalPrice;
    }

    public function verifyDecisionCombination($items, $combination)
    {
        foreach ($items as $item) {
            if ($item->getHasChildren() && !$item->isShipSeparately()) {
                $children = $item->getChildren() ? $item->getChildren() : $item->getChildrenItems();
                $vId = null;
                foreach ($children as $child) {
                    foreach ($combination as $cmb) {
                        if ($child->getProductId()==$cmb['p']) {
                            if ($vId === null) {
                                $vId = $cmb['v'];
                            }
                            if ($vId != $cmb['v']) {
                                return false;
                            }
                            break;
                        }
                    }
                }
            }
        }
        return true;
    }

    public function getDefaultMvStatus($storeId=null)
    {
        return $this->scopeConfig->getValue('udropship/stock/default_multivendor_status', ScopeInterface::SCOPE_STORE, $storeId);
    }

    public function getBackorders($vendorData, $initBackorder)
    {
        $initBackorder = $this->getNativeBackorders($initBackorder);
        reset($vendorData);
        $vendorData = current($vendorData);
        $backorders = @$vendorData['backorders'] == \Unirgy\DropshipMulti\Model\Source::BACKORDERS_USE_CONFIG
            ? $initBackorder
            : @$vendorData['backorders'];
        return $backorders;
    }
    public function isSalableByVendor($product, $vId)
    {
        $product->setForcedUdropshipVendor($vId);
        $result = $product->isSalable();
        $product->unsForcedUdropshipVendor();
        return $result;
    }
    public function isQtySalableByFullVendorData($qty, $product, $vId, $mvData, $forcedStockQty=false)
    {
        $_mv = @$mvData[$vId];
        if (empty($_mv) || !is_array($_mv)) {
            return false;
        }
        return $this->_isSalableByVendorData($product, $vId, $_mv, $qty, $forcedStockQty);
    }
    public function isSalableByFullVendorData($product, $vId, $mvData, $forcedStockQty=false)
    {
        $_mv = @$mvData[$vId];
        if (empty($_mv) || !is_array($_mv)) {
            return false;
        }
        return $this->_isSalableByVendorData($product, $vId, $_mv, null, $forcedStockQty);
    }
    public function isQtySalableByVendorData($qty, $product, $vId, $mvData, $forcedStockQty=false)
    {
        return $this->_isSalableByVendorData($product, $vId, $mvData, $qty, $forcedStockQty);
    }
    public function isSalableByVendorData($product, $vId, $mvData, $forcedStockQty=false)
    {
        return $this->_isSalableByVendorData($product, $vId, $mvData, null, $forcedStockQty);
    }
    protected function _isSalableByVendorData($product, $vId, $mvData, $qty=null, $forcedStockQty=false)
    {
        if ($product instanceof Product) {
            $stockItem = $this->_hlp->getStockItem($product);
        } elseif ($product instanceof Item) {
            $stockItem = $product;
        } elseif (is_numeric($product)) {
            $stockItem = $this->_hlp
                ->getObj('\Magento\CatalogInventory\Api\StockRegistryInterface')
                ->getStockItem($product);
            $stockItem = $stockItem->getId() ? $stockItem : null;
        } elseif (is_array($product)) {
            $stockItem = $product;
        }
        $stockQty = $this->getQtyFromMvData($mvData, $forcedStockQty);
        $qtyCheck = $qty === null ? $stockQty>$this->getNativeMinQty($stockItem) : $stockQty>=$qty;
        $salableCheck = $qtyCheck || ($stockItem && $this->getBackorders([$vId=>$mvData], $this->getNativeBackorders($stockItem)));
        return $salableCheck;
    }

    public function getQtyFromFullMvData($mvData, $vId, $forcedQty=false)
    {
        $_mv = @$mvData[$vId];
        if ($forcedQty===false
            && (empty($_mv)
                || !is_array($_mv)
                || !array_key_exists('stock_qty', $_mv)
        )) {
            return 0;
        }
        if (@$_mv['status']<=0) return 0;
        return $this->_getQtyFromMvData((array)$_mv, $forcedQty);
    }
    public function getQtyFromMvData($mvData, $forcedQty=false)
    {
        return $this->_getQtyFromMvData((array)$mvData, $forcedQty);
    }
    protected function _getQtyFromMvData($mvData, $forcedQty=false)
    {
        if ($forcedQty===false
            && (empty($mvData)
                || !is_array($mvData)
                || !array_key_exists('stock_qty', $mvData)
        )) {
            return 0;
        }
        if (@$mvData['status']<=0) return 0;
        $qty = $forcedQty !== false ? $forcedQty : $mvData['stock_qty'];
        $qtyUsed = @$mvData['__qty_used'];
        return $qty === null ? 10000 : $qty-$qtyUsed;
    }

    public function getNativeBackorders($stockItem)
    {
        if ($stockItem instanceof DataObject) {
            if ($stockItem->getUseConfigBackorders()) {
                return (int) $this->scopeConfig->getValue(\Magento\CatalogInventory\Model\Configuration::XML_PATH_BACKORDERS, ScopeInterface::SCOPE_STORE);
            }
            return $stockItem->getData('backorders');
        } elseif (is_array($stockItem)
            && array_key_exists('backorders', $stockItem)
            && array_key_exists('use_config_backorders', $stockItem)
        ) {
            if ($stockItem['use_config_backorders']) {
                return (int) $this->scopeConfig->getValue(\Magento\CatalogInventory\Model\Configuration::XML_PATH_BACKORDERS, ScopeInterface::SCOPE_STORE);
            }
            return $stockItem['backorders'];
        } elseif (is_numeric($stockItem)) {
            return $stockItem;
        } else {
            return Stock::BACKORDERS_NO;
        }
    }

    public function getNativeMinQty($stockItem)
    {
        if ($stockItem instanceof DataObject) {
            if ($stockItem->getUseConfigMinQty()) {
                return (int) $this->scopeConfig->getValue(\Magento\CatalogInventory\Model\Configuration::XML_PATH_MIN_QTY, ScopeInterface::SCOPE_STORE);
            }
            return $stockItem->getData('min_qty');
        } elseif (is_array($stockItem)
            && array_key_exists('min_qty', $stockItem)
            && array_key_exists('use_config_min_qty', $stockItem)
        ) {
            if ($stockItem['use_config_min_qty']) {
                return (int) $this->scopeConfig->getValue(\Magento\CatalogInventory\Model\Configuration::XML_PATH_MIN_QTY, ScopeInterface::SCOPE_STORE);
            }
            return $stockItem['min_qty'];
        } elseif (is_numeric($stockItem)) {
            return $stockItem;
        } else {
            return 0;
        }
    }

    public function getCreateOrderItemsGridFile()
    {
        return 'Unirgy_DropshipMulti::udmulti/order/create/items_grid.phtml';
    }
    public function getCheckSql($expression, $true, $false)
    {
        if ($expression instanceof \Zend_Db_Expr || $expression instanceof \Zend_Db_Select) {
            $expression = sprintf("IF((%s), %s, %s)", $expression, $true, $false);
        } else {
            $expression = sprintf("IF(%s, %s, %s)", $expression, $true, $false);
        }
        return new \Zend_Db_Expr($expression);
    }
    public function getDatePartSql($date)
    {
        return new \Zend_Db_Expr(sprintf('DATE(%s)', $date));
    }

    public function isQty($item)
    {
        $typeId = $item->getTypeId();
        if ($productTypeId = $item->getProductTypeId()) {
            $typeId = $productTypeId;
        }
        return $this->_catalogInventoryHelperData->isQty($typeId);
    }

    protected $_indexerMap = [
        'Magento\CatalogInventory\Model\ResourceModel\Indexer\Stock\DefaultStock' => 'Unirgy\DropshipMulti\Model\StockIndexer\DefaultStock',
        'Magento\Bundle\Model\ResourceModel\Indexer\Stock' => 'Unirgy\DropshipMulti\Model\StockIndexer\Bundle',
        'Magento\GroupedProduct\Model\ResourceModel\Indexer\Stock\Grouped' => 'Unirgy\DropshipMulti\Model\StockIndexer\Grouped',
        'Magento\ConfigurableProduct\Model\ResourceModel\Indexer\Stock\Configurable' => 'Unirgy\DropshipMulti\Model\StockIndexer\Configurable',
    ];
    public function mapStockIndexer($indexer)
    {
        $indexer = $indexer ?: 'Magento\CatalogInventory\Model\ResourceModel\Indexer\Stock\DefaultStock';
        $indexer = trim($indexer, '\\');
        return $this->_hlp->isUdmultiActive() && isset($this->_indexerMap[$indexer])
            ? $this->_indexerMap[$indexer]
            : $indexer;
    }

    protected $_skipProductHashList = [];
    public function isSkipProductObject($product)
    {
        return array_key_exists(spl_object_hash($product), $this->_skipProductHashList);
    }
    public function skipProductObject($product, $remove=false)
    {
        if ($remove) {
            unset($this->_skipProductHashList[spl_object_hash($product)]);
        } else {
            $this->_skipProductHashList[spl_object_hash($product)] = 1;
        }
    }
    protected $_skipCategoryHashList = [];
    public function isSkipCategoryObject($category)
    {
        return array_key_exists(spl_object_hash($category), $this->_skipCategoryHashList);
    }
    public function skipCategoryObject($category, $remove=false)
    {
        if ($remove) {
            unset($this->_skipCategoryHashList[spl_object_hash($category)]);
        } else {
            $this->_skipCategoryHashList[spl_object_hash($category)] = 1;
        }
    }

}
