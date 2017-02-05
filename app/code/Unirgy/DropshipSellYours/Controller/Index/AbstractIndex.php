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
 * @package    Unirgy_DropshipSellYours
 * @copyright  Copyright (c) 2008-2009 Unirgy LLC (http://www.unirgy.com)
 * @license    http:///www.unirgy.com/LICENSE-M1.txt
 */

namespace Unirgy\DropshipSellYours\Controller\Index;

use Magento\Backend\Model\View\Result\ForwardFactory;
use Magento\CatalogSearch\Helper\Data as CatalogSearchHelperData;
use Magento\CatalogSearch\Model\Advanced;
use Magento\Catalog\Model\CategoryFactory;
use Magento\Catalog\Model\ProductFactory;
use Magento\Framework\App\Action\Context;
use Magento\Framework\App\Config\ScopeConfigInterface;
use Magento\Framework\App\ObjectManager;
use Magento\Framework\Controller\Result\RawFactory;
use Magento\Framework\Exception;
use Magento\Framework\HTTP\Header;
use Magento\Framework\Registry;
use Magento\Framework\View\DesignInterface;
use Magento\Framework\View\LayoutFactory;
use Magento\Framework\View\Result\PageFactory;
use Magento\Store\Model\StoreManagerInterface;
use Psr\Log\LoggerInterface;
use Unirgy\DropshipSellYours\Helper\Data as DropshipSellYoursHelperData;
use Unirgy\Dropship\Controller\VendorAbstract;
use Unirgy\Dropship\Helper\Data as HelperData;

abstract class AbstractIndex extends VendorAbstract
{
    /**
     * @var CategoryFactory
     */
    protected $_modelCategoryFactory;

    /**
     * @var Advanced
     */
    protected $_modelAdvanced;

    /**
     * @var CatalogSearchHelperData
     */
    protected $_helperData;

    /**
     * @var DropshipSellYoursHelperData
     */
    protected $_syHlp;

    /**
     * @var LoggerInterface
     */
    protected $_logger;

    /**
     * @var ProductFactory
     */
    protected $_modelProductFactory;

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
        $this->_modelCategoryFactory = $modelCategoryFactory;
        $this->_modelAdvanced = $modelAdvanced;
        $this->_helperData = $helperData;
        $this->_syHlp = $dropshipSellYoursHelperData;
        $this->_logger = $logLoggerInterface;
        $this->_modelProductFactory = $modelProductFactory;

        parent::__construct($context, $scopeConfig, $viewDesignInterface, $storeManager, $viewLayoutFactory, $registry, $resultForwardFactory, $helper, $resultPageFactory, $resultRawFactory, $httpHeader);
    }

    protected function _getC2CSession()
    {
        return ObjectManager::getInstance()->get('Unirgy\DropshipSellYours\Model\Session');
    }
    protected function _getVendorSession()
    {
        return ObjectManager::getInstance()->get('Unirgy\Dropship\Model\Session');
    }
    protected function _getCustomerSession()
    {
        return ObjectManager::getInstance()->get('Magento\Customer\Model\Session');
    }


    protected function _sellSearch()
    {
        if (!$this->_getVendorSession()->authenticate($this)) return;
        $this->_registry->register('udsell_status_all',1);
        if ($this->getRequest()->getParam('q') || $this->getRequest()->getParam('c')) {
            $categoryId=$this->getRequest()->getParam('c');
            if (!$categoryId) {
                $categoryId = $this->_storeManager->getStore()->getRootCategoryId();
            }
            $category = $this->_modelCategoryFactory->create()
                ->setStoreId($this->_storeManager->getStore()->getId())
                ->load($categoryId);
            if ($category->getId()) {
                $this->_registry->register('current_category', $category);
            }
            if ($this->getRequest()->getParam('type') == 'barcode') {
                $this->_hlp->getObj('\Magento\Catalog\Model\Layer\Resolver')->create(\Magento\Catalog\Model\Layer\Resolver::CATALOG_LAYER_SEARCH);
                $this->_modelAdvanced->addFilters(['sku'=>$this->getRequest()->getParam('q')]);
            } else {
                $query = $this->_hlp->getObj('\Magento\Search\Model\QueryFactory')->get();
                $query->setStoreId($this->_storeManager->getStore()->getId());
                if ($query->getQueryText()) {
                    $this->_hlp->getObj('\Magento\Catalog\Model\Layer\Resolver')->create(\Magento\Catalog\Model\Layer\Resolver::CATALOG_LAYER_SEARCH);
                    if ($this->_helperData->isMinQueryLength()) {
                        $query->setId(0)
                            ->setIsActive(1)
                            ->setIsProcessed(1);
                    }
                    else {
                        if ($query->getId()) {
                            $query->setPopularity($query->getPopularity()+1);
                        }
                        else {
                            $query->setPopularity(1);
                        }

                        if ($query->getRedirect()){
                            $query->save();
                            $this->getResponse()->setRedirect($query->getRedirect());
                            return;
                        }
                        else {
                            $query->prepare();
                        }
                    }
                }
            }
        } else {
            $categoryId = $this->_storeManager->getStore()->getRootCategoryId();
            $category = $this->_modelCategoryFactory->create()
                ->setStoreId($this->_storeManager->getStore()->getId())
                ->load($categoryId);
            if ($category->getId()) {
                $this->_registry->register('current_category', $category);
            }
        }
        return $this->_renderPage(null, 'udsell');
    }

    protected function _saveSellYoursFormData($data=null, $id=null)
    {
        $this->_syHlp->saveSellYoursFormData($data, $id);
    }

    protected function _fetchSellYoursFormData($id=null)
    {
        return $this->_syHlp->fetchSellYoursFormData($id);
    }

    protected function _getActivePage()
    {
        return $this->_getVendorSession()->getData('udsell_active_page');
    }


    protected function _initProduct()
    {
        $this->_eventManager->dispatch('udsell_controller_sell_before', ['controller_action'=>$this]);
        $categoryId = (int) $this->getRequest()->getParam('c', false);
        $productId  = (int) $this->getRequest()->getParam('id');

        $product = $this->_loadProduct($productId);

        if ($categoryId) {
            $category = $this->_modelCategoryFactory->create()->load($categoryId);
            $this->_registry->register('current_category', $category);
        }

        try {
            $this->_eventManager->dispatch('udsell_controller_sell_init', ['product'=>$product]);
            $this->_eventManager->dispatch('udsell_controller_sell_init_after', ['product'=>$product, 'controller_action' => $this]);
        } catch (\Exception $e) {
            $this->_logger->error($e);
            return false;
        }

        return $product;
    }

    protected function _loadProduct($productId)
    {
        if (!$productId) {
            return false;
        }

        $oldStoreId = $this->_storeManager->getStore()->getId();
        $this->_storeManager->setCurrentStore(0);

        $product = $this->_modelProductFactory->create()
            ->load($productId);

        $this->_storeManager->getStore()->setId($oldStoreId);
        $this->_storeManager->setCurrentStore($oldStoreId);
        /* @var $product \Magento\Catalog\Model\Product */
        if (!$product->getId() || !$product->isVisibleInCatalog() || !$product->isVisibleInSiteVisibility()) {
            return false;
        }

        $this->_registry->register('current_product', $product);
        $this->_registry->register('product', $product);

        return $product;
    }

    protected function _initProductLayout($product, $isSell=false)
    {
        $update = $this->_view->getLayout()->getUpdate();

        $update->addHandle('default');
        $this->_view->addActionLayoutHandles();


        $update->addHandle(($isSell ? 'UDC2C_' : '').'PRODUCT_TYPE_'.$product->getTypeId());

        if ($product->getPageLayout()) {
            $this->_view->getLayout()->create()->helper('page/layout')
                ->applyHandle($product->getPageLayout());
        }

        $this->loadLayoutUpdates();
        if ($product->getPageLayout()) {
            $this->_view->getLayout()->create()->helper('page/layout')
                ->applyTemplate($product->getPageLayout());
        }
        $update->addUpdate($product->getCustomLayoutUpdate());
        $this->generateLayoutXml()->generateLayoutBlocks();
    }

}