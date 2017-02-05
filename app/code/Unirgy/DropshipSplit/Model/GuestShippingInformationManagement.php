<?php

namespace Unirgy\DropshipSplit\Model;

class GuestShippingInformationManagement implements \Unirgy\DropshipSplit\Model\GuestShippingInformationManagementInterface
{
    /**
     * @var \Magento\Quote\Model\QuoteIdMaskFactory
     */
    protected $quoteIdMaskFactory;

    /**
     * @var \Unirgy\DropshipSplit\Model\ShippingInformationManagementInterface
     */
    protected $shippingInformationManagement;

    /**
     * @param \Magento\Quote\Model\QuoteIdMaskFactory $quoteIdMaskFactory
     * @param \Unirgy\DropshipSplit\Model\ShippingInformationManagementInterface $shippingInformationManagement
     * @codeCoverageIgnore
     */
    public function __construct(
        \Magento\Quote\Model\QuoteIdMaskFactory $quoteIdMaskFactory,
        \Unirgy\DropshipSplit\Model\ShippingInformationManagementInterface $shippingInformationManagement
    ) {
        $this->quoteIdMaskFactory = $quoteIdMaskFactory;
        $this->shippingInformationManagement = $shippingInformationManagement;
    }
    /**
     * @param string $cartId
     * @param \Unirgy\DropshipSplit\Model\ShippingInformationInterface $addressInformation
     * @return \Magento\Checkout\Api\Data\PaymentDetailsInterface
     */
    public function saveAddressInformation(
        $cartId,
        \Unirgy\DropshipSplit\Model\ShippingInformationInterface $addressInformation
    ) {
        /** @var $quoteIdMask \Magento\Quote\Model\QuoteIdMask */
        $quoteIdMask = $this->quoteIdMaskFactory->create()->load($cartId, 'masked_id');
        return $this->shippingInformationManagement->saveAddressInformation(
            $quoteIdMask->getQuoteId(),
            $addressInformation
        );
    }
}