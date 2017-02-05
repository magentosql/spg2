<?php

namespace Unirgy\DropshipSellYours\Controller\Index;

use Magento\Backend\Model\View\Result\ForwardFactory;
use Magento\CatalogSearch\Helper\Data as CatalogSearchHelperData;
use Magento\CatalogSearch\Model\Advanced;
use Magento\Catalog\Model\CategoryFactory;
use Magento\Catalog\Model\Design;
use Magento\Catalog\Model\DesignFactory;
use Magento\Catalog\Model\ProductFactory;
use Magento\Framework\App\Action\Context;
use Magento\Framework\App\Config\ScopeConfigInterface;
use Magento\Framework\App\RequestInterface;
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

class Product extends AbstractIndex
{
    /**
     * @var DesignFactory
     */
    protected $_modelDesignFactory;

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
        DesignFactory $modelDesignFactory)
    {
        $this->_modelDesignFactory = $modelDesignFactory;

        parent::__construct($context, $scopeConfig, $viewDesignInterface, $storeManager, $viewLayoutFactory, $registry, $resultForwardFactory, $helper, $resultPageFactory, $resultRawFactory, $httpHeader, $modelCategoryFactory, $modelAdvanced, $helperData, $dropshipSellYoursHelperData, $logLoggerInterface, $modelProductFactory);
    }

    public function execute()
    {
        if ($product = $this->_initProduct()) {
            $this->_request->setParam('alloffers',1);
            $this->_request->register('productId', $product->getId());
            $this->_modelDesignFactory->create()->applyDesign($product, Design::APPLY_FOR_PRODUCT);

            $this->_setTheme();
            $this->_initProductLayout($product);
            if (($head = $this->_viewLayoutFactory->create()->getBlock('header'))) {
                $head->setActivePage('udsell');
            }

            // update breadcrumbs
            if ($breadcrumbsBlock = $this->_viewLayoutFactory->create()->getBlock('breadcrumbs')) {
                $breadcrumbsBlock->addCrumb('product', [
                    'label'    => $product->getName(),
                    'link'     => $product->getProductUrl(),
                    'readonly' => true,
                ]);
                $breadcrumbsBlock->addCrumb('udsell_cfgsell', ['label' => __('All Offers')]);
            }
            $this->_initLayoutMessages('udsell/session');
            $this->_initLayoutMessages('catalog/session');
            $this->_initLayoutMessages('tag/session');
            $this->_initLayoutMessages('checkout/session');
            $this->renderLayout();
        } elseif (!$this->getResponse()->isRedirect()) {
            $this->_forward('noRoute');
        }
    }
}
