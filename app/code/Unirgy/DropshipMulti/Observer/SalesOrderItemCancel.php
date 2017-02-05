<?php

namespace Unirgy\DropshipMulti\Observer;

use Magento\Framework\Event\Observer;
use Magento\Framework\Event\ObserverInterface;
use Unirgy\DropshipMulti\Helper\Data as HelperData;
use Unirgy\Dropship\Helper\Data as DropshipHelperData;

class SalesOrderItemCancel extends AbstractObserver implements ObserverInterface
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
        $item = $observer->getEvent()->getItem();
        $children = $item->getChildrenItems() ? $item->getChildrenItems() : $item->getChildren();
        $qty = $item->getQtyOrdered() - max($item->getQtyShipped(), $item->getQtyInvoiced()) - $item->getQtyCanceled();
        if ($item->getId() && $item->getProductId() && empty($children) && $qty) {
            $this->_multiHlp->updateItemStock($item, $qty);
        }
        return $this;
    }
}
