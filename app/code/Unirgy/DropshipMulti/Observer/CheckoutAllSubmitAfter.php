<?php

namespace Unirgy\DropshipMulti\Observer;

use Magento\Framework\Event\ObserverInterface;
use Magento\Framework\Event\Observer as EventObserver;

class CheckoutAllSubmitAfter implements ObserverInterface
{
    protected $subtractQuoteInventoryObserver;

    protected $reindexQuoteInventoryObserver;

    public function __construct(
        \Unirgy\DropshipMulti\Observer\SubtractQuoteInventory $subtractQuoteInventoryObserver,
        \Magento\CatalogInventory\Observer\ReindexQuoteInventoryObserver $reindexQuoteInventoryObserver
    ) {
        $this->subtractQuoteInventoryObserver = $subtractQuoteInventoryObserver;
        $this->reindexQuoteInventoryObserver = $reindexQuoteInventoryObserver;
    }

    /**
     * Subtract qtys of quote item products after multishipping checkout
     *
     * @param EventObserver $observer
     * @return $this
     */
    public function execute(EventObserver $observer)
    {
        $quote = $observer->getEvent()->getQuote();
        if (!$quote->getInventoryProcessed()) {
            $this->subtractQuoteInventoryObserver->execute($observer);
            $this->reindexQuoteInventoryObserver->execute($observer);
        }
        return $this;
    }
}
