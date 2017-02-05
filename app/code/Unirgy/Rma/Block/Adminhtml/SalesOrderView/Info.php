<?php

namespace Unirgy\Rma\Block\Adminhtml\SalesOrderView;

use Magento\Sales\Block\Adminhtml\Order\View\Info as ViewInfo;

class Info extends ViewInfo
{
    public function getCustomerViewUrl()
    {
        if ($this->getOrder()->getCustomerIsGuest()) {
            return false;
        }
        return $this->getUrl('customer/index/edit', ['id' => $this->getOrder()->getCustomerId()]);
    }

    public function getViewUrl($orderId)
    {
        return $this->getUrl('sales/order/view', ['order_id'=>$orderId]);
    }
    public function getRmaReasonName()
    {
        return $this->_coreRegistry->registry('current_rma') ? $this->_coreRegistry->registry('current_rma')->getRmaReasonName() : '';
    }
}