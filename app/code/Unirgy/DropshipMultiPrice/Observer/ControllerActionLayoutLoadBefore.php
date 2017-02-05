<?php

namespace Unirgy\DropshipMultiPrice\Observer;

use Magento\Checkout\Model\Cart;
use Magento\Framework\App\Config\ScopeConfigInterface;
use Magento\Framework\App\RequestInterface;
use Magento\Framework\Event\Observer;
use Magento\Framework\Event\ObserverInterface;
use Magento\Framework\Registry;
use Magento\Framework\View\DesignInterface;
use Magento\Store\Model\ScopeInterface;
use Unirgy\DropshipMultiPrice\Helper\Data as DropshipMultiPriceHelperData;
use Unirgy\Dropship\Helper\Data as HelperData;

class ControllerActionLayoutLoadBefore extends AbstractObserver implements ObserverInterface
{
    /**
     * @var Registry
     */
    protected $_frameworkRegistry;

    /**
     * @var RequestInterface
     */
    protected $_appRequestInterface;

    /**
     * @var Cart
     */
    protected $_modelCart;

    /**
     * @var ScopeConfigInterface
     */
    protected $_configScopeConfigInterface;

    /**
     * @var DesignInterface
     */
    protected $_viewDesignInterface;

    public function __construct(HelperData $helperData, 
        DropshipMultiPriceHelperData $dropshipMultiPriceHelperData, 
        Registry $frameworkRegistry, 
        RequestInterface $appRequestInterface, 
        Cart $modelCart, 
        ScopeConfigInterface $configScopeConfigInterface, 
        DesignInterface $viewDesignInterface)
    {
        $this->_frameworkRegistry = $frameworkRegistry;
        $this->_appRequestInterface = $appRequestInterface;
        $this->_modelCart = $modelCart;
        $this->_configScopeConfigInterface = $configScopeConfigInterface;
        $this->_viewDesignInterface = $viewDesignInterface;

        parent::__construct($helperData, $dropshipMultiPriceHelperData);
    }

    public function execute(Observer $observer)
    {
        if (!$this->_hlp->isUdmultiActive()) return;
        if ($observer->getAction()
            && in_array($observer->getAction()->getFullActionName(), ['catalog_product_view','checkout_cart_configure'])
            && ($product = $this->_frameworkRegistry->registry('current_product'))
            && in_array($product->getTypeId(), ['simple','configurable','virtual'])
        ) {
            $cfgId = (int) $this->_appRequestInterface->getParam('id');
            $isCfgMode = $product->getConfigureMode();
            $bestVendor = $product->getUdmultiBestVendor();
            if ($isCfgMode && $cfgId) {
                $quoteItem = $this->_modelCart->getQuote()->getItemById($cfgId);
                if ($quoteItem && ($__br = $quoteItem->getBuyRequest()) && ($__bVid = $__br->getUdropshipVendor())) {
                    $bestVendor = $__bVid;
                    $product->setPreconfiguredUdropshipVendor($bestVendor);
                }
            }
            if ($bestVendor && ($this->_useProductBestVendorPriceAsDefault || $isCfgMode)) {
                $mvData = $product->getMultiVendorData();
                if (is_array($mvData)) {
                    foreach ($mvData as $vp) {
                        if ($vp['vendor_id']==$bestVendor) {
                            $product->setFinalPrice(null);
                            $this->_mpHlp->useVendorPrice($product, $vp);
                            $product->getFinalPrice();
                        }
                    }
                }
            }
            if ($this->_configScopeConfigInterface->isSetFlag('udprod/general/product_info_tabbed', ScopeInterface::SCOPE_STORE)) {
                $observer->getAction()->getLayout()->getUpdate()->addHandle('udmultiprice_catalog_product_view_tabbed');
            } else {
                $observer->getAction()->getLayout()->getUpdate()->addHandle('udmultiprice_catalog_product_view');
            }
        } elseif ($observer->getAction()
            && in_array($observer->getAction()->getFullActionName(), ['catalog_category_view'])
        ) {
            if ($this->_viewDesignInterface->getPackageName()=='rwd') {
                $observer->getAction()->getLayout()->getUpdate()->addHandle('_udmp_change_product_listproduct_tpl_rwd');
            } else {
                $observer->getAction()->getLayout()->getUpdate()->addHandle('_udmp_change_product_listproduct_tpl');
            }
        } elseif ($observer->getAction()
            && in_array($observer->getAction()->getFullActionName(), ['catalogsearch_result_index','catalogsearch_advanced_result'])
        ) {
            if ($this->_viewDesignInterface->getPackageName()=='rwd') {
                $observer->getAction()->getLayout()->getUpdate()->addHandle('_udmp_change_product_listproduct_searchtpl_rwd');
            } else {
                $observer->getAction()->getLayout()->getUpdate()->addHandle('_udmp_change_product_listproduct_searchtpl');
            }
        }
    }
}
