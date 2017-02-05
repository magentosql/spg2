<?php

namespace Unirgy\Rma\Block\Adminhtml\Rma\Create;

use Magento\Backend\Block\Template\Context;
use Magento\Framework\Registry;
use Magento\Sales\Block\Adminhtml\Order\AbstractOrder;
use Magento\Sales\Helper\Admin;

class Form extends AbstractOrder
{
    public function getOrder()
    {
        return $this->getRma()->getOrder();
    }

    public function getSource()
    {
        return $this->getRma();
    }

    public function getRma()
    {
        return $this->_coreRegistry->registry('current_rma');
    }

    public function getPaymentHtml()
    {
        return $this->getChildHtml('order_payment');
    }

    public function getItemsHtml()
    {
        return $this->getChildHtml('order_items');
    }

    public function getSaveUrl()
    {
        return $this->getUrl('urma/order_rma/save', ['order_id' => $this->getRma()->getOrderId()]);
    }
}
