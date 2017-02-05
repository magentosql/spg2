<?php

namespace Unirgy\DropshipMulti\Observer;

use Magento\Framework\Event\ObserverInterface;
use Magento\CatalogInventory\Api\StockManagementInterface;
use Magento\Framework\Event\Observer as EventObserver;

class RefundOrderInventory extends \Magento\CatalogInventory\Observer\RefundOrderInventoryObserver
{
    protected $_multiHlp;
    protected $_hlp;
    public function __construct(
        \Unirgy\Dropship\Helper\Data $udropshipHelper,
        \Unirgy\DropshipMulti\Helper\Data $multiHelper,
        \Magento\CatalogInventory\Api\StockConfigurationInterface $stockConfiguration,
        StockManagementInterface $stockManagement,
        \Magento\CatalogInventory\Model\Indexer\Stock\Processor $stockIndexerProcessor,
        \Magento\Catalog\Model\Indexer\Product\Price\Processor $priceIndexer
    )
    {
        $this->_hlp = $udropshipHelper;
        $this->_multiHlp = $multiHelper;
        parent::__construct($stockConfiguration, $stockManagement, $stockIndexerProcessor, $priceIndexer);
    }

    public function execute(EventObserver $observer)
    {
        if (!$this->_multiHlp->isActive()) {
            return parent::execute($observer);
        }
        $creditmemo = $observer->getEvent()->getCreditmemo();
        $parentItems = $items = [];

        foreach ($creditmemo->getAllItems() as $item) {
            $return = false;
            if ($item->hasBackToStock()) {
                if ($item->getBackToStock() && $item->getQty()) {
                    $return = true;
                }
            } elseif ($this->stockConfiguration->isAutoReturnEnabled()) {
                $return = true;
            }
            $oItem = $item->getOrderItem();
            $children = $oItem->getChildrenItems() ? $oItem->getChildrenItems() : $oItem->getChildren();
            if (($oParent = $oItem->getParentItem())) {
                $parentItem = @$parentItems[$oParent->getId()];
            } else {
                $parentItem = null;
            }
            if ($children) {
                $parentItems[$oItem->getId()] = $item;
            } elseif ($return && ($vId = $oItem->getUdropshipVendor())) {
                $qty = null;
                if ($oItem->isDummy() && $parentItem) {
                    $parentQtyOrdered = $parentItem->getOrderItem()->getQtyOrdered();
                    $parentQtyOrdered = $parentQtyOrdered > 0 ? $parentQtyOrdered : 1;
                    $qty = $parentItem->getQty()*$oItem->getQtyOrdered()/$parentQtyOrdered;
                } elseif (!$oItem->isDummy()) {
                    $qty = $item->getQty();;
                }
                if ($qty !== null) {
                    if (isset($items[$vId][$item->getProductId()])) {
                        $items[$vId][$item->getProductId()]['stock_qty_add'] += $qty;
                    } else {
                        $items[$vId][$item->getProductId()] = [
                            'stock_qty_add' => $qty,
                        ];
                    }
                }
            }
        }
        if (!empty($items)) {
            $reindexPids = [];
            foreach ($items as $vId=>$update) {
                $reindexPids = array_merge($reindexPids, array_keys($update));
                $this->_multiHlp->setReindexFlag(false);
                $this->_multiHlp->saveThisVendorProductsPidKeys($update, $vId);
                $this->_multiHlp->setReindexFlag(true);
            }
            $reindexPids = array_unique($reindexPids);

            /* @var \Magento\Framework\Indexer\IndexerRegistry $indexerRegistry */
            $indexerRegistry = $this->_hlp->getObj('\Magento\Framework\Indexer\IndexerRegistry');
            /* @var \Magento\Indexer\Model\Config $indexerConfig */
            $indexerConfig = $this->_hlp->getObj('\Magento\Indexer\Model\Config');

            foreach ([
                 \Unirgy\Dropship\Model\Indexer\ProductVendorAssoc\Processor::INDEXER_ID,
                 \Magento\CatalogInventory\Model\Indexer\Stock\Processor::INDEXER_ID,
                 \Magento\Catalog\Model\Indexer\Product\Price\Processor::INDEXER_ID,
             ] as $indexerId) {
                if (!$indexerConfig->getIndexer($indexerId)) continue;
                $indexer = $indexerRegistry->get($indexerId);
                if ($indexer && !$indexer->isScheduled()) {
                    $indexer->reindexList($reindexPids);
                }
            }
        }
    }
}