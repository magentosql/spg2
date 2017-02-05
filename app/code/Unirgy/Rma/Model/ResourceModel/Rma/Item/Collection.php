<?php

namespace Unirgy\Rma\Model\ResourceModel\Rma\Item;

use Magento\Sales\Model\ResourceModel\Collection\AbstractCollection;

class Collection extends AbstractCollection
{
    protected $_eventPrefix = 'urma_rma_item_collection';
    protected $_eventObject = 'rma_item_collection';

    protected function _construct()
    {
        $this->_init('Unirgy\Rma\Model\Rma\Item', 'Unirgy\Rma\Model\ResourceModel\Rma\Item');
    }

    public function setRmaFilter($rmaId)
    {
        $this->addFieldToFilter('parent_id', $rmaId);
        return $this;
    }
}
