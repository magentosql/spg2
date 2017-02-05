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

class SellPost extends AbstractIndex
{

    public function execute()
    {
        $hlp = $this->_helperData;
        if ($product = $this->_initProduct()) {
            if (!$this->_getVendorSession()->authenticate($this)) {
                if ($this->getRequest()->isPost()) {
                    $this->_saveSellYoursFormData();
                }
            } else {
                $formData = [];
                if ($this->getRequest()->isPost()) {
                    $formData = $this->getRequest()->getPost();
                } else {
                    $formData = $this->_fetchSellYoursFormData();
                }
                if (!empty($formData)) {
                    $this->_syHlp->processSellRequest($this->_getVendorSession()->getVendor(), $product, $formData);
                    $this->_getC2CSession()->setHideAlreadySellingMsg(true);
                    $this->messageManager->addSuccess(__('Your sell request was succesfully submitted'));
                } else {
                    $this->messageManager->addError(__('Empty sell request form data'));
                }
                $this->_redirect('*/*/sell', ['id'=>$product->getId()]);
            }
        } elseif (!$this->getResponse()->isRedirect()) {
            $this->_forward('noRoute');
        }
    }
}
