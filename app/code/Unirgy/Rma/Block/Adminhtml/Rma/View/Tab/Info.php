<?php

namespace Unirgy\Rma\Block\Adminhtml\Rma\View\Tab;

use Magento\Backend\Block\Widget\Tab\TabInterface;
use Magento\Sales\Block\Adminhtml\Order\AbstractOrder;

class Info
    extends AbstractOrder
    implements TabInterface
{

    public function getRma()
    {
        return $this->_coreRegistry->registry('current_rma');
    }
    
    public function getOrder()
    {
        return $this->_coreRegistry->registry('current_order');
    }

    public function getSource()
    {
        return $this->getRma();
    }
    
    /**
     * ######################## TAB settings #################################
     */
    public function getTabLabel()
    {
        return __('Information');
    }

    public function getTabTitle()
    {
        return __('Order Information');
    }

    public function canShowTab()
    {
        return true;
    }

    public function isHidden()
    {
        return false;
    }
}