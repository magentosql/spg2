<?php

namespace Unirgy\DropshipMulti\Observer;

use Magento\Framework\Event\Observer;
use Magento\Framework\Event\ObserverInterface;

class SalesOrderShipmentSaveAfter extends AbstractObserver implements ObserverInterface
{
    public function execute(Observer $observer)
    {
        $shipment = $observer->getShipment();
        $oldStatus = $shipment->getOrigData('udropship_status');
        $newStatus = $shipment->getData('udropship_status');
        $this->processShipmentStatusChange($shipment, $oldStatus, $newStatus);
    }
}
