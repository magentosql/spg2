<?php

namespace Unirgy\DropshipSplit\Model;

use Magento\Quote\Model\QuoteIdMask;
use Magento\Quote\Model\QuoteIdMaskFactory;

class GuestShippingMethodManagement implements \Unirgy\DropshipSplit\Model\GuestShippingMethodManagementInterface,
    \Magento\Quote\Model\GuestCart\GuestShippingMethodManagementInterface
{
    /**
     * @var ShippingMethodManagementInterface
     */
    private $shippingMethodManagement;

    /**
     * @var QuoteIdMaskFactory
     */
    private $quoteIdMaskFactory;

    /**
     * Constructs a shipping method read service object.
     *
     * @param ShippingMethodManagementInterface $shippingMethodManagement
     * @param QuoteIdMaskFactory $quoteIdMaskFactory
     */
    public function __construct(
        ShippingMethodManagementInterface $shippingMethodManagement,
        QuoteIdMaskFactory $quoteIdMaskFactory
    ) {
        $this->shippingMethodManagement = $shippingMethodManagement;
        $this->quoteIdMaskFactory = $quoteIdMaskFactory;
    }

    /**
     * {@inheritDoc}
     */
    public function get($cartId)
    {
        /** @var $quoteIdMask QuoteIdMask */
        $quoteIdMask = $this->quoteIdMaskFactory->create()->load($cartId, 'masked_id');
        return $this->shippingMethodManagement->get($quoteIdMask->getQuoteId());
    }

    /**
     * {@inheritDoc}
     */
    public function getList($cartId)
    {
        /** @var $quoteIdMask QuoteIdMask */
        $quoteIdMask = $this->quoteIdMaskFactory->create()->load($cartId, 'masked_id');
        return $this->shippingMethodManagement->getList($quoteIdMask->getQuoteId());
    }

    /**
     * {@inheritDoc}
     */
    public function set($cartId, $carrierCode, $methodCode)
    {
        /** @var $quoteIdMask QuoteIdMask */
        $quoteIdMask = $this->quoteIdMaskFactory->create()->load($cartId, 'masked_id');
        return $this->shippingMethodManagement->set($quoteIdMask->getQuoteId(), $carrierCode, $methodCode);
    }

    /**
     * {@inheritDoc}
     */
    public function estimateByExtendedAddress($cartId, \Magento\Quote\Api\Data\AddressInterface $address)
    {
        /** @var $quoteIdMask QuoteIdMask */
        $quoteIdMask = $this->quoteIdMaskFactory->create()->load($cartId, 'masked_id');
        return $this->shippingMethodManagement->estimateByExtendedAddress($quoteIdMask->getQuoteId(), $address);
    }
}
