<?php

namespace Unirgy\DropshipMulti\Model\ResourceModel\GroupPrice;



class Collection extends AbstractGroupPrice
{
    protected $_eventPrefix = 'udmulti_group_price_collection';
    protected $_eventObject = 'group_price_collection';

    protected function _construct()
    {
        $this->_init('Unirgy\DropshipMulti\Model\Groupprice', 'Unirgy\DropshipMulti\Model\ResourceModel\Groupprice');
    }
}