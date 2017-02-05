<?php

namespace Unirgy\DropshipMulti\Observer;

use Magento\Catalog\Model\Product;
use Unirgy\DropshipMulti\Helper\Data as HelperData;
use Unirgy\Dropship\Helper\Data as DropshipHelperData;
use Unirgy\Dropship\Model\Source;

abstract class AbstractObserver
{
    /**
     * @var HelperData
     */
    protected $_multiHlp;

    /**
     * @var DropshipHelperData
     */
    protected $_hlp;

    public function __construct(
        HelperData $multiHelper,
        DropshipHelperData $udropshipHelper
    )
    {
        $this->_multiHlp = $multiHelper;
        $this->_hlp = $udropshipHelper;

    }

    public function isQty($item)
    {
        return $this->_multiHlp->isQty($item);
    }

    public function attachMultivendorData($products, $isActive, $reload=false)
    {
        $this->_multiHlp->attachMultivendorData($products, $isActive, $reload);
        return $this;
    }

    protected function _catalog_product_load_after($observer, $isActive)
    {
        if (!$this->_multiHlp->isActive()) {
            return;
        }
        $product = $observer->getEvent()->getProduct();
        if ($product instanceof Product
            && !$product->getData('__skip_udmulti_load')
            && !$this->_multiHlp->isSkipProductObject($product)
        ) {
            $this->attachMultivendorData([$product], $isActive);
        }
    }
    
    protected function _catalog_product_collection_load_after($observer, $isActive)
    {
        if (!$this->_multiHlp->isActive()) {
            return;
        }
        $pCollection = $observer->getEvent()->getCollection();
        if ($pCollection->getFlag('skip_udmulti_load') || !$this->_multiHlp->isUdmultiLoadToCollection) return;
        $this->attachMultivendorData($pCollection, $isActive);
    }

    protected function _sales_quote_item_collection_products_after_load($observer, $isActive)
    {
        if (!$this->_multiHlp->isActive()) {
            return;
        }
        $pCollection = $observer->getEvent()->getCollection();
        $this->attachMultivendorData($pCollection, $isActive);
    }










    public function processShipmentStatusChange($shipment, $oldStatus, $newStatus)
    {
    }


    protected function _initConfigRewrites()
    {
        return;
        if (!$this->_hlp->isUdmultiActive()) return;
        Mage::getConfig()->setNode('global/models/cataloginventory_mysql4/rewrite/stock', 'Unirgy\DropshipMulti\Model\ResourceModel\Stock');
        Mage::getConfig()->setNode('global/models/cataloginventory/rewrite/observer', 'Unirgy\DropshipMulti\Model\InventoryObserver');
        if ($this->_hlp->isEE()) {
        Mage::getConfig()->setNode('global/models/enterprise_cataloginventory/rewrite/index_observer', 'Unirgy\DropshipMulti\Model\EeInventoryObserver');
        }
        //Mage::getConfig()->setNode('global/models/cataloginventory/rewrite/source_backorders', 'Unirgy\DropshipMulti\Model\SourceBackorders');
        Mage::getConfig()->setNode('global/models/adminhtml/rewrite/sales_order_create', 'Unirgy\DropshipMulti\Model\AdminOrderCreate');
        if ($this->_hlp->isEE()
            && $this->_hlp->compareMageVer('1.8.0.0', '1.13.0.0')
        ) {
            Mage::getConfig()->setNode('global/models/enterprise_cataloginventory_resource/rewrite/indexer_stock_default', 'Unirgy\DropshipMulti\Model\StockIndexer\EE11300\DefaultEE11300');
            Mage::getConfig()->setNode('global/models/enterprise_bundle_resource/rewrite/indexer_stock', 'Unirgy\DropshipMulti\Model\StockIndexer\EE11300\Bundle');
            Mage::getConfig()->setNode('global/models/cataloginventory_resource/rewrite/indexer_stock_configurable', 'Unirgy\DropshipMulti\Model\StockIndexer\EE11300\Configurable');
            Mage::getConfig()->setNode('global/models/cataloginventory_resource/rewrite/indexer_stock_grouped', 'Unirgy\DropshipMulti\Model\StockIndexer\EE11300\Grouped');

        } elseif (
            $this->_hlp->compareMageVer('1.6.0.0', '1.11.0.0')
        ) {
            Mage::getConfig()->setNode('global/models/cataloginventory_resource/rewrite/indexer_stock_default', 'Unirgy\DropshipMulti\Model\StockIndexer\CE1620\DefaultCE1620');
            Mage::getConfig()->setNode('global/models/cataloginventory_resource/rewrite/indexer_stock_grouped', 'Unirgy\DropshipMulti\Model\StockIndexer\CE1620\Grouped');
            Mage::getConfig()->setNode('global/models/cataloginventory_resource/rewrite/indexer_stock_configurable', 'Unirgy\DropshipMulti\Model\StockIndexer\CE1620\Configurable');
            Mage::getConfig()->setNode('global/models/bundle_resource/rewrite/indexer_stock', 'Unirgy\DropshipMulti\Model\StockIndexer\CE1620\Bundle');
        } elseif (
            $this->_hlp->compareMageVer('1.4.1.0', '1.8.0.0')
        ) {
            Mage::getConfig()->setNode('global/models/cataloginventory_mysql4/rewrite/indexer_stock_default', 'Unirgy\DropshipMulti\Model\StockIndexer\CE1410\DefaultCE1410');
            Mage::getConfig()->setNode('global/models/cataloginventory_mysql4/rewrite/indexer_stock_grouped', 'Unirgy\DropshipMulti\Model\StockIndexer\CE1410\Grouped');
            Mage::getConfig()->setNode('global/models/cataloginventory_mysql4/rewrite/indexer_stock_price_configurable', 'Unirgy\DropshipMulti\Model\StockIndexer\CE1410\Configurable');
            Mage::getConfig()->setNode('global/models/bundle_mysql4/rewrite/indexer_stock', 'Unirgy\DropshipMulti\Model\StockIndexer\CE1410\Bundle');
        }
    }
}
