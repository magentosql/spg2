<?php

namespace Unirgy\Rma\Block\Email\Rma;

use Magento\Framework\View\Element\AbstractBlock;
use Magento\Sales\Block\Items\AbstractItems;

class Items extends AbstractItems
{
    protected function _prepareItem(AbstractBlock $renderer)
    {
        $renderer->getItem()->setOrder($this->getOrder());
        $renderer->getItem()->setSource($this->getPo());
    }
}