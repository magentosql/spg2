<?php

namespace Unirgy\DropshipMulti\Observer;

use Magento\Framework\Event\Observer;
use Magento\Framework\Event\ObserverInterface;

class SalesQuoteItemCollectionProductsAfterLoadAdmin extends AbstractObserver implements ObserverInterface
{
    public function execute(Observer $observer)
    {
        $this->_sales_quote_item_collection_products_after_load($observer, false);
    }
}
