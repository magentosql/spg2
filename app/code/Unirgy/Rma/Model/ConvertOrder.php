<?php

namespace Unirgy\Rma\Model;

use Magento\Framework\App\Helper\AbstractHelper;
use Magento\Framework\DataObject\Copy;
use Magento\Framework\Event\ManagerInterface;
use Magento\Sales\Api\CreditmemoRepositoryInterface;
use Magento\Sales\Api\InvoiceRepositoryInterface;
use Magento\Sales\Api\ShipmentRepositoryInterface;
use Magento\Sales\Model\Convert\Order;
use Magento\Sales\Model\Order as ModelOrder;
use Magento\Sales\Model\Order\Creditmemo\ItemFactory as CreditmemoItemFactory;
use Magento\Sales\Model\Order\Invoice\ItemFactory;
use Magento\Sales\Model\Order\Item;
use Magento\Sales\Model\Order\Shipment\ItemFactory as ShipmentItemFactory;
use Unirgy\Rma\Model\Rma\ItemFactory as RmaItemFactory;

class ConvertOrder extends Order
{
    /**
     * @var RmaFactory
     */
    protected $_rmaFactory;

    /**
     * @var RmaItemFactory
     */
    protected $_rmaItemFactory;

    public function __construct(ManagerInterface $eventManager, 
        InvoiceRepositoryInterface $invoiceRepository, 
        ItemFactory $invoiceItemFactory, 
        ShipmentRepositoryInterface $shipmentRepository, 
        ShipmentItemFactory $shipmentItemFactory, 
        CreditmemoRepositoryInterface $creditmemoRepository, 
        CreditmemoItemFactory $creditmemoItemFactory, 
        Copy $objectCopyService, 
        RmaFactory $modelRmaFactory, 
        RmaItemFactory $rmaItemFactory,
        array $data = [])
    {
        $this->_rmaFactory = $modelRmaFactory;
        $this->_rmaItemFactory = $rmaItemFactory;

        parent::__construct($eventManager, $invoiceRepository, $invoiceItemFactory, $shipmentRepository, $shipmentItemFactory, $creditmemoRepository, $creditmemoItemFactory, $objectCopyService, $data);
    }

    public function toRma(ModelOrder $order)
    {
        $rma = $this->_rmaFactory->create();
        $rma->setOrder($order)
            ->setStoreId($order->getStoreId())
            ->setCustomerId($order->getCustomerId())
            ->setBillingAddressId($order->getBillingAddressId())
            ->setShippingAddressId($order->getShippingAddressId());

        $this->_objectCopyService->copyFieldsetToTarget('sales_convert_order', 'to_urma', $order, $rma);
        return $rma;
    }
    public function itemToRmaItem(Item $item)
    {
        $rmaItem = $this->_rmaItemFactory->create();
        $rmaItem->setOrderItem($item)
            ->setProductId($item->getProductId());

        $this->_objectCopyService->copyFieldsetToTarget('sales_convert_order_item', 'to_urma_item', $item, $rmaItem);
        return $rmaItem;
    }
}