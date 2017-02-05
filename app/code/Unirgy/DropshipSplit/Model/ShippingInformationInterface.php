<?php

namespace Unirgy\DropshipSplit\Model;

interface ShippingInformationInterface extends \Magento\Checkout\Api\Data\ShippingInformationInterface
{
    const SHIPPING_METHOD_ALL = 'shipping_method_all';
    /**
     *
     * @return \Unirgy\DropshipSplit\Model\ShippingMethodInterface[]
     */
    public function getShippingMethodAll();

    /**
     *
     * @param \Unirgy\DropshipSplit\Model\ShippingMethodInterface[] $methods
     * @return $this
     */
    public function setShippingMethodAll($methods);
}