<?php

namespace Unirgy\Rma\Block\Adminhtml\Rma\View\Tracking;

use Magento\Backend\Block\Template;

class Info extends Template
{
    protected function _construct()
    {
        parent::_construct();
        $this->setTemplate('sales/order/shipment/tracking/info.phtml');
    }
}
