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

namespace Unirgy\Rma\Model\ResourceModel\Rma;

class GridCollection extends \Unirgy\Rma\Model\ResourceModel\Rma\Collection
{
    protected $_eventPrefix = 'urma_rma_grid_collection';
    protected $_eventObject = 'rma_grid_collection';

    protected function _construct()
    {
        parent::_construct();
        $this->setMainTable('urma_rma_grid');
    }


}
