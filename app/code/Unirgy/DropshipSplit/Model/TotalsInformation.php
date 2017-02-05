<?php

namespace Unirgy\DropshipSplit\Model;

class TotalsInformation extends \Magento\Checkout\Model\TotalsInformation implements \Unirgy\DropshipSplit\Model\TotalsInformationInterface
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