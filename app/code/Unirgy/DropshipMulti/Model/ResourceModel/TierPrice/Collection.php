<?php

namespace Unirgy\DropshipMulti\Model\ResourceModel\TierPrice;

use Unirgy\DropshipMulti\Model\ResourceModel\GroupPrice\AbstractGroupPrice;

class Collection extends AbstractGroupPrice
{
    protected $_eventPrefix = 'udmulti_tier_price_collection';
    protected $_eventObject = 'tier_price_collection';

    protected function _construct()
    {
        $this->_init('Unirgy\DropshipMulti\Model\TierPrice', 'Unirgy\DropshipMulti\Model\ResourceModel\TierPrice');
    }
    protected function _beforeLoad()
    {
        $this->getSelect()->order('qty');
        parent::_beforeLoad();
        return $this;
    }

}