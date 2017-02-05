<?php

namespace Unirgy\DropshipMulti\Model\ResourceModel;

use Magento\Framework\Model\ResourceModel\Db\AbstractDb;

class TierPrice extends AbstractDb
{
    protected $_eventPrefix = 'udmulti_tier_price_resource';

    protected function _construct()
    {
        $this->_init('udmulti_tier_price', 'value_id');
    }

}
