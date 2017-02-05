<?php

namespace Unirgy\DropshipSplit\Model;

interface TotalsInformationManagementInterface
{
    /**
     * Calculate quote totals based on address and shipping method.
     *
     * @param int $cartId
     * @param \Unirgy\DropshipSplit\Model\TotalsInformationInterface $addressInformation
     * @return \Magento\Quote\Api\Data\TotalsInterface
     */
    public function calculate(
        $cartId,
        \Unirgy\DropshipSplit\Model\TotalsInformationInterface $addressInformation
    );
}