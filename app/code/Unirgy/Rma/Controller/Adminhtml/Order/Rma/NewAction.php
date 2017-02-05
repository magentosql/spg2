<?php

namespace Unirgy\Rma\Controller\Adminhtml\Order\Rma;

class NewAction extends AbstractRma
{
    public function execute()
    {
        if ($rma = $this->_initRma(false)) {

            $resultPage = $this->_initAction();
            $resultPage->addBreadcrumb(
                __('New Return'),
                __('New Return')
            );
            $resultPage->getConfig()->getTitle()->prepend(
                __('New Return')
            );

            if ($comment = $this->_session->getCommentText(true)) {
                $rma->setCommentText($comment);
            }

            return $resultPage;
        } else {
            $this->_redirect('sales/order/view', ['order_id'=>$this->getRequest()->getParam('order_id')]);
        }
    }
}
