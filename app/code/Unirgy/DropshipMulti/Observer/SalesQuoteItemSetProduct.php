<?php

namespace Unirgy\DropshipMulti\Observer;

use Magento\Catalog\Model\Product\Type;
use Magento\Framework\Event\Observer;
use Magento\Framework\Event\ObserverInterface;
use Psr\Log\LoggerInterface;
use Unirgy\DropshipMulti\Helper\Data as HelperData;
use Unirgy\Dropship\Helper\Data as DropshipHelperData;

class SalesQuoteItemSetProduct extends AbstractObserver implements ObserverInterface
{
    /**
     * @var LoggerInterface
     */
    protected $_logLoggerInterface;

    public function __construct(HelperData $helperData, 
        DropshipHelperData $dropshipHelperData, 
        LoggerInterface $logLoggerInterface)
    {
        $this->_logLoggerInterface = $logLoggerInterface;

        parent::__construct($helperData, $dropshipHelperData);
    }

    public function execute(Observer $observer)
    {
        if (!$this->_multiHlp->isActive()) {
            return;
        }
#$this->_logLoggerInterface->debug(__METHOD__);
        $p = $observer->getEvent()->getProduct();
        $item = $observer->getEvent()->getQuoteItem();
        $vcKey = sprintf('multi_vendor_data/%s/vendor_cost', $item->getUdropshipVendor());
        if (($vc = $p->getData($vcKey)) && $vc>0) {
            $item->setBaseCost($vc);
            if (($parent = $item->getParentItem()) && $parent->getProductType() == \Magento\ConfigurableProduct\Model\Product\Type\Configurable::TYPE_CODE) {
                $parent->setBaseCost($vc);
            }
        }
    }
}
