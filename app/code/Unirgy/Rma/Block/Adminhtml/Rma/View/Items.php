<?php

namespace Unirgy\Rma\Block\Adminhtml\Rma\View;

use Magento\Sales\Block\Adminhtml\Items\AbstractItems;

class Items extends AbstractItems
{
    public function getRma()
    {
        return $this->_coreRegistry->registry('current_rma');
    }

    public function getOrder()
    {
        return $this->getRma()->getOrder();
    }

    public function getSource()
    {
        return $this->getRma();
    }
}