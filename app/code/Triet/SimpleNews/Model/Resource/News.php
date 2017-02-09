<?php

namespace Triet\SimpleNews\Model\Resource;

use Magento\Framework\Model\ResourceModel\Db\AbstractDb;

class News extends AbstractDb
{
    /**
     * Define main table
     */
    protected function _construct()
    {
        $this->_init('spg_triet_simplenews', 'id');
    }
}