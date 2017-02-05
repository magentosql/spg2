<?php

namespace Unirgy\Rma\Model;

use Magento\Framework\App\Config\ScopeConfigInterface;
use Magento\Sales\Model\Order as ModelOrder;
use Magento\Store\Model\ScopeInterface;
use Unirgy\Dropship\Helper\Data as DropshipHelperData;
use Unirgy\Rma\Helper\Data as HelperData;

class ServiceOrder
{
    /**
     * @var \Magento\Sales\Model\Convert\Order
     */
    protected $_convertor;

    /**
     * @var HelperData
     */
    protected $_rmaHlp;

    /**
     * @var ScopeConfigInterface
     */
    protected $_scopeConfig;

    /**
     * @var DropshipHelperData
     */
    protected $_hlp;

    public function __construct(
        ModelOrder $order,
        \Unirgy\Rma\Model\ConvertOrder $convertor,
        HelperData $helperData, 
        ScopeConfigInterface $configScopeConfigInterface, 
        DropshipHelperData $dropshipHelperData
    )
    {
        $this->_rmaHlp = $helperData;
        $this->_scopeConfig = $configScopeConfigInterface;
        $this->_hlp = $dropshipHelperData;

        $this->_order       = $order;
        $this->_convertor   = $convertor;
    }
    public function prepareRma($qtys = [])
    {
        $hlpr = $this->_rmaHlp;
        $totalQty = 0;
        $rma = $this->_convertor->toRma($this->_order);
        foreach ($this->_order->getAllItems() as $orderItem) {
            if (!$this->_canRmaItem($orderItem, $qtys)) {
                continue;
            }

            $item = $this->_convertor->itemToRmaItem($orderItem);
            if ($orderItem->isDummy(true)) {
                $qty = 1;
            } else {
                if (isset($qtys[$orderItem->getId()])) {
                    $qty = min($qtys[$orderItem->getId()], $hlpr->getOrderItemQtyToUrma($orderItem));
                } elseif (!count($qtys)) {
                    $qty = $hlpr->getOrderItemQtyToUrma($orderItem);
                } else {
                    continue;
                }
            }

            $totalQty += $qty;
            $item->setQty($qty);
            $rma->addItem($item);
        }
        $rma->setTotalQty($totalQty);
        return $rma;
    }
    public function prepareRmaForSave($qtys = [], $conditions=[])
    {
        $hlpr = $this->_rmaHlp;
        $totalQtys = [];
        $rmaItems = [];
        foreach ($this->_order->getAllItems() as $orderItem) {
            if (!$this->_canRmaItem($orderItem, $qtys)) {
                continue;
            }

            $item = $this->_convertor->itemToRmaItem($orderItem);
            if ($orderItem->isDummy(true)) {
                $qty = 1;
            } else {
                if (isset($qtys[$orderItem->getId()])) {
                    $qty = min($qtys[$orderItem->getId()], $hlpr->getOrderItemQtyToUrma($orderItem));
                } elseif (!count($qtys)) {
                    $qty = $hlpr->getOrderItemQtyToUrma($orderItem);
                } else {
                    continue;
                }
            }
            if ($qty<=0) continue;
            $vId = $orderItem->getUdropshipVendor();

            $rmaItems[$vId][] = $item;

            if (empty($totalQtys[$vId])) {
                $totalQtys[$vId] = 0;
            }
            $totalQtys[$vId] += $qty;

            $item->setQty($qty);
            $orderItem->setQtyUrma(
                $orderItem->getQtyUrma()+$item->getQty()
            );

            $item->setItemCondition(@$conditions[$orderItem->getId()]);

        }
        if (empty($rmaItems)) {
            throw new \Exception(
                $this->_scopeConfig->getValue('urma/message/customer_no_items', ScopeInterface::SCOPE_STORE)
            );
        }
        $rmas = [];
        foreach ($rmaItems as $vId=>$items) {
            if (empty($items)) continue;
            $shipment = null;
            foreach ($this->_order->getShipmentsCollection() as $_shipment) {
                if ($_shipment->getUdropshipVendor()==$vId) {
                    $shipment = $_shipment;
                    break;
                }
            }
            if (null == $shipment) continue;
            $rma = $this->_convertor->toRma($this->_order);
            $rma->setUdropshipVendor($vId);
            $rma->setUdropshipMethod($shipment->getUdropshipMethod());
            $rma->setUdropshipMethodDescription($shipment->getUdropshipMethodDescription());
            $rma->setTotalQty($totalQtys[$vId]);
            $rma->setShipmentId($shipment->getId());
            $rma->setShipmentIncrementId($shipment->getIncrementId());
            if ($this->_hlp->isUdpoActive() && ($po=$this->_hlp->udpoHlp()->getShipmentPo($shipment))) {
                $rma->setUdpoId($po->getId());
                $rma->setUdpoIncrementId($po->getIncrementId());
            }
            $rmas[$vId] = $rma;
            foreach ($items as $item) {
                $rma->addItem($item);
            }

        }
        foreach ($rmas as $rma) {
            //$this->_helperData->addVendorSkus($rma);
            $this->_hlp->addVendorSkus($rma);
        }
        return $rmas;
    }

    protected function _canRmaItem($item, $qtys=[])
    {
        $hlpr = $this->_rmaHlp;
        if ($item->isDummy(true)) {
            if ($item->getHasChildren()) {
                if ($item->isShipSeparately()) {
                    return true;
                }
                foreach ($item->getChildrenItems() as $child) {
                    if ($child->getIsVirtual()) {
                        continue;
                    }
                    if (empty($qtys)) {
                        if ($hlpr->getOrderItemQtyToUrma($child) > 0) {
                            return true;
                        }
                    } else {
                        if (isset($qtys[$child->getId()]) && $qtys[$child->getId()] > 0) {
                            return true;
                        }
                    }
                }
                return false;
            } else if($item->getParentItem()) {
                $parent = $item->getParentItem();
                if (empty($qtys)) {
                    return $hlpr->getOrderItemQtyToUrma($parent) > 0;
                } else {
                    return isset($qtys[$parent->getId()]) && $qtys[$parent->getId()] > 0;
                }
            }
        } else {
            return $hlpr->getOrderItemQtyToUrma($item)>0;
        }
    }
}