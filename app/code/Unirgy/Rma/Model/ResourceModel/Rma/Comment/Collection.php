<?php

namespace Unirgy\Rma\Model\ResourceModel\Rma\Comment;

use Magento\Sales\Model\ResourceModel\Order\Comment\Collection\AbstractCollection;

class Collection extends AbstractCollection
{
    protected $_eventPrefix = 'urma_rma_comment_collection';
    protected $_eventObject = 'rma_comment_collection';

    protected function _construct()
    {
        $this->_init('Unirgy\Rma\Model\Rma\Comment', 'Unirgy\Rma\Model\ResourceModel\Rma\Comment');
    }

    public function setRmaFilter($rmaId)
    {
        return $this->setParentFilter($rmaId);
    }

    public function setCreatedAtOrder($direction='desc')
    {
        $this->setOrder('created_at', $direction);
        $this->setOrder('entity_id', $direction);
        return $this;
    }
}
