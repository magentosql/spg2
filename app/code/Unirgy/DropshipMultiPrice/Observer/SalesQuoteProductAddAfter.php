<?php

namespace Unirgy\DropshipMultiPrice\Observer;

use Magento\Framework\Event\Observer;
use Magento\Framework\Event\ObserverInterface;

class SalesQuoteProductAddAfter extends AbstractObserver implements ObserverInterface
{
    public function execute(Observer $observer)
    {
        if (!$this->_hlp->isUdmultiActive()) return;
        $items = $observer->getItems();
        foreach ($items as $item) {
            if (!$item->getParentItem()) {
                $this->_mpHlp->addBRVendorOption($item);
            }
        }
    }
}
