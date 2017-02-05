<?php

namespace Unirgy\DropshipPo\Controller\Adminhtml\Order\Po;



class NewShipment extends AbstractPo
{
    public function execute()
    {
        if (($udpo = $this->_initPo(false))
            && ($shipment = $this->_initShipment($udpo, false))
        ) {

            if ($comment = $this->_session->getShipmentCommentText(true)) {
                $shipment->setCommentText($comment);
            }

            $resultPage = $this->_initAction();
            $resultPage->addBreadcrumb(
                __('New Shipment'),
                __('New Shipment')
            );
            $resultPage->getConfig()->getTitle()->prepend(
                __('New Shipment')
            );

            return $resultPage;
        } else {
            return $this->_redirect('sales/order/view', ['order_id'=>$this->getRequest()->getParam('order_id')]);
        }
    }
}
