<?php

namespace Unirgy\Rma\Block\Order;

use Magento\Sales\Block\Order\Comments as OrderComments;
use Magento\Sales\Model\Order\Creditmemo;
use Magento\Sales\Model\Order\Invoice;
use Magento\Sales\Model\Order\Shipment;

class Comments extends OrderComments
{
    public function __construct(
        \Unirgy\Rma\Model\ResourceModel\Rma\Comment\CollectionFactory $urmaCollectionFactory,
        \Magento\Framework\View\Element\Template\Context $context,
        \Magento\Sales\Model\ResourceModel\Order\Invoice\Comment\CollectionFactory $invoiceCollectionFactory,
        \Magento\Sales\Model\ResourceModel\Order\Creditmemo\Comment\CollectionFactory $memoCollectionFactory,
        \Magento\Sales\Model\ResourceModel\Order\Shipment\Comment\CollectionFactory $shipmentCollectionFactory,
        array $data = []
    ) {
        $this->_urmaCollectionFactory = $urmaCollectionFactory;
        parent::__construct($context, $invoiceCollectionFactory, $memoCollectionFactory, $shipmentCollectionFactory, $data);
    }

    public function getComments()
    {
        if ($this->_commentCollection === null) {
            $entity = $this->getEntity();
            if ($entity instanceof \Magento\Sales\Model\Order\Invoice) {
                $this->_commentCollection = $this->_invoiceCollectionFactory->create();
            } elseif ($entity instanceof \Magento\Sales\Model\Order\Creditmemo) {
                $this->_commentCollection = $this->_memoCollectionFactory->create();
            } elseif ($entity instanceof \Magento\Sales\Model\Order\Shipment) {
                $this->_commentCollection = $this->_shipmentCollectionFactory->create();
            } elseif ($entity instanceof \Unirgy\Rma\Model\Rma) {
                $this->_commentCollection = $this->_urmaCollectionFactory->create();
            } else {
                throw new \Magento\Framework\Exception\LocalizedException(__('We found an invalid entity model.'));
            }

            $this->_commentCollection->setParentFilter($entity)->setCreatedAtOrder()->addVisibleOnFrontFilter();
        }

        return $this->_commentCollection;
    }
}