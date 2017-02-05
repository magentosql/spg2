<?php

namespace Unirgy\DropshipMultiPrice\Observer;

use Magento\Framework\Event\Observer;
use Magento\Framework\Event\ObserverInterface;
use Magento\Quote\Model\Quote\Address\Item;
use Unirgy\DropshipMultiPrice\Helper\Data as DropshipMultiPriceHelperData;
use Unirgy\Dropship\Helper\Data as HelperData;

class SalesConvertQuoteItemToOrderItem extends AbstractObserver implements ObserverInterface
{

    public function __construct(HelperData $helperData, 
        DropshipMultiPriceHelperData $dropshipMultiPriceHelperData)
    {


        parent::__construct($helperData, $dropshipMultiPriceHelperData);
    }

    public function execute(Observer $observer)
    {
        if (!$this->_hlp->isUdmultiActive()) return;
        $qItem = $observer->getEvent()->getItem();
        $oItem = $observer->getEvent()->getOrderItem();
        if ($qItem instanceof Item) {
            $qItem = $qItem->getQuoteItem();
        }
        $oItem->setProduct($qItem->getProduct());
        $this->_mpHlp->addVendorOption($oItem);
    }
}
