<?php

namespace Unirgy\Rma\Controller\Adminhtml\Order\Rma;

class RmasTab extends AbstractRma
{
    public function execute()
    {
        $this->_initRma(false);
        $this->_view->loadLayout();
        $this->_view->renderLayout();
    }
}
