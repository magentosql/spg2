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
 * @package    Unirgy_DropshipMultiPrice
 * @copyright  Copyright (c) 2008-2009 Unirgy LLC (http://www.unirgy.com)
 * @license    http:///www.unirgy.com/LICENSE-M1.txt
 */

namespace Unirgy\DropshipMultiPrice\Observer;

use Unirgy\DropshipMultiPrice\Helper\Data as DropshipMultiPriceHelperData;
use Unirgy\Dropship\Helper\Data as HelperData;

abstract class AbstractObserver
{
    /**
     * @var HelperData
     */
    protected $_hlp;

    /**
     * @var DropshipMultiPriceHelperData
     */
    protected $_mpHlp;

    public function __construct(
        HelperData $helperData,
        DropshipMultiPriceHelperData $dropshipMultiPriceHelperData)
    {
        $this->_hlp = $helperData;
        $this->_mpHlp = $dropshipMultiPriceHelperData;

    }

    protected function _catalog_product_type_prepare_cart_options($observer)
    {
        if (!$this->_hlp->isUdmultiActive()) return;
        $buyRequest = $observer->getBuyRequest();
        $product = $observer->getProduct();
        $this->_mpHlp->addBRVendorOption($product, $buyRequest);
    }


    protected $_useProductBestVendorPriceAsDefault=true;
    public function turnOffUseProductBestVendorPriceAsDefault($observer)
    {
        $this->_useProductBestVendorPriceAsDefault=false;
    }
    public function turnOnUseProductBestVendorPriceAsDefault($observer)
    {
        $this->_useProductBestVendorPriceAsDefault=true;
    }




    protected function _initConfigRewrites()
    {
        return;
        if (!$this->_helperData->isUdmultiActive()) return;
        if ($this->_helperData->isEE()
            && $this->_helperData->compareMageVer('1.8.0.0', '1.13.0.0')
        ) {
            Mage::getConfig()->setNode('global/models/catalog_resource/rewrite/product_indexer_price_defaultprice', 'Unirgy\DropshipMultiPrice\Model\PriceIndexer\CE1700\DefaultCE1700');
            Mage::getConfig()->setNode('global/models/catalog_resource/rewrite/product_indexer_price_grouped', 'Unirgy\DropshipMultiPrice\Model\PriceIndexer\CE1700\Grouped');
            Mage::getConfig()->setNode('global/models/catalog_resource/rewrite/product_indexer_price_configurable', 'Unirgy\DropshipMultiPrice\Model\PriceIndexer\CE1700\Configurable');
            Mage::getConfig()->setNode('global/models/downloadable_resource/rewrite/indexer_price', 'Unirgy\DropshipMultiPrice\Model\PriceIndexer\CE1700\Downloadable');
            Mage::getConfig()->setNode('global/models/bundle_resource/rewrite/indexer_price', 'Unirgy\DropshipMultiPrice\Model\PriceIndexer\CE1700\Bundle');
            Mage::getConfig()->setNode('global/models/enterprise_giftcard_resource/rewrite/indexer_price', 'Unirgy\DropshipMultiPrice\Model\PriceIndexer\EE11300\GiftCard');

        } elseif (
            $this->_helperData->compareMageVer('1.7.0.0', '1.12.0.0')
        ) {
            Mage::getConfig()->setNode('global/models/catalog_resource/rewrite/product_indexer_price_defaultprice', 'Unirgy\DropshipMultiPrice\Model\PriceIndexer\CE1700\DefaultCE1700');
            Mage::getConfig()->setNode('global/models/catalog_resource/rewrite/product_indexer_price_grouped', 'Unirgy\DropshipMultiPrice\Model\PriceIndexer\CE1700\Grouped');
            Mage::getConfig()->setNode('global/models/catalog_resource/rewrite/product_indexer_price_configurable', 'Unirgy\DropshipMultiPrice\Model\PriceIndexer\CE1700\Configurable');
            Mage::getConfig()->setNode('global/models/downloadable_resource/rewrite/indexer_price', 'Unirgy\DropshipMultiPrice\Model\PriceIndexer\CE1700\Downloadable');
            Mage::getConfig()->setNode('global/models/bundle_resource/rewrite/indexer_price', 'Unirgy\DropshipMultiPrice\Model\PriceIndexer\CE1700\Bundle');
        } elseif (
            $this->_helperData->compareMageVer('1.6.0.0', '1.11.0.0')
        ) {
            Mage::getConfig()->setNode('global/models/catalog_resource/rewrite/product_indexer_price_defaultprice', 'Unirgy\DropshipMultiPrice\Model\PriceIndexer\CE1600\DefaultCE1600');
            Mage::getConfig()->setNode('global/models/catalog_resource/rewrite/product_indexer_price_grouped', 'Unirgy\DropshipMultiPrice\Model\PriceIndexer\CE1600\Grouped');
            Mage::getConfig()->setNode('global/models/catalog_resource/rewrite/product_indexer_price_configurable', 'Unirgy\DropshipMultiPrice\Model\PriceIndexer\CE1600\Configurable');
            Mage::getConfig()->setNode('global/models/downloadable_resource/rewrite/indexer_price', 'Unirgy\DropshipMultiPrice\Model\PriceIndexer\CE1600\Downloadable');
            Mage::getConfig()->setNode('global/models/bundle_resource/rewrite/indexer_price', 'Unirgy\DropshipMultiPrice\Model\PriceIndexer\CE1600\Bundle');
        } elseif (
            $this->_helperData->compareMageVer('1.4.1.0', '1.8.0.0')
        ) {
            Mage::getConfig()->setNode('global/models/catalog_resource_eav_mysql4/rewrite/product_indexer_price_defaultprice', 'Unirgy\DropshipMultiPrice\Model\PriceIndexer\CE1410\DefaultCE1410');
            Mage::getConfig()->setNode('global/models/catalog_resource_eav_mysql4/rewrite/product_indexer_price_grouped', 'Unirgy\DropshipMultiPrice\Model\PriceIndexer\CE1410\Grouped');
            Mage::getConfig()->setNode('global/models/catalog_resource_eav_mysql4/rewrite/product_indexer_price_configurable', 'Unirgy\DropshipMultiPrice\Model\PriceIndexer\CE1410\Configurable');
            Mage::getConfig()->setNode('global/models/downloadable_mysql4/rewrite/indexer_price', 'Unirgy\DropshipMultiPrice\Model\PriceIndexer\CE1410\Downloadable');
            Mage::getConfig()->setNode('global/models/bundle_mysql4/rewrite/indexer_price', 'Unirgy\DropshipMultiPrice\Model\PriceIndexer\CE1410\Bundle');
        } elseif (
            $this->_helperData->compareMageVer('1.4.2.0', '1.9.0.0')
        ) {
            Mage::getConfig()->setNode('global/models/catalog_resource_eav_mysql4/rewrite/product_indexer_price_defaultprice', 'Unirgy\DropshipMultiPrice\Model\PriceIndexer\CE1420\DefaultCE1420');
            Mage::getConfig()->setNode('global/models/catalog_resource_eav_mysql4/rewrite/product_indexer_price_grouped', 'Unirgy\DropshipMultiPrice\Model\PriceIndexer\CE1420\Grouped');
            Mage::getConfig()->setNode('global/models/catalog_resource_eav_mysql4/rewrite/product_indexer_price_configurable', 'Unirgy\DropshipMultiPrice\Model\PriceIndexer\CE1420\Configurable');
            Mage::getConfig()->setNode('global/models/downloadable_mysql4/rewrite/indexer_price', 'Unirgy\DropshipMultiPrice\Model\PriceIndexer\CE1420\Downloadable');
            Mage::getConfig()->setNode('global/models/bundle_mysql4/rewrite/indexer_price', 'Unirgy\DropshipMultiPrice\Model\PriceIndexer\CE1420\Bundle');
        }
        if ($this->_dropshipMultiPriceHelperData->isConfigurableSimplePrice()) {
            Mage::getConfig()->setNode('global/models/catalog_resource/rewrite/product_indexer_price_configurable', 'Unirgy\DropshipMultiPrice\Model\PriceIndexer\OSPConfigurable');
        }
    }
}
