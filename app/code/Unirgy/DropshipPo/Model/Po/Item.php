<?php
/**
 * Unirgy LLC
 *
 * NOTICE OF LICENSE
 *
 * This source file is subject to the EULA
 * that is bundled with this package in the file LICENSE.txt.
 * It is also available through the world-wide-web at this URL:
 * http://www.unirgy.com/LICENSE-M1.txt
 *
 * @category   Unirgy
 * @package    Unirgy_DropshipPo
 * @copyright  Copyright (c) 2008-2009 Unirgy LLC (http://www.unirgy.com)
 * @license    http:///www.unirgy.com/LICENSE-M1.txt
 */

namespace Unirgy\DropshipPo\Model\Po;

use Magento\Framework\Data\Collection\AbstractDb;
use Magento\Framework\Model\AbstractModel;
use Magento\Framework\Model\Context;
use Magento\Framework\Model\ResourceModel\AbstractResource;
use Magento\Framework\Registry;
use Magento\Sales\Model\Order\Item as OrderItem;
use Unirgy\DropshipPo\Helper\Data as DropshipPoHelperData;
use Unirgy\DropshipPo\Model\Po;
use Unirgy\Dropship\Helper\Data as HelperData;

class Item extends AbstractModel
{
    /**
     * @var HelperData
     */
    protected $_hlp;

    /**
     * @var \Magento\Sales\Model\Order\ItemFactory
     */
    protected $_orderItemFactory;

    /**
     * @var DropshipPoHelperData
     */
    protected $_poHlp;

    public function __construct(Context $context, 
        Registry $registry, 
        HelperData $helperData,
        \Magento\Sales\Model\Order\ItemFactory $orderItemFactory,
        DropshipPoHelperData $dropshipPoHelperData,
        AbstractResource $resource = null, 
        AbstractDb $resourceCollection = null, 
        array $data = [])
    {
        $this->_hlp = $helperData;
        $this->_orderItemFactory = $orderItemFactory;
        $this->_poHlp = $dropshipPoHelperData;

        parent::__construct($context, $registry, $resource, $resourceCollection, $data);
    }

    protected $_eventPrefix = 'udpo_po_item';
    protected $_eventObject = 'po_item';

    protected $_po = null;
    protected $_orderItem = null;
    protected $_stockPoItem = null;

    function _construct()
    {
        $this->_init('Unirgy\DropshipPo\Model\ResourceModel\Po\Item');
    }

    public function setPo(Po $po)
    {
        $this->_po = $po;
        return $this;
    }

    public function getPo()
    {
        return $this->_po;
    }

    public function setOrderItem(OrderItem $item)
    {
        $this->_orderItem = $item;
        $this->setOrderItemId($item->getId());
        return $this;
    }

    public function setStockPoItem(\Unirgy\DropshipStockPo\Model\Po\Item $item)
    {
        $this->_stockPoItem = $item;
        $this->setUstockpoItemId($item->getId());
        return $this;
    }

    public function getOrderItem()
    {
        if (is_null($this->_orderItem)) {
            if ($this->getPo()
            	&& ($orderItem = $this->_hlp->getOrderItemById($this->getPo()->getOrder(), $this->getOrderItemId()))
            ) {
                $this->_orderItem = $orderItem;
            }
            else {
                $this->_orderItem = $this->_orderItemFactory->create()
                    ->load($this->getOrderItemId());
            }
        }
        return $this->_orderItem;
    }

    public function getStockPoItem()
    {
        if (is_null($this->_stockPoItem)) {
            if ($this->getPo()
                && ($stockPo = $this->getPo()->getStockPo())
            	&& ($stockPoItem = $stockPo->getItemById($this->getUstockpoItemId()))
            ) {
                $this->_stockPoItem = $stockPoItem;
            }
            else {
                $this->_stockPoItem = $this->_hlp->createObj('Unirgy\DropshipStockPo\Model\Po\Item')
                    ->load($this->getUstockpoItemId());
            }
            $this->_stockPoItem->setUdpoItem($this);
        }
        return $this->_stockPoItem;
    }
    
    public function getQtyToShip()
    {
        if ($this->getOrderItem()->isDummy(true)) {
            return 0;
        }
        return max(0, min($this->getOrderItem()->getQtyToShip(), $this->getQty()-$this->getQtyShipped()-$this->getQtyCanceled()));
    }
    
    public function getQtyToInvoice()
    {
        if ($this->getOrderItem()->isDummy()) {
            return 0;
        }
        return max(0, min($this->getOrderItem()->getQtyToInvoice(), $this->getQty()-$this->getQtyInvoiced()-$this->getQtyCanceled()));
    }
    
    public function getQtyToCancel()
    {
        //return min($this->getQtyToShip(), $this->getQtyToInvoice());
        return $this->getQtyToShip();
    }

    public function setQty($qty)
    {
        if ($this->getOrderItem()->getIsQtyDecimal()) {
            $qty = (float) $qty;
        }
        else {
            $qty = (int) $qty;
        }
        $qty = $qty > 0 ? $qty : 0;
        /**
         * Check qty availability
         */
        if ($qty <= $this->_poHlp->getOrderItemQtyToUdpo($this->getOrderItem()) || $this->getOrderItem()->isDummy(true)) {
            $this->setData('qty', $qty);
        }
        else {
            throw new \Exception(
                __('Invalid qty to create purchase order for item "%1"', $this->getName())
            );
        }
        return $this;
    }

    public function register()
    {
        $this->getOrderItem()->setQtyUdpo(
            $this->getOrderItem()->getQtyUdpo()+$this->getQty()
        );
        return $this;
    }
    
    public function cancel()
    {
        $this->getOrderItem()->setQtyUdpo(
            $this->getOrderItem()->getQtyUdpo()-$this->getQtyToCancel()
        );
        $this->getPo()->setCurrentlyCanceledQty($this->getPo()->getCurrentlyCanceledQty()+$this->getQtyToCancel());
        $this->setCurrentlyCanceledQty($this->getQtyToCancel());
        $this->setQtyCanceled($this->getQtyCanceled() + $this->getQtyToCancel());
        return $this;
    }

    public function getUdropshipVendor()
    {
        return $this->getPo()->getUdropshipVendor();
    }

    public function beforeSave()
    {
        parent::beforeSave();

        if (!$this->getParentId() && $this->getPo()) {
            $this->setParentId($this->getPo()->getId());
        }

        return $this;
    }

}
