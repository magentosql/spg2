<?php

namespace Unirgy\DropshipMulti\Observer;

use Magento\Framework\Event\Observer;
use Magento\Framework\Event\ObserverInterface;

class CatalogProductLoadAfterFront extends AbstractObserver implements ObserverInterface
{
    public function execute(Observer $observer)
    {
        $this->_catalog_product_load_after($observer, true);
    }
}
