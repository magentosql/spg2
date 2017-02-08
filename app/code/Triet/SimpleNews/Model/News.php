<?php

namespace Triet\SimpleNews\Model;

use Magento\Framework\Model\AbstractModel;

class News extends AbstractModel
{
    /**
     * Define resource model
     */
    protected function _construct()
    {
        $this->_init('Triet\SimpleNews\Model\Resource\News');
    }
}