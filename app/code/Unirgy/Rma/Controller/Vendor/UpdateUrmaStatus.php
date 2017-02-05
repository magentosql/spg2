<?php

namespace Unirgy\Rma\Controller\Vendor;

use Magento\Backend\Model\View\Result\ForwardFactory;
use Magento\Framework\App\Action\Context;
use Magento\Framework\App\Config\ScopeConfigInterface;
use Magento\Framework\Controller\Result\RawFactory;
use Magento\Framework\HTTP\Header;
use Magento\Framework\Registry;
use Magento\Framework\View\DesignInterface;
use Magento\Framework\View\LayoutFactory;
use Magento\Framework\View\Result\PageFactory;
use Magento\Store\Model\StoreManagerInterface;
use Unirgy\Dropship\Helper\Data as HelperData;
use Unirgy\Rma\Helper\Data as RmaHelperData;

class UpdateUrmaStatus extends AbstractVendor
{

    public function execute()
    {
        try {
            $urmas = $this->getVendorRmaCollection();
            $r = $this->getRequest();
            $rmaStatus = $this->getRequest()->getParam('update_status');

            if (!$urmas->getSize()) {
                throw new \Exception(__('No RMAs found for these criteria'));
            }
            if (is_null($rmaStatus) || $rmaStatus==='') {
                throw new \Exception(__('No status selected'));
            }

            $vendorId = $this->_getSession()->getId();
            $vendor = $this->_hlp->getVendor($vendorId);

            $hlp = $this->_hlp;
            $urmaHlp = $this->_rmaHlp;

            foreach ($urmas as $urma) {
                if (!is_null($rmaStatus) && $rmaStatus!=='' && $rmaStatus!=$urma->getRmaStatus()) {
                    $urmaHlp->processRmaStatusSave($urma, $rmaStatus, true, $vendor);
                }
            }
            $this->messageManager->addSuccess(__('RMA status has been updated'));
        } catch (\Exception $e) {
            $this->messageManager->addError(__($e->getMessage()));
        }
        $this->_redirect('urma/vendor/', ['_current'=>true, '_query'=>['submit_action'=>'']]);
    }
}
