<?php

namespace Unirgy\DropshipMulti\Observer;

use Magento\Framework\Event\ObserverInterface;
use Magento\CatalogInventory\Api\StockManagementInterface;
use Magento\Framework\Event\Observer as EventObserver;


class RevertQuoteInventory extends \Magento\CatalogInventory\Observer\RevertQuoteInventoryObserver
{
    protected $_multiHlp;
    public function __construct(
        \Unirgy\DropshipMulti\Helper\Data $multiHelper,
        \Magento\CatalogInventory\Observer\ProductQty $productQty,
        StockManagementInterface $stockManagement,
        \Magento\CatalogInventory\Model\Indexer\Stock\Processor $stockIndexerProcessor,
        \Magento\Catalog\Model\Indexer\Product\Price\Processor $priceIndexer
    )
    {
        $this->_multiHlp = $multiHelper;
        parent::__construct($productQty, $stockManagement, $stockIndexerProcessor, $priceIndexer);
    }
    public function execute(EventObserver $observer)
    {
        if (!$this->_multiHlp->isActive()) {
            return parent::execute($observer);
        }
        $quote = $observer->getEvent()->getQuote();

        if (!$quote->getInventoryProcessed()) {
            return;
        }
        $update = [];
        foreach ($quote->getAllItems() as $item) {
            if (!$item->getChildren()) {
                $pId = $item->getProductId();
                $vId = $item->getUdropshipVendor();
                if (isset($update[$vId][$pId])) {
                    $update[$vId][$pId]['stock_qty_add'] += $item->getTotalQty();
                } else {
                    $update[$vId][$pId] = [
                        'stock_qty_add' => $item->getTotalQty(),
                    ];
                }
            }
        }

        foreach ($update as $vId=>$_update) {
            $this->_multiHlp->setReindexFlag(false);
            $this->_multiHlp->saveThisVendorProductsPidKeys($_update, $vId);
            $this->_multiHlp->setReindexFlag(true);
        }

        $quote->setInventoryProcessed(false);
    }
}