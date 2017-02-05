<?php

namespace Unirgy\Rma\Controller\Order;

use Magento\Framework\App\ObjectManager;

class NewRma extends AbstractOrder
{
   public function execute()
    {
        try {
            $rma = $this->_initRma();
            return parent::execute();
        } catch (\Exception $e) {
            $this->messageManager->addError($e->getMessage());
            $this->_redirect('*/*/view', ['order_id'=>$this->getRequest()->getParam('order_id')]);
        }
    }
}
