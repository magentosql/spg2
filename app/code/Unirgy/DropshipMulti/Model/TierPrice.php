<?php

namespace Unirgy\DropshipMulti\Model;

use Magento\Framework\Model\AbstractModel;

class TierPrice extends AbstractModel
{
    protected $_eventPrefix = 'udmulti_tier_price';
    protected $_eventObject = 'tier_price';

    protected function _construct()
    {
        $this->_init('Unirgy\DropshipMulti\Model\ResourceModel\TierPrice');
    }
}
