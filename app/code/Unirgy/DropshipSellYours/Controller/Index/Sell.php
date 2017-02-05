<?php

namespace Unirgy\DropshipSellYours\Controller\Index;

use Magento\Backend\Model\View\Result\ForwardFactory;
use Magento\CatalogSearch\Helper\Data as CatalogSearchHelperData;
use Magento\CatalogSearch\Model\Advanced;
use Magento\Catalog\Model\CategoryFactory;
use Magento\Catalog\Model\ProductFactory;
use Magento\Customer\Model\Group;
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
use Unirgy\DropshipMulti\Helper\Data as DropshipMultiHelperData;
use Unirgy\DropshipSellYours\Helper\Data as DropshipSellYoursHelperData;
use Unirgy\DropshipVendorProduct\Helper\Data as DropshipVendorProductHelperData;
use Unirgy\Dropship\Helper\Data as HelperData;

class Sell extends AbstractIndex
{
    /**
     * @var DropshipMultiHelperData
     */
    protected $_multiHlp;

    /**
     * @var DropshipVendorProductHelperData
     */
    protected $_prodHlp;

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
        ProductFactory $modelProductFactory, 
        DropshipMultiHelperData $dropshipMultiHelperData, 
        DropshipVendorProductHelperData $dropshipVendorProductHelperData
    )
    {
        $this->_multiHlp = $dropshipMultiHelperData;
        $this->_prodHlp = $dropshipVendorProductHelperData;

        parent::__construct($context, $scopeConfig, $viewDesignInterface, $storeManager, $viewLayoutFactory, $registry, $resultForwardFactory, $helper, $resultPageFactory, $resultRawFactory, $httpHeader, $modelCategoryFactory, $modelAdvanced, $helperData, $dropshipSellYoursHelperData, $logLoggerInterface, $modelProductFactory);
    }

    public function execute()
    {
        if (!$this->_getVendorSession()->authenticate($this)) return;
        if ($product = $this->_initProduct()) {
            $hlp = $this->_helperData;
            $uSess = $this->_getVendorSession();
            $vendor = $uSess->getVendor();
            $sellYoursFormData = [];
            if ($uSess->isLoggedIn()) {
                $this->_registry->register('current_vendor', $vendor);
                $mvData = $this->_multiHlp->getMultiVendorData([$product->getId()])
                    ->getItemByColumnValue('vendor_id', $vendor->getId());
                $activeMvData = $this->_multiHlp->getActiveMultiVendorData([$product->getId()])
                    ->getItemByColumnValue('vendor_id', $vendor->getId());

                if ($mvData && $mvData->getId()) {

                    $gpData = [];//$this->_multiHlp->getMvGroupPrice([$product->getId()]);
                    $tpData = $this->_multiHlp->getMvTierPrice([$product->getId()]);

                    $udmTierPrice = $udmGroupPrice = [];
                    foreach ($gpData as $__gpd) {
                        if ($mvData->getProductId() != $__gpd->getProductId() || $mvData->getVendorId() != $__gpd->getVendorId()) continue;
                        if ($__gpd->getData('all_groups')) {
                            $__gpd->setData('customer_group_id', Group::CUST_GROUP_ALL);
                        }
                        $udmGroupPrice[] = $__gpd->getData();
                    }
                    foreach ($tpData as $__tpd) {
                        if ($mvData->getProductId() != $__tpd->getProductId() || $mvData->getVendorId() != $__tpd->getVendorId()) continue;
                        if ($__tpd->getData('all_groups')) {
                            $__tpd->setData('customer_group_id', Group::CUST_GROUP_ALL);
                        }
                        $udmTierPrice[] = $__tpd->getData();
                    }
                    $mvData->setData('group_price', $udmGroupPrice);
                    $mvData->setData('tier_price', $udmTierPrice);

                    if (!$this->_getC2CSession()->getHideAlreadySellingMsg(true)) {
                        $this->messageManager->addNotice(
                            __('You already selling this item')
                        );
                    }
                    if (!$activeMvData || !$activeMvData->getId()) {
                        $this->messageManager->addNotice(
                            __('The request to sell this product need to be approved by admin')
                        );
                    }
                    $sellYoursFormData['udmulti'] = $mvData->getData();
                }
                if ($product->getTypeId()=='configurable') {
                    $simpleProds = $this->_prodHlp->getEditSimpleProductData($product, true, $vendor);
                    foreach ($simpleProds as $simpleProd) {
                        if (isset($simpleProd['udmulti']) && is_array($simpleProd['udmulti'])) {
                            $sellYoursFormData['udsell_cfgsell'][] = $simpleProd;
                        }
                    }
                }
            }
            if (($tmpMvData = $this->_fetchSellYoursFormData($product->getId()))) {
                $sellYoursFormData = $tmpMvData;
            }
            unset($sellYoursFormData['udsell_cfgsell']['$ROW']);
            $this->_registry->register('sell_yours_data_'.$product->getId(), $sellYoursFormData);
            $this->_registry->register('productId', $product->getId());

            $this->_setTheme();
            $this->_renderPage('UDC2C_PRODUCT_TYPE_'.$product->getTypeId(), 'udsell');
        } elseif (!$this->getResponse()->isRedirect()) {
            $this->_forward('noRoute');
        }
    }
}
