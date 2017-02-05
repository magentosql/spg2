<?php

namespace Unirgy\Rma\Controller\Adminhtml\Order\Rma;



class View extends AbstractRma
{
    public function execute()
    {
        if ($rma = $this->_initRma(false)) {
            $resultPage = $this->_initAction();
            $id = $this->getRequest()->getParam('id');
            $resultPage->addBreadcrumb(
                "#" . $rma->getIncrementId(),
                "#" . $rma->getIncrementId()
            );
            $resultPage->getConfig()->getTitle()->prepend(
                "#" . $rma->getIncrementId()
            );
            return $resultPage;
        } else {
            $this->_redirect('sales/order/view', ['order_id'=>$this->getRequest()->getParam('order_id')]);
        }
    }
}
