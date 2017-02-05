<?php

namespace Unirgy\DropshipSellYours\Block;

use Magento\CatalogSearch\Model\Advanced;
use Magento\CatalogSearch\Model\Layer as ModelLayer;
use Magento\Framework\App\ObjectManager;
use Magento\Framework\App\RequestInterface;
use Magento\Framework\Registry;
use Magento\Framework\View\Element\Template;
use Magento\Framework\View\Element\Template\Context;
use Unirgy\Dropship\Helper\Catalog;
use Unirgy\Dropship\Helper\Data as HelperData;

class Result extends Template
{
    /**
     * @var RequestInterface
     */
    protected $_request;

    /**
     * @var Registry
     */
    protected $_registry;

    /**
     * @var HelperData
     */
    protected $_hlp;

    /**
     * @var Advanced
     */
    protected $_modelAdvanced;

    /**
     * @var \Magento\Catalog\Model\Layer\Search
     */
    protected $_catalogSearchModelLayer;

    /**
     * @var Catalog
     */
    protected $_helperCatalog;

    public function __construct(Context $context, 
        Registry $frameworkRegistry,
        HelperData $helperData,
        Advanced $modelAdvanced, 
        \Magento\Catalog\Model\Layer\Search $catalogSearchModelLayer,
        Catalog $helperCatalog,
        array $data = [])
    {
        $this->_registry = $frameworkRegistry;
        $this->_hlp = $helperData;
        $this->_modelAdvanced = $modelAdvanced;
        $this->_catalogSearchModelLayer = $catalogSearchModelLayer;
        $this->_helperCatalog = $helperCatalog;

        parent::__construct($context, $data);
    }

    public function setListCollection()
    {
        if ($this->_request->getParam('q') || $this->_registry->registry('current_category')) {
            $this->setListOrders();
            $this->getChild('search_result_list')
                ->setCollection($this->_getProductCollection());
        }
    }

    public function getListBlock()
    {
        return $this->getChild('search_result_list');
    }

    public function setListOrders()
    {
        $category = $this->_catalogSearchModelLayer
            ->getCurrentCategory();
        /* @var $category \Magento\Catalog\Model\Category */
        $availableOrders = $category->getAvailableSortByOptions();
        unset($availableOrders['position']);
        $availableOrders = array_merge([
            'relevance' => __('Relevance')
        ], $availableOrders);

        $this->getListBlock()
            ->setAvailableOrders($availableOrders)
            ->setDefaultDirection('desc')
            ->setSortBy('relevance');

        return $this;
    }

    protected function _getProductCollection()
    {
        $col = $this->getSearchModel()->getProductCollection();

        if ($this->_registry->registry('current_category')) {
            $col->addCategoryFilter($this->_registry->registry('current_category'));
        }
        $col->addAttributeToFilter('type_id', ['in'=>['simple','configurable','downloadable','virtual']]);
        $sess = ObjectManager::getInstance()->get('Unirgy\Dropship\Model\Session');
        if ($sess->getData('udsell_search_type')) {
            $col->addAttributeToFilter('entity_id', ['in'=>$sess->getVendor()->getVendorTableProductIds()]);
        }
        return $col;
    }
    public function getSearchModel()
    {
        $isEE = $this->_hlp->isEE();
        $isSearchEE = false;
        if ($this->getRequest()->getParam('type') == 'barcode'
            || !$this->getRequest()->getParam('q')
        ) {
            if ($isSearchEE) {
                return ObjectManager::getInstance()->get('UNKNOWN\enterprise_search\catalog_layer');
            } else {
                return $this->_modelAdvanced;
            }
        } else {
            if ($isSearchEE) {
                return ObjectManager::getInstance()->get('UNKNOWN\enterprise_search\search_layer');
            } else {
                return $this->_catalogSearchModelLayer;
            }
        }
    }

    public function getResultCount()
    {
        if (!$this->getData('result_count')) {
            $size = $this->getSearchModel()->getProductCollection()->getSize();
            $this->setResultCount($size);
        }
        return $this->getData('result_count');
    }

    protected function _prepareLayout()
    {
        if ($breadcrumbsBlock = $this->getLayout()->getBlock('breadcrumbs')) {
            $sess = ObjectManager::getInstance()->get('Unirgy\Dropship\Model\Session');
            $searchUrlKey = $sess->getData('udsell_search_type') ? 'mysellSearch' : 'sellSearch';
            if ($sess->getData('udsell_search_type')) {
                $breadcrumbsBlock->addCrumb('sellyours', [
                    'label'=>__('My Sell List'),
                    'title'=>__('My Sell List'),
                    'link'=>$this->getUrl('udsell/index/mysellSearch')
                ]);
            } else {
                $breadcrumbsBlock->addCrumb('sellyours', [
                    'label'=>__('Sell Yours'),
                    'title'=>__('Sell Yours'),
                    'link'=>$this->getUrl('udsell/index/sellSearch')
                ]);
            }

            if ($this->_registry->registry('current_category')) {
                $cat = $this->_registry->registry('current_category');
                $pathIds = explode(',', $cat->getPathInStore());
                array_shift($pathIds);
                $cats = $this->_helperCatalog->getCategoriesCollection($pathIds);
                foreach ($cats as $c) {
                    $breadcrumbsBlock->addCrumb('sellyours_cat'.$c->getId(), [
                        'label'=>$c->getName(),
                        'title'=>$c->getName(),
                        'link'=>$this->getUrl('udsell/index/'.$searchUrlKey, ['_current'=>true, 'c'=>$c->getId()])
                    ]);
                }
                $breadcrumbsBlock->addCrumb('sellyours_cat'.$cat->getId(), [
                    'label'=>$cat->getName(),
                    'title'=>$cat->getName(),
                    'link'=>$this->getUrl('udsell/index/'.$searchUrlKey, ['_current'=>true, 'c'=>$cat->getId()])
                ]);
            }

            if (($q = $this->getRequest()->getParam('q'))) {
                $breadcrumbsBlock->addCrumb('sellyours_query', [
                    'label'=>htmlspecialchars($q),
                    'title'=>htmlspecialchars($q),
                    'link'=>$this->getUrl('*/*/*', ['_current'=>true])
                ]);
            }

        }
    }
}