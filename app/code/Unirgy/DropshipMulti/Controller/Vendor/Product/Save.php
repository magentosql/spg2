<?php

namespace Unirgy\DropshipMulti\Controller\Vendor\Product;

use Magento\Backend\Model\View\Result\ForwardFactory;
use Magento\Framework\App\Action\Context;
use Magento\Framework\App\Config\ScopeConfigInterface;
use Magento\Framework\App\ObjectManager;
use Magento\Framework\Registry;
use Magento\Framework\View\DesignInterface;
use Magento\Framework\View\LayoutFactory;
use Magento\Store\Model\StoreManagerInterface;
use Unirgy\DropshipMulti\Helper\Data as DropshipMultiHelperData;
use Unirgy\Dropship\Helper\Data as HelperData;
use Unirgy\Dropship\Model\Session;

class Save extends AbstractProduct
{
    public function execute()
    {
        try {
            $hlp = $this->_hlp->getObj('\Unirgy\DropshipMulti\Helper\Data');
            $cnt = $hlp->saveVendorProducts($this->getRequest()->getParam('vp'));
            if ($cnt) {
                $this->messageManager->addSuccess(__($cnt==1 ? '%1 product was updated' : '%1 products were updated', $cnt));
            } else {
                $this->messageManager->addNotice(__('No updates were made'));
            }
        } catch (\Exception $e) {
            $this->messageManager->addError($e->getMessage());
        }
        /* @var \Magento\Framework\App\Response\RedirectInterface $redirect */
        $redirect = $this->_hlp->getObj('Magento\Framework\App\Response\RedirectInterface');
        $redirectResult = $this->resultRedirectFactory->create();
        return $redirectResult->setUrl($this->_url->getUrl('udmulti/vendor_product'));
    }
}
