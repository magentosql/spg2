<?php

namespace Unirgy\Rma\Block\Adminhtml;

use Magento\Backend\Block\Widget\Grid\Container;

class Rma extends Container
{
    protected $_blockGroup = 'Unirgy_Rma';

    public function _construct()
    {
        $this->_controller = 'adminhtml_rma';
        $this->_headerText = __('uReturns');
        parent::_construct();
        $this->removeButton('add');
    }
}