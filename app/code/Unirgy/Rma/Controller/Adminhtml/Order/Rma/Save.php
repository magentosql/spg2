<?php

namespace Unirgy\Rma\Controller\Adminhtml\Order\Rma;



class Save extends AbstractRma
{
    public function execute()
    {
        try {
            $this->_saveRma();
            $this->messageManager->addSuccess(__('The Return has been created.'));
            $this->_session->getCommentText(true);
            $this->_redirect('sales/order/view', ['order_id' => $this->getRequest()->getParam('order_id')]);
        } catch (\Exception $e) {
            $this->messageManager->addError($e->getMessage());
            $this->_redirect('*/*/new', ['order_id'=>$this->getRequest()->getParam('order_id')]);
        }
    }
}
