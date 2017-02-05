<?php

namespace Unirgy\DropshipSellYours\Controller\Index;

use Magento\Backend\Model\View\Result\ForwardFactory;
use Magento\CatalogSearch\Helper\Data as CatalogSearchHelperData;
use Magento\CatalogSearch\Model\Advanced;
use Magento\Catalog\Model\CategoryFactory;
use Magento\Catalog\Model\ProductFactory;
use Magento\Framework\App\Action\Context;
use Magento\Framework\App\Config\ScopeConfigInterface;
use Magento\Framework\Controller\Result\RawFactory;
use Magento\Framework\HTTP\Header;
use Magento\Framework\Registry;
use Magento\Framework\View\DesignInterface;
use Magento\Framework\View\LayoutFactory;
use Magento\Framework\View\Result\PageFactory;
use Magento\Store\Model\StoreManagerInterface;
use Psr\Log\LoggerInterface;
use Unirgy\DropshipSellYours\Helper\Data as DropshipSellYoursHelperData;
use Unirgy\Dropship\Helper\Data as HelperData;

class Vendor extends AbstractIndex
{

    public function __construct(Context $context, 
        ScopeConfigInterface $scopeConfig, 
        DesignInterface $viewDesignInterface, 
        StoreManagerInterface $storeManager, 
        LayoutFactory $viewLayoutFactory, 
        Registry $registry, 
        ForwardFactory $resultForwardFactory, 
        HelperData $helper, 
        PageFactory $resultPageFactory, 
        RawFactory $resultRawFactory, 
        Header $httpHeader, 
        CategoryFactory $modelCategoryFactory, 
        Advanced $modelAdvanced, 
        CatalogSearchHelperData $helperData, 
        DropshipSellYoursHelperData $dropshipSellYoursHelperData, 
        LoggerInterface $logLoggerInterface, 
        ProductFactory $modelProductFactory)
    {


        parent::__construct($context, $scopeConfig, $viewDesignInterface, $storeManager, $viewLayoutFactory, $registry, $resultForwardFactory, $helper, $resultPageFactory, $resultRawFactory, $httpHeader, $modelCategoryFactory, $modelAdvanced, $helperData, $dropshipSellYoursHelperData, $logLoggerInterface, $modelProductFactory);
    }

    public function execute()
    {
        $uSess = $this->_getVendorSession();
        $cSess = $this->_getCustomerSession();
        $sess  = $this->_getC2CSession();
        $vendor = $uSess->getVendor();
        $customer = $cSess->getCustomer();
        if (!$uSess->isLoggedIn() && $cSess->isLoggedIn() && $customer->getVendorId()) {
            $uSess->loginById($customer->getVendorId());
        }
        if ($uSess->authenticate($this)) {
            $this->_helperData->hookVendorCustomer($vendor, $customer);
            $redirectUrl = $this->_url->getUrl('udropship/vendor');
            if ($sess->getVendorRedirectUrl()) {
                $redirectUrl = $sess->getVendorRedirectUrl(true);
            }
            $this->_redirectUrl($redirectUrl);
        }
    }
}
