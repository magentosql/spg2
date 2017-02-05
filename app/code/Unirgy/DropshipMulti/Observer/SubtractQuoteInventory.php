<?php

namespace Unirgy\DropshipMulti\Observer;

use Magento\Framework\Event\ObserverInterface;
use Magento\CatalogInventory\Api\StockManagementInterface;
use Magento\Framework\Event\Observer as EventObserver;

class SubtractQuoteInventory extends \Magento\CatalogInventory\Observer\SubtractQuoteInventoryObserver
{
    protected $_multiHlp;
    protected $_hlp;
    protected $_stockItemFactory;
    protected $_vendorProductFactory;
    protected $_storeManager;

    public function __construct(
        \Unirgy\DropshipMulti\Helper\Data $multiHelper,
        \Unirgy\Dropship\Helper\Data $udropshipHelper,
        \Magento\CatalogInventory\Model\Stock\ItemFactory $stockItemFactory,
        \Unirgy\Dropship\Model\Vendor\ProductFactory $vendorProductFactory,
        \Magento\Store\Model\StoreManagerInterface $storeManager,
        StockManagementInterface $stockManagement,
        \Magento\CatalogInventory\Observer\ProductQty $productQty,
        \Magento\CatalogInventory\Observer\ItemsForReindex $itemsForReindex
    )
    {
        $this->_multiHlp = $multiHelper;
        $this->_hlp = $udropshipHelper;
        $this->_stockItemFactory = $stockItemFactory;
        $this->_vendorProductFactory = $vendorProductFactory;
        $this->_storeManager = $storeManager;
        parent::__construct($stockManagement, $productQty, $itemsForReindex);
    }
    public function execute(EventObserver $observer)
    {
        if (!$this->_multiHlp->isActive()) {
            return parent::execute($observer);
        }
        $quote = $observer->getEvent()->getQuote();

        // Maybe we've already processed this quote in some event during order placement
        // e.g. call in event 'sales_model_service_quote_submit_before' and later in 'checkout_submit_all_after'
        if ($quote->getInventoryProcessed()) {
            return;
        }
        $update = [];
        $allPids = [];
        foreach ($quote->getAllItems() as $item) {
            if (!$item->getChildren()) {
                $pId = $item->getProductId();
                $vId = $item->getUdropshipVendor();
                $v = $this->_hlp->getVendor($vId);
                if (!$v->getId() && $v->getStockcheckMethod()) continue;
                $allPids[$pId] = $pId;
                if (isset($update[$vId][$pId])) {
                    $update[$vId][$pId]['stock_qty_add'] -= $item->getTotalQty();
                } else {
                    $update[$vId][$pId] = [
                        'stock_qty_add' => -$item->getTotalQty(),
                    ];
                }
            }
        }

        $this->itemsForReindex->setItems([]);

        if (empty($allPids)) {
            return $this;
        }

        $this->_hlp->rHlp()->beginTransaction();
        $siData = $this->_hlp->rHlp()->loadDbColumnsForUpdate(
            $this->_stockItemFactory->create(),
            ['product_id'=>$allPids],
            ['backorders','use_config_backorders']
        );

        $hlpm = $this->_multiHlp;
        $rHlp = $this->_hlp->rHlp();
        $conn = $rHlp->getConnection();
        foreach ($update as $vId=>$_update) {
            $mvData = $rHlp->loadDbColumnsForUpdate(
                $this->_vendorProductFactory->create(),
                ['product_id'=>array_keys($_update)],
                ['backorders','stock_qty','product_id','status'],
                $conn->quoteInto('{{table}}.vendor_id=?', $vId)
            );
            foreach ($_update as $pId => $_prod) {
                $qtyCheck = abs($_prod['stock_qty_add']);
                if (!array_key_exists($pId, $mvData)) {
                    if ($this->_hlp->isAdmin()) continue;
                    throw new \Exception(
                        __('Stock configuration problem')
                    );
                }
                $_mv = $mvData[$pId];
                if (!$hlpm->isQtySalableByVendorData($qtyCheck, (array)@$siData[$pId], $vId, $_mv)) {
                    if ($this->_hlp->isAdmin()) continue;
                    throw new \Exception(
                        __('Not all products are available in the requested quantity')
                    );
                }
            }

        }
        foreach ($update as $vId=>$_update) {
            $this->_multiHlp->setReindexFlag(false);
            $this->_multiHlp->saveThisVendorProductsPidKeys($_update, $vId);
            $this->_multiHlp->setReindexFlag(true);
        }
        $this->_hlp->rHlp()->commit();

        $quote->setInventoryProcessed(true);
        return $this;
    }
}