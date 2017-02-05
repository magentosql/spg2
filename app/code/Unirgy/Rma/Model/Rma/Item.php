<?php

namespace Unirgy\Rma\Model\Rma;

use Magento\Framework\Data\Collection\AbstractDb;
use Magento\Framework\Model\AbstractModel;
use Magento\Framework\Model\Context;
use Magento\Framework\Model\ResourceModel\AbstractResource;
use Magento\Framework\Registry;
use Magento\Sales\Model\Order\Item as OrderItem;
use Unirgy\Dropship\Helper\Data as HelperData;
use Unirgy\Rma\Helper\Data as RmaHelperData;
use Unirgy\Rma\Model\Rma;

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
     * @var RmaHelperData
     */
    protected $_rmaHlp;

    public function __construct(Context $context, 
        Registry $registry, 
        HelperData $helperData,
        \Magento\Sales\Model\Order\ItemFactory $orderItemFactory,
        RmaHelperData $rmaHelperData, 
        AbstractResource $resource = null, 
        AbstractDb $resourceCollection = null, 
        array $data = [])
    {
        $this->_hlp = $helperData;
        $this->_orderItemFactory = $orderItemFactory;
        $this->_rmaHlp = $rmaHelperData;

        parent::__construct($context, $registry, $resource, $resourceCollection, $data);
    }

    protected $_eventPrefix = 'urma_rma_item';
    protected $_eventObject = 'rma_item';

    protected $_rma = null;
    protected $_orderItem = null;

    function _construct()
    {
        $this->_init('Unirgy\Rma\Model\ResourceModel\Rma\Item');
    }

    public function setRma(Rma $rma)
    {
        $this->_rma = $rma;
        return $this;
    }

    public function getRma()
    {
        return $this->_rma;
    }

    public function setOrderItem(OrderItem $item)
    {
        $this->_orderItem = $item;
        $this->setOrderItemId($item->getId());
        return $this;
    }

    public function getOrderItem()
    {
        if (is_null($this->_orderItem)) {
            if ($this->getRma()
            	&& ($orderItem = $this->_hlp->getOrderItemById($this->getRma()->getOrder(), $this->getOrderItemId()))
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
        if ($qty <= $this->getOrderItem()->getQtyOrdered() || $this->getOrderItem()->isDummy(true)) {
            $this->setData('qty', $qty);
        }
        else {
            throw new \Exception(
                __('Invalid qty to create rma for item "%1"', $this->getName())
            );
        }
        return $this;
    }

    public function getItemConditionName()
    {
        return $this->_rmaHlp->getItemConditionTitle($this->getItemCondition());
    }

    public function register()
    {
        return $this;
    }
    
    public function beforeSave()
    {
        parent::beforeSave();

        if (!$this->getParentId() && $this->getRma()) {
            $this->setParentId($this->getRma()->getId());
        }

        return $this;
    }

}
