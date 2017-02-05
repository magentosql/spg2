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
 * @package    Unirgy_DropshipSellYours
 * @copyright  Copyright (c) 2008-2009 Unirgy LLC (http://www.unirgy.com)
 * @license    http:///www.unirgy.com/LICENSE-M1.txt
 */

namespace Unirgy\DropshipSellYours\Helper\ProtectedCode;

use Magento\Catalog\Model\Product;
use Magento\Catalog\Model\ProductFactory;
use Unirgy\DropshipMulti\Helper\Data as HelperData;
use Unirgy\Dropship\Helper\Catalog;
use Unirgy\Dropship\Helper\Data as DropshipHelperData;
use Unirgy\Dropship\Helper\ProtectedCode as HelperProtectedCode;

class Context
{
    /**
     * @var ProductFactory
     */
    public $_productFactory;

    /**
     * @var HelperData
     */
    public $_multiHlp;

    /**
     * @var DropshipHelperData
     */
    public $_hlp;

    /**
     * @var Catalog
     */
    public $_helperCatalog;

    public function __construct(
        \Magento\Catalog\Model\ProductFactory $productFactory,
        \Unirgy\DropshipMulti\Helper\Data $udmultiHelper,
        \Unirgy\Dropship\Helper\Data $udropshipHelper,
        \Unirgy\Dropship\Helper\Catalog $helperCatalog)
    {
        $this->_productFactory = $productFactory;
        $this->_multiHlp = $udmultiHelper;
        $this->_hlp = $udropshipHelper;
        $this->_helperCatalog = $helperCatalog;

    }
}