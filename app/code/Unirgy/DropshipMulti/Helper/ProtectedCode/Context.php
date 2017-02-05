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

namespace Unirgy\DropshipMulti\Helper\ProtectedCode;

use Magento\CatalogInventory\Model\Stock;
use Magento\CatalogInventory\Model\Stock\ItemFactory;
use Magento\Catalog\Model\Product;
use Magento\Catalog\Model\ProductFactory;
use Magento\Customer\Model\Group;
use Magento\Eav\Model\Config;
use Magento\Framework\App\Config\ScopeConfigInterface;
use Magento\Framework\App\ObjectManager;
use Magento\Store\Model\ScopeInterface;
use Unirgy\DropshipMulti\Helper\Data as HelperData;
use Unirgy\Dropship\Helper\Data as DropshipHelperData;
use Unirgy\Dropship\Helper\ProtectedCode as HelperProtectedCode;

class Context
{
    /**
     * @var HelperData
     */
    public $_multiHlp;

    /**
     * @var DropshipHelperData
     */
    public $_hlp;

    /**
     * @var ItemFactory
     */
    public $_stockItemFactory;

    /**
     * @var ScopeConfigInterface
     */
    public $_scopeConfig;

    /**
     * @var ProductFactory
     */
    public $_modelProductFactory;

    /**
     * @var Config
     */
    public $_eavConfig;

    public $_stockRegistry;

    public function __construct(
        \Unirgy\DropshipMulti\Helper\Data $helperData,
        \Unirgy\Dropship\Helper\Data $dropshipHelperData,
        \Magento\CatalogInventory\Model\Stock\ItemFactory $stockItemFactory,
        \Magento\Framework\App\Config\ScopeConfigInterface $scopeConfig,
        \Magento\Catalog\Model\ProductFactory $modelProductFactory,
        \Magento\Eav\Model\Config $eavConfig,
        \Magento\CatalogInventory\Api\StockRegistryInterface $stockRegistry
    )
    {
        $this->_multiHlp = $helperData;
        $this->_hlp = $dropshipHelperData;
        $this->_stockItemFactory = $stockItemFactory;
        $this->_scopeConfig = $scopeConfig;
        $this->_modelProductFactory = $modelProductFactory;
        $this->_eavConfig = $eavConfig;
        $this->_stockRegistry = $stockRegistry;
    }
}