<?php

namespace Unirgy\DropshipMulti\Model;

use Magento\Framework\Model\AbstractModel;

class GroupPrice extends AbstractModel
{
    protected $_eventPrefix = 'udmulti_group_price';
    protected $_eventObject = 'group_price';

    protected function _construct()
    {
        $this->_init('Unirgy\DropshipMulti\Model\ResourceModel\Groupprice');
    }
}