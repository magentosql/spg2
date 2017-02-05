<?php

namespace Unirgy\Rma\Controller\Order;

use Magento\Framework\App\ObjectManager;
use Magento\Sales\Model\OrderFactory;
use Unirgy\Rma\Model\RmaFactory;

class SaveRma extends AbstractOrder
{
    public function execute()
    {
        try {
            $this->_saveRma();
            $this->messageManager->addSuccess(
                $this->_hlp->getScopeConfig('urma/message/customer_success')
            );
            $this->_redirect('*/*/rma', ['order_id'=>$this->getRequest()->getParam('order_id')]);
        } catch (\Exception $e) {
            $this->messageManager->addError($e->getMessage());
            $this->_redirect('*/*/newRma', ['order_id'=>$this->getRequest()->getParam('order_id')]);
        }
    }
}
