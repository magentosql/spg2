<?php

namespace Unirgy\DropshipMultiPrice\Observer;

use Magento\Framework\Event\Observer;
use Magento\Framework\Event\ObserverInterface;
use Unirgy\DropshipMultiPrice\Helper\Data as DropshipMultiPriceHelperData;
use Unirgy\Dropship\Helper\Data as HelperData;

class UdropshipQuoteItemSetUdropshipVendor extends AbstractObserver implements ObserverInterface
{

    public function __construct(HelperData $helperData, 
        DropshipMultiPriceHelperData $dropshipMultiPriceHelperData)
    {


        parent::__construct($helperData, $dropshipMultiPriceHelperData);
    }

    public function execute(Observer $observer)
    {
        if (!$this->_hlp->isUdmultiActive()) return;
        $item = $observer->getItem();
        $this->_mpHlp->addVendorOption($item);
    }
}
