<?php

namespace Unirgy\DropshipSellYours\Observer;

use Unirgy\Dropship\Helper\Data as HelperData;

abstract class AbstractObserver
{
    /**
     * @var HelperData
     */
    protected $_hlp;
    protected $_src;

    protected $_scopeConfig;
    protected $_sySrc;
    protected $_storeManager;

    public function __construct(
        HelperData $udropshipHelper,
        \Unirgy\Dropship\Model\Source $udropshipSource,
        \Unirgy\DropshipSellYours\Model\Source $udsellSource,
        \Magento\Framework\App\Config\ScopeConfigInterface $scopeConfig,
        \Magento\Store\Model\StoreManagerInterface $storeManager
    )
    {
        $this->_hlp = $udropshipHelper;
        $this->_src = $udropshipSource;
        $this->_scopeConfig = $scopeConfig;
        $this->_sySrc = $udsellSource;
        $this->_storeManager = $storeManager;
    }


    protected function _initConfigRewrites()
    {
        return;
        if (
        $this->_helperData->compareMageVer('1.7.0.0', '1.12.0.0')
        ) {
            if (
            $this->_helperData->compareMageVer('1.9.0.1', '1.14.0.0')
            ) {
                Mage::getConfig()->setNode('global/models/catalogsearch_resource/rewrite/fulltext', 'Unirgy\DropshipSellYours\Model\Rewrite1901\CatalogSearch\Resource\Fulltext');
            } else {
                Mage::getConfig()->setNode('global/models/catalogsearch_resource/rewrite/fulltext', 'Unirgy\DropshipSellYours\Model\Rewrite1700\CatalogSearch\Resource\Fulltext');
            }

            Mage::getConfig()->setNode('global/models/catalogsearch_resource/rewrite/fulltext_engine', 'Unirgy\DropshipSellYours\Model\Rewrite1700\CatalogSearch\Resource\Fulltext\Engine');
            Mage::getConfig()->setNode('global/models/catalogsearch_resource/rewrite/fulltext_collection', 'Unirgy\DropshipSellYours\Model\Rewrite1700\CatalogSearch\Resource\Fulltext\Collection');
        }
    }
}