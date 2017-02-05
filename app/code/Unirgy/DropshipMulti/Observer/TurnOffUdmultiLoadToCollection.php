<?php

namespace Unirgy\DropshipMulti\Observer;

use Magento\Framework\Event\Observer;
use Magento\Framework\Event\ObserverInterface;

class TurnOffUdmultiLoadToCollection extends AbstractObserver implements ObserverInterface
{
    public function execute(Observer $observer)
    {
        $this->_multiHlp->isUdmultiLoadToCollection = false;
    }
}
