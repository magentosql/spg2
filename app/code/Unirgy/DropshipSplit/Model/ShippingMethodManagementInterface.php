<?php

namespace Unirgy\DropshipSplit\Model;

interface ShippingMethodManagementInterface extends \Magento\Quote\Api\ShippingMethodManagementInterface
{
    /**
     * Estimate shipping
     *
     * @param int $cartId The shopping cart ID.
     * @param \Magento\Quote\Api\Data\AddressInterface $address The estimate address
     * @return \Unirgy\DropshipSplit\Model\ShippingMethodInterface[] An array of shipping methods.
     */
    public function estimateByExtendedAddress($cartId, \Magento\Quote\Api\Data\AddressInterface $address);

    /**
     * Estimate shipping
     *
     * @param int $cartId The shopping cart ID.
     * @param int $addressId The estimate address id
     * @return \Unirgy\DropshipSplit\Model\ShippingMethodInterface[] An array of shipping methods.
     */
    public function estimateByAddressId($cartId, $addressId);
}