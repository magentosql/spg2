<?php

namespace Unirgy\Rma\Model\ResourceModel\Rma;

class Comment extends \Magento\Sales\Model\ResourceModel\EntityAbstract
{
    protected $_eventPrefix = 'urma_rma_comment_resource';

    protected function _construct()
    {
        $this->_init('urma_rma_comment', 'entity_id');
    }
}
