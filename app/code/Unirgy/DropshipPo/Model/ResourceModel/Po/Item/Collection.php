<?php
/**
 * Unirgy LLC
 *
 * NOTICE OF LICENSE
 *
 * This source file is subject to the EULA
 * that is bundled with this package in the file LICENSE.txt.
 * It is also available through the world-wide-web at this URL:
 * http://www.unirgy.com/LICENSE-M1.txt
 *
 * @category   Unirgy
 * @package    Unirgy_DropshipPo
 * @copyright  Copyright (c) 2008-2009 Unirgy LLC (http://www.unirgy.com)
 * @license    http:///www.unirgy.com/LICENSE-M1.txt
 */

namespace Unirgy\DropshipPo\Model\ResourceModel\Po\Item;

use Magento\Sales\Model\ResourceModel\Collection\AbstractCollection;

class Collection extends AbstractCollection
{
    protected $_eventPrefix = 'udpo_po_item_collection';
    protected $_eventObject = 'po_item_collection';

    protected function _construct()
    {
        $this->_init('Unirgy\DropshipPo\Model\Po\Item', 'Unirgy\DropshipPo\Model\ResourceModel\Po\Item');
    }

    public function setPoFilter($poId)
    {
        $this->addFieldToFilter('parent_id', $poId);
        return $this;
    }
}
