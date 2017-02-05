<?php

namespace Unirgy\DropshipMulti\Observer;

use Magento\Framework\Event\ObserverInterface;
use Magento\CatalogInventory\Api\StockManagementInterface;
use Magento\Framework\Event\Observer as EventObserver;

class CancelOrderItem extends \Magento\CatalogInventory\Observer\CancelOrderItemObserver
{
    protected $_multiHlp;
    protected $_hlp;
    public function __construct(
        \Unirgy\Dropship\Helper\Data $udropshipHelper,
        \Unirgy\DropshipMulti\Helper\Data $multiHelper,
        StockManagementInterface $stockManagement,
        \Magento\Catalog\Model\Indexer\Product\Price\Processor $priceIndexer
    )
    {
        $this->_hlp = $udropshipHelper;
        $this->_multiHlp = $multiHelper;
        parent::__construct($stockManagement, $priceIndexer);
    }
    public function cancelOrderItem($observer)
    {
        if (!$this->_multiHlp->isActive()) {
            return parent::execute($observer);
        }
        $item = $observer->getEvent()->getItem();

        $children = $item->getChildrenItems();
        $qty = $item->getQtyOrdered() - max($item->getQtyShipped(), $item->getQtyInvoiced()) - $item->getQtyCanceled();

        if ($item->getId() && ($productId = $item->getProductId()) && empty($children)) {
            $qty = $item->getQtyOrdered() - $item->getQtyCanceled();
            $parentItem = $item->getParentItem();
            $qtyInvoiced = $qtyShipped = 0;
            if ($item->isDummy(true) && $parentItem) {
                $parentQtyShipped = $parentItem->getQtyShipped();
                $parentQtyOrdered = $parentItem->getQtyOrdered();
                $parentQtyOrdered = $parentQtyOrdered > 0 ? $parentQtyOrdered : 1;
                $qtyShipped = $parentQtyShipped*$item->getQtyOrdered()/$parentQtyOrdered;
            } elseif (!$item->isDummy(true)) {
                $qtyShipped = $item->getQtyShipped();
            }
            if ($item->isDummy() && $parentItem) {
                $parentQtyInvoiced = $parentItem->getQtyInvoiced();
                $parentQtyOrdered = $parentItem->getQtyOrdered();
                $parentQtyOrdered = $parentQtyOrdered > 0 ? $parentQtyOrdered : 1;
                $qtyInvoiced = $parentQtyInvoiced*$item->getQtyOrdered()/$parentQtyOrdered;
            } elseif (!$item->isDummy()) {
                $qtyInvoiced = $item->getQtyInvoiced();
            }
            $qty -= max($qtyShipped, $qtyInvoiced);
            if ($qty>0) {
                $this->_multiHlp->saveThisVendorProductsPidKeys(
                    [$productId=>['stock_qty_add'=>$qty]],
                    $item->getUdropshipVendor()
                );
            }
        }

        return $this;
    }
}