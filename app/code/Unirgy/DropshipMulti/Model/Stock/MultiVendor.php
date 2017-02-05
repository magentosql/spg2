<?php

namespace Unirgy\DropshipMulti\Model\Stock;

use Magento\CatalogInventory\Api\StockRegistryInterface;
use Magento\CatalogInventory\Api\StockStateInterface;
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
    protected $_modelProductFactory;

    /**
     * @var DropshipMultiHelperData
     */
    protected $_dropshipMultiHelperData;

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
        array $data = [])
    {
        $this->_modelProductFactory = $modelProductFactory;
        $this->_dropshipMultiHelperData = $dropshipMultiHelperData;

        parent::__construct($helperItem, $helper, $scopeConfig, $viewDesign, $request, $registry, $stockRegistry, $stockState, $data);
    }

    public function collectStockLevels($items)
    {
        $hlp = $this->_helperData;
        $outOfStock = [];
        $qtys = [];
        $stockItems = [];
        $skus = [];
        $costs = [];
        foreach ($items as $item) {
            if (empty($quote)) {
                $quote = $item->getQuote();
            }
            if ($item->getHasChildren()) {
                continue;
            }

            $pId = $item->getProductId();
            if (empty($qtys[$pId])) {
                $qtys[$pId] = 0;
                $product = $item->getProduct();
                if (!$product) {
                    $product = $this->_modelProductFactory->create()->load($pId);
                }
                $stockItems[$pId] = $this->_hlp->getStockItem($product);
                $skus[$pId] = $product->getSku();
                $costs[$pId] = $item->getCost();
            }
            $parentQty = $item->getParentItem() ? $item->getParentItem()->getQty() : 1;
            $qtys[$pId] += $item->getQty()*$parentQty;
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
        $vendorData = $this->_dropshipMultiHelperData->getMultiVendorData($items);

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
                        'vendors' => [],
                    ];
                }
                $data = $vp->getData();
                $data['stock_qty'] = is_null($vp->getStockQty()) || $vp->getStockQty()==='' ? null : 1*$vp->getStockQty();
                $data['vendor_sku'] = $vp->getVendorSku() ? $vp->getVendorSku() : $skus[$pId];
                $data['vendor_cost'] = $vp->getVendorCost() ? $vp->getVendorCost() : $costs[$pId];
                $requests[$method]['products'][$pId]['vendors'][$vId] = $data;
            }
        }

        $result = $this->processRequests($items, $requests);
        $this->setStockResult($result);

        return $this;
    }

    public function checkLocalStockLevel($products)
    {
        $this->setTrueStock(true);
        $localVendorId = $this->_helperData->getLocalVendorId();
        $result = [];
        foreach ($products as $pId=>$p) {
            foreach ($p['vendors'] as $vId=>$v) {
                $vQty = $v['stock_qty'];
                if ($vId==$localVendorId && is_null($vQty)) {
                    if (empty($p['stock_item'])) {
                        $p['stock_item'] = $this->_hlp->getStockItem($pId);
                    }
                    $v['status'] = !$p['stock_item']->getManageStock()
                        || $p['stock_item']->getIsInStock() && $p['stock_item']->checkQty($p['qty_requested']);
                } else {
                    $v['status'] = is_null($vQty) || $vQty>=$p['qty_requested'];
                }
                $result[$pId][$vId] = $v;
            }
        }
        $this->setTrueStock(false);
        return $result;
    }
}