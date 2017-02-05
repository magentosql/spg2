<?php

namespace Unirgy\Rma\Model\ResourceModel\Rma\Track;

use Magento\Sales\Model\ResourceModel\Collection\AbstractCollection;

class Collection extends AbstractCollection
{
    protected $_eventPrefix = 'urma_rma_track_collection';
    protected $_eventObject = 'rma_track_collection';
    
    protected function _construct()
    {
        $this->_init('Unirgy\Rma\Model\Rma\Track', 'Unirgy\Rma\Model\ResourceModel\Rma\Track');
    }

    public function setRmaFilter($rmaId)
    {
        $this->addFieldToFilter('parent_id', $rmaId);
        return $this;
    }

}
