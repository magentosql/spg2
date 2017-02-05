<?php

namespace Unirgy\DropshipMultiPrice\Observer;

use Magento\Framework\Event\Observer;
use Magento\Framework\Event\ObserverInterface;

class CatalogProductGetFinalPrice extends AbstractObserver implements ObserverInterface
{
    public function execute(Observer $observer)
    {
        if (!$this->_hlp->isUdmultiActive()) return;
        $product = $observer->getProduct();
        if (!in_array($product->getTypeId(), ['simple','configurable','virtual'])) return;
        $qty     = $observer->getQty();
        if ($this->_mpHlp->canUseVendorPrice($product)) {
            if (!$product->getUdmultiPriceUsedVendorPriceFlag()) {
                $this->_mpHlp->useVendorPrice($product);
                $product->setUdmultiPriceUsedVendorPriceFlag(true);
                try {
                    $product->getFinalPrice($qty);
                } catch (\Unirgy\DropshipMultiPrice\Exception $e) {}
            } else {
                $this->_mpHlp->revertVendorPrice($product);
                $product->unsUdmultiPriceUsedVendorPriceFlag();
                throw new \Unirgy\DropshipMultiPrice\Exception();
            }
        }
    }
}
