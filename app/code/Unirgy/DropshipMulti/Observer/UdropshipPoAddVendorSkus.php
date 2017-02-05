<?php

namespace Unirgy\DropshipMulti\Observer;

use Magento\Framework\Event\Observer;
use Magento\Framework\Event\ObserverInterface;
use Unirgy\DropshipMulti\Helper\Data as HelperData;
use Unirgy\DropshipMulti\Helper\ProtectedCode;
use Unirgy\Dropship\Helper\Data as DropshipHelperData;

class UdropshipPoAddVendorSkus extends AbstractObserver implements ObserverInterface
{
    /**
     * @var ProtectedCode
     */
    protected $_helperProtectedCode;

    public function __construct(HelperData $helperData, 
        DropshipHelperData $dropshipHelperData, 
        ProtectedCode $helperProtectedCode)
    {
        $this->_helperProtectedCode = $helperProtectedCode;

        parent::__construct($helperData, $dropshipHelperData);
    }

    public function execute(Observer $observer)
    {
        $po = $observer->getEvent()->getPo();
        $this->_helperProtectedCode->udropship_po_add_vendor_skus($po);
    }
}
