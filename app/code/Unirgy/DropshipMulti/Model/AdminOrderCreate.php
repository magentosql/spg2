<?php

namespace Unirgy\DropshipMulti\Model;

use Magento\Framework\App\ObjectManager;

class AdminOrderCreate extends \Magento\Sales\Model\AdminOrder\Create
{
    public function updateQuoteItems($data)
    {
        $iHlp = ObjectManager::getInstance()->get('\Unirgy\Dropship\Helper\Item');
        if (is_array($data)) {
            $unsetIds = [];
            foreach ($data as $itemId => $info) {
                $item = $this->getQuote()->getItemById($itemId);
                $parentId = $item->getParentItemId();
                $skipUpdate = !empty($info['configured']) || !empty($info['action']);
                if ($parentId && !empty($data[$parentId])) {
                    $skipUpdate = $skipUpdate || !empty($data[$parentId]['configured']) || !empty($data[$parentId]['action']);
                }
                if ($item && !empty($info['udropship_vendor']) && !$skipUpdate
                    && $info['udropship_vendor']!=$item->getUdropshipVendor()
                ) {
                    $buyRequest = $iHlp->getItemOption($item, 'info_buyRequest');
                    if (!is_array($buyRequest)) {
                        $buyRequest = unserialize($buyRequest);
                    }
                    $buyRequest['udropship_vendor'] = $info['udropship_vendor'];
                    $iHlp->saveItemOption($item, 'info_buyRequest', $buyRequest, true);
                    $iHlp->deleteForcedVendorIdOption($item);
                    $iHlp->setUdropshipVendor($item, $info['udropship_vendor']);
                    $iHlp->setForcedVendorIdOption($item, $info['udropship_vendor']);
                    if ($item->getHasChildren()) {
                        $children = $item->getChildrenItems() ? $item->getChildrenItems() : $item->getChildren();
                        foreach ($children as $child) {
                            $iHlp->deleteForcedVendorIdOption($child);
                            $iHlp->setUdropshipVendor($child, $info['udropship_vendor']);
                            $iHlp->setForcedVendorIdOption($child, $info['udropship_vendor']);
                        }
                    }
                    $item->setSkipForcedVendorStockCheck(true);
                    $this->setRecollect(true);
                } elseif ($parentId && $skipUpdate) {
                    $unsetIds[$itemId] = $itemId;
                }
            }
            foreach ($unsetIds as $unsetId) {
                unset($data[$unsetId]);
            }
        }
        return parent::updateQuoteItems($data);
    }
    public function saveQuote()
    {
        parent::saveQuote();
        try {
            $hlp = ObjectManager::getInstance()->get('\Unirgy\Dropship\Helper\ProtectedCode');
            $items = $this->getQuote()->getAllItems();
            //$hlp->setAllowReorginizeQuote(true);
            $hlp->startAddressPreparation($items);
            $hlp->applyDefaultVendorIds($items)->applyStockAvailability($items);
            //$hlp->setAllowReorginizeQuote(false);
        } catch (\Exception $e) {
            // all necessary actions should be already done by now, kill the exception
        }
        return parent::saveQuote();
    }
}
