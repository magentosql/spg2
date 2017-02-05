<?php

namespace Unirgy\DropshipSplit\Model;

class ShippingInformation extends \Magento\Checkout\Model\ShippingInformation implements \Unirgy\DropshipSplit\Model\ShippingInformationInterface
{
    /**
     *
     * @return \Unirgy\DropshipSplit\Model\ShippingMethodInterface[]
     */
    public function getShippingMethodAll()
    {
        return $this->getData(self::SHIPPING_METHOD_ALL);
    }

    /**
     *
     * @param \Unirgy\DropshipSplit\Model\ShippingMethodInterface[] $methods
     * @return $this
     */
    public function setShippingMethodAll($methods)
    {
        return $this->setData(self::SHIPPING_METHOD_ALL, $methods);
    }
}