<?php

namespace Unirgy\DropshipMulti\Model\ResourceModel;

use Magento\CatalogInventory\Api\StockConfigurationInterface;
use Magento\CatalogInventory\Model\ResourceModel\Stock as ResourceModelStock;
use Magento\Framework\App\Config\ScopeConfigInterface;
use Magento\Framework\Model\ResourceModel\Db\Context;
use Magento\Framework\Stdlib\DateTime\DateTime;
use Magento\Store\Model\StoreManagerInterface;
use Unirgy\DropshipMulti\Helper\Data as HelperData;

class Stock extends ResourceModelStock
{
    /**
     * @var HelperData
     */
    protected $_helperData;

    public function __construct(Context $context, 
        ScopeConfigInterface $scopeConfig, 
        DateTime $dateTime, 
        StockConfigurationInterface $stockConfiguration, 
        StoreManagerInterface $storeManager, 
        HelperData $helperData)
    {
        $this->_helperData = $helperData;

        parent::__construct($context, $scopeConfig, $dateTime, $stockConfiguration, $storeManager);
    }

    public function getProductsStock($stock, $productIds, $lockRows = false)
    {
        $rows = parent::getProductsStock($stock, $productIds, $lockRows);
        $vCollection = $this->_helperData->getMultiVendorData($productIds);
        $udmArr = $udmAvail = [];
        foreach ($vCollection as $vp) {
            $udmArr[$vp->getProductId()][$vp->getVendorId()] = $vp->getStockQty();
            $udmAvail[$vp->getProductId()][$vp->getVendorId()] = [
                'product_id' => $vp->getProductId(),
                'status' => $vp->getData('status'),
            ];
        }
        foreach ($rows as &$p) {
            $pId = $p['product_id'];
            $arr = !empty($udmArr[$pId]) ? $udmArr[$pId] : [];
            $avail = !empty($udmAvail[$pId]) ? $udmAvail[$pId] : [];
            $p['udmulti_stock'] = $arr;
            $p['udmulti_avail'] = $avail;
        }
        return $rows;
    }
}