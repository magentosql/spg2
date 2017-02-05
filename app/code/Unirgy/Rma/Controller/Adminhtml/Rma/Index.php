<?php

namespace Unirgy\Rma\Controller\Adminhtml\Rma;

class Index extends AbstractRma
{
    public function execute()
    {
        $resultPage = $this->_initAction();
        return $resultPage;
    }
}
