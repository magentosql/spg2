<?php

namespace Unirgy\DropshipMulti\Observer;

use Magento\Framework\Event\Observer;
use Magento\Framework\Event\ObserverInterface;

class CatalogProductIsSalableAfter extends AbstractObserver implements ObserverInterface
{
    public function execute(Observer $observer)
    {
        $salable = $observer->getSalable();
        $product = $observer->getProduct();
        if ($product->getForcedUdropshipVendor() && !$product->isComposite() && $this->_hlp->getStockItem($product)) {
            $salable->setIsSalable($salable->getIsSalable() && $this->_hlp->getStockItem($product)->getIsInStock());
        }
    }
}
