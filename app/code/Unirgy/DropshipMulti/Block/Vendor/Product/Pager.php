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
 * @package    Unirgy_Dropship
 * @copyright  Copyright (c) 2008-2009 Unirgy LLC (http://www.unirgy.com)
 * @license    http:///www.unirgy.com/LICENSE-M1.txt
 */

namespace Unirgy\DropshipMulti\Block\Vendor\Product;

class Pager extends \Unirgy\Dropship\Block\Vendor\Product\Pager
{
    protected $_availableLimit  = [10=>10,20=>20,50=>50,100=>100];
    protected $_dispersion      = 3;
    protected $_displayPages    = 10;
    protected $_showPerPage     = true;
}