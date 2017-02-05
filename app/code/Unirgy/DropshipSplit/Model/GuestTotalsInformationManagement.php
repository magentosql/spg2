<?php

namespace Unirgy\DropshipSplit\Model;

class GuestTotalsInformationManagement implements \Unirgy\DropshipSplit\Model\GuestTotalsInformationManagementInterface
{
    /**
     * @var \Magento\Quote\Model\QuoteIdMaskFactory
     */
    protected $quoteIdMaskFactory;

    /**
     * @var \Unirgy\DropshipSplit\Model\TotalsInformationManagementInterface
     */
    protected $totalsInformationManagement;

    /**
     * @param \Magento\Quote\Model\QuoteIdMaskFactory $quoteIdMaskFactory
     * @param \Unirgy\DropshipSplit\Model\TotalsInformationManagementInterface $totalsInformationManagement
     * @codeCoverageIgnore
     */
    public function __construct(
        \Magento\Quote\Model\QuoteIdMaskFactory $quoteIdMaskFactory,
        \Unirgy\DropshipSplit\Model\TotalsInformationManagementInterface $totalsInformationManagement
    ) {
        $this->quoteIdMaskFactory = $quoteIdMaskFactory;
        $this->totalsInformationManagement = $totalsInformationManagement;
    }

    /**
     * {@inheritDoc}
     */
    public function calculate(
        $cartId,
        \Unirgy\DropshipSplit\Model\TotalsInformationInterface $addressInformation
    ) {
        /** @var $quoteIdMask \Magento\Quote\Model\QuoteIdMask */
        $quoteIdMask = $this->quoteIdMaskFactory->create()->load($cartId, 'masked_id');
        return $this->totalsInformationManagement->calculate(
            $quoteIdMask->getQuoteId(),
            $addressInformation
        );
    }
}