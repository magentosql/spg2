<?php

namespace Unirgy\Rma\Model\ResourceModel;

class Rma extends \Magento\Sales\Model\ResourceModel\EntityAbstract
{
    protected $_eventPrefix = 'urma_rma_resource';
    protected $_grid = true;
    protected $_useIncrementId = true;

    protected function _construct()
    {
        $this->_init('urma_rma', 'entity_id');
    }
}
