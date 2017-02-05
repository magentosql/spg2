<?php

namespace Unirgy\DropshipMulti\Observer;

use Magento\CatalogInventory\Model\Stock\Status;
use Magento\Framework\Event\Observer;
use Magento\Framework\Event\ObserverInterface;
use Unirgy\DropshipMulti\Helper\Data as HelperData;
use Unirgy\Dropship\Helper\Data as DropshipHelperData;

class CataloginventoryStockItemSaveAfter extends AbstractObserver implements ObserverInterface
{
    /**
     * @var Status
     */
    protected $_stockStatus;

    public function __construct(HelperData $helperData, 
        DropshipHelperData $dropshipHelperData, 
        Status $stockStatus)
    {
        $this->_stockStatus = $stockStatus;

        parent::__construct($helperData, $dropshipHelperData);
    }

    public function execute(Observer $observer)
    {
        if (!$this->_multiHlp->isActive()) {
            return;
        }
        $item = $observer->getEvent()->getItem();
        $product = $item->getProductObject();

        if (!$product || !$product->hasUdmultiStock()) {
            return;
        }
        $data = (array)$product->getUpdateUdmultiVendors();

        $this->_stockStatus
            ->updateStatus($product->getId());
    }
}
