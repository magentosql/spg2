<?php

namespace Unirgy\DropshipSplit\Model;

interface GuestShippingInformationManagementInterface
{
    /**
     * @param string $cartId
     * @param \Unirgy\DropshipSplit\Model\ShippingInformationInterface $addressInformation
     * @return \Magento\Checkout\Api\Data\PaymentDetailsInterface
     */
    public function saveAddressInformation(
        $cartId,
        \Unirgy\DropshipSplit\Model\ShippingInformationInterface $addressInformation
    );
}
