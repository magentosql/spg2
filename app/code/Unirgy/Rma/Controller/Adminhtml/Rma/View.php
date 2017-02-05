<?php

namespace Unirgy\Rma\Controller\Adminhtml\Rma;



class View extends AbstractRma
{
    public function execute()
    {
        if ($rmaId = $this->getRequest()->getParam('rma_id')) {
            $this->_forward('view', 'order_rma', null, ['come_from'=>'urma']);
        } else {
            $this->_forward('noRoute');
        }
    }
}
