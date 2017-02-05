<?php

namespace Unirgy\DropshipMulti\Model;

use Magento\CatalogInventory\Model\Source\Backorders;
use Unirgy\DropshipMulti\Helper\Data as HelperData;

class SourceBackorders extends Backorders
{
    /**
     * @var HelperData
     */
    protected $_helperData;

    public function __construct(HelperData $helperData)
    {
        $this->_helperData = $helperData;

    }

    public function toOptionArray()
    {
        $hlpm = $this->_helperData;
        $options = parent::toOptionArray();
        $options[] = [
            'value' => 10,
            'label' => __('Use Avail State/Date to Allow Qty Below 0')
        ];
        $options[] = [
            'value' => 11,
            'label' => __('Use Avail State/Date to Allow Qty Below 0 and Notify Customer')
        ];
        return $options;
    }
}