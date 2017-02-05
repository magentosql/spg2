<?php

namespace Unirgy\DropshipMulti\Block\Vendor\Product;

use Magento\Catalog\Model\ProductFactory;
use Magento\Framework\App\ObjectManager;
use Magento\Framework\App\RequestInterface;
use Magento\Framework\View\Element\Template;
use Magento\Framework\View\Element\Template\Context;

class Grid extends Template
{
    /**
     * @var ProductFactory
     */
    protected $_productFactory;
    protected $_hlp;

    public function __construct(
        \Unirgy\Dropship\Helper\Data $udropshipHelper,
        Context $context,
        ProductFactory $modelProductFactory,
        array $data = [])
    {
        $this->_hlp = $udropshipHelper;
        $this->_productFactory = $modelProductFactory;
        parent::__construct($context, $data);
    }

    protected $_collection;

    protected function _prepareLayout()
    {
        parent::_prepareLayout();

        $oldStoreId = $this->_storeManager->getStore()->getId();
        $this->_oldStoreId = $this->_storeManager->getStore()->getId();
        $this->_storeManager->setCurrentStore(0);
        if ($toolbar = $this->getLayout()->getBlock('product.grid.toolbar')) {
            $toolbar->setCollection($this->getProductCollection());
            $this->setChild('toolbar', $toolbar);
        }

        $this->getProductCollection()->load();

        if ($this->_hlp->isModuleActive('Unirgy_DropshipSellYours')) {
            $findEditOfferIds = array();
            foreach ($this->getProductCollection() as $p) {
                if (!$p->isVisibleInSiteVisibility()) {
                    $findEditOfferIds[] = $p->getEntityId();
                    $p->setHasEditOfferId(1);
                }
            }
            if (!empty($findEditOfferIds)) {
                /** @var \Unirgy\Dropship\Model\ResourceModel\Helper $rHlp */
                $rHlp = $this->_hlp->getObj('\Unirgy\Dropship\Model\ResourceModel\Helper');
                $conn = $rHlp->getConnection();
                $findEditOffersSel = $conn->select()
                    ->from($rHlp->getTable('catalog_product_super_link'))
                    ->where('product_id in (?)', $findEditOfferIds);
                $findEditOffers = $conn->fetchAll(
                    $findEditOffersSel
                );
                if (is_array($findEditOffers)) {
                    foreach ($findEditOffers as $__feo) {
                        foreach ($this->getProductCollection() as $p) {
                            if ($__feo['product_id']==$p->getEntityId()) {
                                $p->setEditOfferId($__feo['parent_id']);
                                break;
                            }
                        }
                    }
                }
            }
        }


        foreach ($this->getProductCollection() as $p) {
            if (!$this->_hlp->isUdmultiAvailable()) {
                if (($vsAttrCode = $this->_scopeConfig->getValue('udropship/vendor/vendor_sku_attribute')) && $this->_hlp->checkProductAttribute($vsAttrCode)) {
                    $p->setVendorSku($p->getData($vsAttrCode));
                }
            }
        }

        $this->_storeManager->getStore()->setId($oldStoreId);
        $this->_storeManager->setCurrentStore($this->_oldStoreId);

        return $this;
    }

    protected $_oldStoreId;
    public function getProductCollection()
    {
        if (!$this->_collection) {
            $v = ObjectManager::getInstance()->get('Unirgy\Dropship\Model\Session')->getVendor();
            if (!$v || !$v->getId()) {
                return [];
            }
            $r = $this->_request;
            #$res = $this->_modelResource;
            #$read = $res->getConnection('catalog_product');
            $collection = $this->_hlp->createObj('\Unirgy\Dropship\Model\ResourceModel\ProductCollection')
                ->setFlag('udskip_price_index',1)
                ->setFlag('has_stock_status_filter', 1)
                ->addAttributeToSelect('name')
                ->joinTable('udropship_vendor_product', 'product_id=entity_id', ['vendor_product_id', 'vendor_sku', 'vendor_cost', 'stock_qty'], '{{table}}.vendor_id=' . $v->getId());

            $param = $r->getParam('filter_sku');
            if (!is_null($param) && $param !== '') {
                $collection->addAttributeToFilter('sku', ['like' => $param . '%']);
            }
            $param = $r->getParam('filter_name');
            if (!is_null($param) && $param !== '') {
                $collection->addAttributeToFilter('name', ['like' => $param . '%']);
            }
            $param = $r->getParam('filter_vendor_sku');
            if (!is_null($param) && $param !== '') {
                $collection->getSelect()->where('vendor_sku like ?', $param . '%');
            }
            $param = $r->getParam('filter_vendor_cost_from');
            if (!is_null($param) && $param !== '') {
                $collection->getSelect()->where('vendor_cost>=?', $param);
            }
            $param = $r->getParam('filter_vendor_cost_to');
            if (!is_null($param) && $param !== '') {
                $collection->getSelect()->where('vendor_cost<=?', $param);
            }
            $param = $r->getParam('filter_stock_qty_from');
            if (!is_null($param) && $param !== '') {
                $collection->getSelect()->where('stock_qty>=?', $param);
            }
            $param = $r->getParam('filter_stock_qty_to');
            if (!is_null($param) && $param !== '') {
                $collection->getSelect()->where('stock_qty<=?', $param);
            }
            $this->_collection = $collection;
        }

        return $this->_collection;
    }
}