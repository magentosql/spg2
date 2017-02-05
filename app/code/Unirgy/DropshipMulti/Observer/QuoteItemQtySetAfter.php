<?php

namespace Unirgy\DropshipMulti\Observer;

use Magento\Framework\Event\ObserverInterface;
use Magento\Framework\Event\Observer as EventObserver;

class QuoteItemQtySetAfter extends \Magento\CatalogInventory\Observer\QuantityValidatorObserver
{
    protected $_multiHlp;
    protected $_hlp;
    public function __construct(
        \Unirgy\DropshipMulti\Helper\Data $multiHelper,
        \Unirgy\Dropship\Helper\Data $udropshipHelper,
        \Magento\CatalogInventory\Model\Quote\Item\QuantityValidator $quantityValidator
    ) {
        $this->_multiHlp = $multiHelper;
        $this->_hlp = $udropshipHelper;
        parent::__construct($quantityValidator);
    }

    /**
     * @param \Magento\Framework\Event\Observer $observer
     * @return void
     */
    public function execute(\Magento\Framework\Event\Observer $observer)
    {
        if (!$this->_multiHlp->isActive()) {
            parent::execute($observer);
        }
    }
}