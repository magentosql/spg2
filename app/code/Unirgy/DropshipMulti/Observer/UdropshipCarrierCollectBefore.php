<?php

namespace Unirgy\DropshipMulti\Observer;

use Magento\Catalog\Model\Product\Type;
use Magento\Framework\Event\Observer;
use Magento\Framework\Event\ObserverInterface;
use Unirgy\DropshipMulti\Helper\Data as HelperData;
use Unirgy\Dropship\Helper\Data as DropshipHelperData;

class UdropshipCarrierCollectBefore extends AbstractObserver implements ObserverInterface
{

    public function __construct(HelperData $helperData, 
        DropshipHelperData $dropshipHelperData)
    {


        parent::__construct($helperData, $dropshipHelperData);
    }

    public function execute(Observer $observer)
    {
        if (!$this->_multiHlp->isActive()) {
            return;
        }
        $request = $observer->getRequest();
        $hasItem = false;
        $allFree = true;
        foreach ($request->getAllItems() as $item) {
            $hasItem = true;
            $p = $item->getProduct();
            $vcKey = sprintf('multi_vendor_data/%s/freeshipping', $item->getUdropshipVendor());
            if (($vc = $p->getData($vcKey))) {
                $item->setFreeShipping($vc);
                if (($parent = $item->getParentItem()) && $parent->getProductType() == \Magento\ConfigurableProduct\Model\Product\Type\Configurable::TYPE_CODE) {
                    $pProd = $parent->getProduct();
                    if (($vc = $pProd->getData($vcKey))) {
                        $item->setFreeShipping($vc);
                    }
                }
            }
            if (!$item->getFreeShipping()) {
                $allFree = false;
            }
        }
        if ($allFree && $hasItem) {
            $observer->getAddress()->setFreeShipping(true);
        }
    }
}
