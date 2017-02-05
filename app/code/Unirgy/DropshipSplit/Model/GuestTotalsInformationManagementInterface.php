<?php

namespace Unirgy\DropshipSplit\Model;

interface GuestTotalsInformationManagementInterface
{
    /**
     * Calculate quote totals based on address and shipping method.
     *
     * @param string $cartId
     * @param \Unirgy\DropshipSplit\Model\TotalsInformationInterface $addressInformation
     * @return \Magento\Quote\Api\Data\TotalsInterface
     */
    public function calculate(
        $cartId,
        \Unirgy\DropshipSplit\Model\TotalsInformationInterface $addressInformation
    );
}