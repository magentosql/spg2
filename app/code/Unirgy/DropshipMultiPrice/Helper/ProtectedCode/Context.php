<?php

namespace Unirgy\DropshipMultiPrice\Helper\ProtectedCode;

use Unirgy\DropshipMultiPrice\Helper\Data as HelperData;
use Unirgy\Dropship\Helper\Item;
use Unirgy\Dropship\Helper\ProtectedCode as HelperProtectedCode;

class Context
{
    /**
     * @var Item
     */
    public $_helperItem;

    public function __construct(\Unirgy\Dropship\Helper\Item $helperItem)
    {
        $this->_helperItem = $helperItem;

    }
}