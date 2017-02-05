<?php

namespace Unirgy\DropshipMulti\Model\Stock;

use Magento\CatalogInventory\Api\StockRegistryInterface;
use Magento\CatalogInventory\Api\StockStateInterface;
use Magento\CatalogInventory\Model\Stock\ItemFactory;
use Magento\Catalog\Model\ProductFactory;
use Magento\Framework\App\Config\ScopeConfigInterface;
use Magento\Framework\App\RequestInterface;
use Magento\Framework\Registry;
use Magento\Framework\View\DesignInterface;
use Unirgy\DropshipMulti\Helper\Data as DropshipMultiHelperData;
use Unirgy\Dropship\Helper\Data as HelperData;
use Unirgy\Dropship\Helper\Item;
use Unirgy\Dropship\Model\Stock\Availability as StockAvailability;

class Availability
    extends StockAvailability
{
    /**
     * @var ProductFactory
     */
    protected $_productFactory;

    /**
     * @var DropshipMultiHelperData
     */
    protected $_multiHlp;

    /**
     * @var ItemFactory
     */
    protected $_stockItemFactory;

    public function __construct(Item $helperItem, 
        HelperData $helper, 
        ScopeConfigInterface $scopeConfig, 
        DesignInterface $viewDesign, 
        RequestInterface $request, 
        Registry $registry, 
        StockRegistryInterface $stockRegistry, 
        StockStateInterface $stockState, 
        ProductFactory $modelProductFactory, 
        DropshipMultiHelperData $dropshipMultiHelperData, 
        ItemFactory $stockItemFactory, 
        array $data = [])
    {
        $this->_productFactory = $modelProductFactory;
        $this->_multiHlp = $dropshipMultiHelperData;
        $this->_stockItemFactory = $stockItemFactory;

        parent::__construct($helperItem, $helper, $scopeConfig, $viewDesign, $request, $registry, $stockRegistry, $stockState, $data);
    }


    public function collectStockLevels($items, $options=[])
    {
        $hlp = $this->_hlp;
        $iHlp = $this->_iHlp;
        $outOfStock = [];
        $extraQtys = [];
        $qtys = [];
        $stockItems = [];
        $skus = [];
        $costs = [];
        $zipCodes = [];
        $countries = [];
        $perItemData = [];
        foreach ($items as $item) {
            if (empty($quote)) {
                $quote = $item->getQuote();
            }
            //if ($iHlp->isVirtual($item)) continue;
            if ($item->getHasChildren()) {
                continue;
            }

            $pId = $item->getProductId();
            if (empty($qtys[$pId])) {
                $qtys[$pId] = 0;
                $product = $item->getProduct();
                if (!$product) {
                    $product = $this->_productFactory->create()->load($pId);
                }
                $stockItems[$pId] = $this->_hlp->getStockItem($product);
                $skus[$pId] = $product->getSku();
                $costs[$pId] = $item->getCost();
                $zipCodes[$pId] = $hlp->getZipcodeByItem($item);
                $countries[$pId] = $hlp->getCountryByItem($item);
                $addresses[$pId] = $hlp->getAddressByItem($item);
            }
            $qtys[$pId] += $hlp->getItemStockCheckQty($item);
            $extraQtys[$pId] = $item->getUdropshipExtraStockQty();
            if (empty($perItemData[$pId])) {
                $perItemData[$pId] = [];
            }
            $perItemData[$pId][spl_object_hash($item)] = [
                'parent_item_id' => $item->getParentItemId(),
                'item_id' => $item->getId(),
                'qty_requested' => $hlp->getItemStockCheckQty($item),
                'forced_vendor_id' => $iHlp->getForcedVendorIdOption($item),
                'priority_vendor_id' => $iHlp->getPriorityVendorIdOption($item),
                'skip_stock_check' => $iHlp->getSkipStockCheckVendorOption($item),
                'vendors' => []
            ];
            /*
            if ($item->getHasChildren()) {
                foreach ($item->getChildren() as $child) {
                    $product = $child->getProduct();
                    if ($product->getTypeInstance()->isVirtual()) {
                        continue;
                    }
                    $pId = $child->getProductId();
                    if (empty($qtys[$pId])) {
                        $qtys[$pId] = 0;
                        $stockItems[$pId] = $child->getProduct()->getStockItem();
                    }
                    $qtys[$pId] += $item->getQty()*$child->getQty();
                }
            }
            */
        }
        foreach ($perItemData as $pId=>&$_itemData) {
            uasort($_itemData, [$this, 'sortPerItemData']);
        }
        unset($_itemData);
        $vendorData = $this->_multiHlp->getActiveMultiVendorData($items);

        $requests = [];
        foreach ($qtys as $pId=>$qty) {
            foreach ($vendorData as $vp) {
                if ($vp->getProductId()!=$pId) {
                    continue;
                }
                $vId = $vp->getVendorId();
                $v = $hlp->getVendor($vId);
                $method = $v->getStockcheckMethod() ? $v->getStockcheckMethod() : 'local_multi';
                $cb = $v->getStockcheckCallback($method);

                if (empty($requests[$method])) {
                    $requests[$method] = [
                        'callback' => $cb,
                        'products' => [],
                    ];
                }
                if (empty($requests[$method]['products'][$pId])) {
                    $requests[$method]['products'][$pId] = [
                        'stock_item' => $stockItems[$pId],
                        'qty_requested' => $qty,
                        'per_item_data' => $perItemData[$pId],
                        'vendors' => [],
                    ];
                }
                $data = $vp->getData();
                $data['__qty_used'] = 0;
                $data['stock_qty'] = is_null($vp->getStockQty()) || $vp->getStockQty()==='' ? null : 1*$vp->getStockQty()+@$extraQtys[$pId][$vId];
                $data['vendor_sku'] = $vp->getVendorSku() ? $vp->getVendorSku() : $skus[$pId];
                $data['vendor_cost'] = $vp->getVendorCost() ? $vp->getVendorCost() : $costs[$pId];
                $data['address_match'] = $v->isAddressMatch($addresses[$pId]);
                $data['zipcode_match'] = $v->isZipcodeMatch($zipCodes[$pId]);
                $data['country_match'] = $v->isCountryMatch($countries[$pId]);
                $requests[$method]['products'][$pId]['vendors'][$vId] = $data;
            }
        }

        $iHlp->processSameVendorLimitation($items, $requests);

        $result = $this->processRequests($items, $requests);
        $this->setStockResult($result);

        return $this;
    }

    public function checkLocalStockLevel($products)
    {
        $this->setTrueStock(true);
        $localVendorId = $this->_hlp->getLocalVendorId();
        $result = [];
        $hlpm = $this->_multiHlp;
        $ignoreStockStatusCheck = $this->_registry->registry('reassignSkipStockCheck');
        $ignoreAddrCheck = $this->_registry->registry('reassignSkipAddrCheck');
        foreach ($products as $pId=>$p) {
            if (empty($p['stock_item'])) {
                $p['stock_item'] = $this->_hlp
                    ->getObj('\Magento\CatalogInventory\Api\StockRegistryInterface')
                    ->getStockItem($pId);
            }
            $qtyRequested = 0;
            $perItemData = [];
            foreach ($p['per_item_data'] as $itemHash => $itemData) {
                if (!array_key_exists('vendors', $itemData)) {
                    $itemData['vendors'] = [];
                }
                if (!array_key_exists('status', $itemData)) {
                    $itemData['status'] = false;
                }
                $iQtyRequested = $itemData['qty_requested'];
                $_forcedVid = @$itemData['forced_vendor_id'];
                if ($_forcedVid) {
                    $_mvd = (array)@$p['vendors'][$_forcedVid];
                    $_mvd['is_priority_vendor'] = false;
                    $_mvd['is_forced_vendor'] = true;
                    $_mvd['vendor_id'] = $_forcedVid;
                    $addressMatch = (!isset($_mvd['address_match']) || $_mvd['address_match']!==false);
                    $zipCodeMatch = (!isset($_mvd['zipcode_match']) || $_mvd['zipcode_match']!==false);
                    $countryMatch = (!isset($_mvd['country_match']) || $_mvd['country_match']!==false);
                    if (!empty($itemData['skip_stock_check'])) {
                        $_mvd['qty_in_stock'] = 0;
                        $_mvd['backorders'] = false;
                        $_mvd['stock_status'] = true;
                    } else {
                        if (empty($_mvd)) {
                            $_mvd['qty_in_stock'] = 0;
                            $_mvd['backorders'] = false;
                            $_mvd['stock_status'] = false;
                        } else {
                            $_mvd['qty_in_stock'] = $hlpm->getQtyFromMvData($_mvd);
                            $_mvd['backorders'] = $hlpm->getBackorders([$_forcedVid=>$_mvd], $p['stock_item']);
                            $_mvd['stock_status'] = $hlpm->isQtySalableByVendorData($iQtyRequested, $p['stock_item'], $_forcedVid, $_mvd);
                            $p['vendors'][$_forcedVid]['__qty_used'] = @$p['vendors'][$_forcedVid]['__qty_used'] + $iQtyRequested;
                        }
                    }
                    if ($ignoreStockStatusCheck) {
                        $_mvd['stock_status'] = true;
                    }
                    $_mvd['addr_status'] = $zipCodeMatch && $countryMatch && $addressMatch;
                    if ($ignoreAddrCheck) {
                        $_mvd['addr_status'] = true;
                    }
                    $_mvd['status'] = $_mvd['stock_status'] && $_mvd['addr_status'];
                    $_mvd['address_match'] = $addressMatch;
                    $_mvd['zipcode_match'] = $zipCodeMatch;
                    $_mvd['country_match'] = $countryMatch;
                    $itemData['vendors'][$_forcedVid] = $_mvd;
                } else {
                    foreach ($p['vendors'] as $vId=>$v) {
                        $_mvd = $v;
                        $_mvd['is_priority_vendor'] = $itemData['priority_vendor_id']==$vId;
                        $_mvd['is_forced_vendor'] = false;
                        $_mvd['vendor_id'] = $vId;
                        $addressMatch = (!isset($_mvd['address_match']) || $_mvd['address_match']!==false);
                        $zipCodeMatch = (!isset($_mvd['zipcode_match']) || $_mvd['zipcode_match']!==false);
                        $countryMatch = (!isset($_mvd['country_match']) || $_mvd['country_match']!==false);
                        if (!empty($itemData['skip_stock_check'])) {
                            $_mvd['qty_in_stock'] = 0;
                            $_mvd['backorders'] = false;
                            $_mvd['stock_status'] = true;
                        } else {
                            if (empty($_mvd)) {
                                $_mvd['qty_in_stock'] = 0;
                                $_mvd['backorders'] = false;
                                $_mvd['stock_status'] = false;
                            } else {
                                $_mvd['qty_in_stock'] = $hlpm->getQtyFromMvData($_mvd);
                                $_mvd['backorders'] = $hlpm->getBackorders([$vId=>$_mvd], $p['stock_item']);
                                $_mvd['stock_status'] = $hlpm->isQtySalableByVendorData($iQtyRequested, $p['stock_item'], $vId, $_mvd);
                                $p['vendors'][$vId]['__qty_used'] = @$p['vendors'][$vId]['__qty_used'] + $iQtyRequested;
                            }
                        }
                        if ($ignoreStockStatusCheck) {
                            $_mvd['stock_status'] = true;
                        }
                        $_mvd['addr_status'] = $zipCodeMatch && $countryMatch && $addressMatch;
                        if ($ignoreAddrCheck) {
                            $_mvd['addr_status'] = true;
                        }
                        $_mvd['status'] = $_mvd['stock_status'] && $_mvd['addr_status'];
                        $_mvd['address_match'] = $addressMatch;
                        $_mvd['zipcode_match'] = $zipCodeMatch;
                        $_mvd['country_match'] = $countryMatch;
                        $itemData['vendors'][$vId] = $_mvd;
                    }
                    $qtyRequested += $iQtyRequested;
                }
                $perItemData[$itemHash] = $itemData;
            }
            unset($itemData);
            foreach ($p['vendors'] as $vId=>$v) {
                unset($v['__qty_used']);
                $v['qty_in_stock'] = $hlpm->getQtyFromMvData($v);
                $v['backorders'] = $hlpm->getBackorders([$vId=>$v], $p['stock_item']);
                $v['stock_status'] = true;

                $v['per_item_data'] = [];
                foreach ($perItemData as $itemHash => $itemData) {
                    foreach ($itemData['vendors'] as $_mvdVid => $_mvd) {
                        if ($_mvdVid == $vId) {
                            $v['per_item_data'][$itemHash] = $_mvd;
                            $v['stock_status'] = $v['stock_status'] && $_mvd['stock_status'];
                            break;
                        }
                    }
                }

                $v['global_stock_status'] = $hlpm->isQtySalableByVendorData($qtyRequested, $p['stock_item'], $vId, $v);

                if ($ignoreStockStatusCheck) $v['stock_status'] = true;

                $addressMatch = (!isset($v['address_match']) || $v['address_match']!==false);
                $zipCodeMatch = (!isset($v['zipcode_match']) || $v['zipcode_match']!==false);
                $countryMatch = (!isset($v['country_match']) || $v['country_match']!==false);
                $v['addr_status'] = $zipCodeMatch && $countryMatch && $addressMatch;
                if ($ignoreAddrCheck) {
                    $v['addr_status'] = true;
                }
                $v['status'] = $v['stock_status'] && $v['addr_status'];
                $v['address_match'] = $addressMatch;
                $v['zipcode_match'] = $zipCodeMatch;
                $v['country_match'] = $countryMatch;
                $result[$pId][$vId] = $v;
            }
        }
        unset($p);
        $this->setTrueStock(false);
        return $result;
    }
    public function sortPerItemData($c1, $c2)
    {
        if ((bool)$c1['forced_vendor_id']>(bool)$c2['forced_vendor_id']) {
            return -1;
        } elseif ((bool)$c1['forced_vendor_id']<(bool)$c2['forced_vendor_id']) {
            return 1;
        }
        if ((bool)$c1['item_id']>(bool)$c2['item_id']) {
            return -1;
        } elseif ((bool)$c1['item_id']<(bool)$c2['item_id']) {
            return 1;
        }
        return $c1['item_id']>$c2['item_id'];
    }
}
