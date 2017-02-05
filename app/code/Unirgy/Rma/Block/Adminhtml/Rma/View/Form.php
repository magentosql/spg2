<?php

namespace Unirgy\Rma\Block\Adminhtml\Rma\View;

use Magento\Backend\Block\Template;

class Form extends Template
{
    protected function _construct()
    {
        parent::_construct();
        $this->setTemplate('Unirgy_Rma::urma/rma/view/form.phtml');
    }
}