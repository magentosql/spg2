<?php

namespace Unirgy\Rma\Model\ResourceModel\Rma;

class Track extends \Magento\Sales\Model\ResourceModel\EntityAbstract
{
    protected $_eventPrefix = 'urma_rma_track_resource';

    protected function _construct()
    {
        $this->_init('urma_rma_track', 'entity_id');
    }
}
