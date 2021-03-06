<?php

namespace Unirgy\DropshipMulti\Observer;

use Magento\Framework\Event\Observer;
use Magento\Framework\Event\ObserverInterface;

class UdropshipShipmentStatusSaveAfter extends AbstractObserver implements ObserverInterface
{
    public function execute(Observer $observer)
    {
        $shipment = $observer->getShipment();
        $oldStatus = $observer->getOldStatus();
        $newStatus = $observer->getNewStatus();
        $this->processShipmentStatusChange($shipment, $oldStatus, $newStatus);
    }
}
