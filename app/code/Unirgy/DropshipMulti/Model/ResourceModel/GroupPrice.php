<?php

namespace Unirgy\DropshipMulti\Model\ResourceModel;

use Magento\Framework\Model\ResourceModel\Db\AbstractDb;

class GroupPrice extends AbstractDb
{
    protected $_eventPrefix = 'udmulti_group_price_resource';

    protected function _construct()
    {
        $this->_init('udmulti_group_price', 'value_id');
    }

}
