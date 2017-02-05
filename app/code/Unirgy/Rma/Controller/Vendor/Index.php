<?php

namespace Unirgy\Rma\Controller\Vendor;

class Index extends AbstractVendor
{
    public function execute()
    {
    	$_hlp = $this->_rmaHlp;
        switch ($this->getRequest()->getParam('submit_action')) {
            case 'updateUrmaStatus':
                $this->_forward('updateUrmaStatus', 'vendor', 'urma');
                return;
            default:
                $this->_renderPage(null, 'urmas');
        }
    }
}
