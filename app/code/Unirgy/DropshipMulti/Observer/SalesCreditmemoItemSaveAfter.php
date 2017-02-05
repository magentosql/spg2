<?php

namespace Unirgy\DropshipMulti\Observer;

use Magento\Framework\Event\Observer;
use Magento\Framework\Event\ObserverInterface;
use Unirgy\DropshipMulti\Helper\Data as HelperData;
use Unirgy\Dropship\Helper\Data as DropshipHelperData;

class SalesCreditmemoItemSaveAfter extends AbstractObserver implements ObserverInterface
{

    public function __construct(HelperData $helperData, 
        DropshipHelperData $dropshipHelperData)
    {


        parent::__construct($helperData, $dropshipHelperData);
    }

    public function execute(Observer $observer)
    {
        if (!$this->_multiHlp->isActive()) {
            return $this;
        }
        $item = $observer->getEvent()->getCreditmemoItem();
        if ($item->getId() && $item->getProductId() && $item->getBackToStock()) {
            $this->_multiHlp->updateItemStock($item, $item->getQty());
        }
        return $this;
    }
}
