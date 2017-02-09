<?php

namespace Triet\SimpleNews\Model\Resource\News;

use Magento\Framework\Model\ResourceModel\Db\Collection\AbstractCollection;

class Collection extends AbstractCollection
{
    /**
     * Define model & resource model
     */
    protected function _construct()
    {
        $this->_init(
            'Triet\SimpleNews\Model\News',
            'Triet\SimpleNews\Model\Resource\News'
        );
    }
}