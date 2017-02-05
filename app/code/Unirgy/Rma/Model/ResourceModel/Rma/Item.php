<?php

namespace Unirgy\Rma\Model\ResourceModel\Rma;

class Item extends \Magento\Sales\Model\ResourceModel\EntityAbstract
{
    protected $_eventPrefix = 'urma_rma_item_resource';

    protected function _construct()
    {
        $this->_init('urma_rma_item', 'entity_id');
    }
}
