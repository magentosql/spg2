<?php

namespace Unirgy\DropshipMultiPrice\Helper;

use Magento\Catalog\Model\Product;
use Magento\Catalog\Model\ResourceModel\Category\Collection;
use Magento\Framework\App\Helper\AbstractHelper;
use Magento\Framework\App\Helper\Context;
use Magento\Framework\DB\Select;
use Magento\Framework\DataObject;
use Magento\Framework\Profiler;
use Magento\Framework\Registry;
use Magento\Framework\View\Layout;
use Unirgy\DropshipMulti\Helper\Data as DropshipMultiHelperData;
use Unirgy\Dropship\Helper\Catalog;
use Unirgy\Dropship\Helper\Data as HelperData;
use Unirgy\Dropship\Helper\Item;

class Data extends AbstractHelper
{
    /**
     * @var HelperData
     */
    protected $_hlp;

    /**
     * @var Item
     */
    protected $_iHlp;

    /**
     * @var DropshipMultiHelperData
     */
    protected $_multiHlp;

    /**
     * @var Registry
     */
    protected $_registry;

    /**
     * @var Layout
     */
    protected $_viewLayout;

    /**
     * @var Collection
     */
    protected $_categoryCollection;

    /**
     * @var Catalog
     */
    protected $_helperCatalog;

    public function __construct(Context $context,
                                HelperData $helperData,
                                Item $helperItem,
                                DropshipMultiHelperData $dropshipMultiHelperData,
                                Registry $frameworkRegistry,
                                Layout $viewLayout,
                                Collection $categoryCollection,
                                Catalog $helperCatalog
    )
    {
        $this->_hlp = $helperData;
        $this->_iHlp = $helperItem;
        $this->_multiHlp = $dropshipMultiHelperData;
        $this->_registry = $frameworkRegistry;
        $this->_viewLayout = $viewLayout;
        $this->_categoryCollection = $categoryCollection;
        $this->_helperCatalog = $helperCatalog;

        parent::__construct($context);
    }

    const UDMP_VENDOR_DATA_OPTION = 'udmp_vendor_data';
    public function getVendorRank($v, $price=null)
    {
        //$baseRank = $price>0?$price*10:1;
        $baseRank = 1;
        if ($v->getIsProAccount()) $baseRank = $baseRank << 1;
        if ($v->getIsCertified()) $baseRank = $baseRank << 2;
        if ($v->getIsFeatured()) $baseRank = $baseRank << 4;
        if ($v->getId()==$this->_hlp->getLocalVendorId()) $baseRank = $baseRank << 8;
        return $baseRank;
    }
    public function vendors_sort_cmp($a, $b)
    {
        $av = $this->_hlp->getVendor($a['vendor_id']);
        $bv = $this->_hlp->getVendor($b['vendor_id']);
        $avPrice = $this->_sortProduct instanceof Product
            ? $this->getVPFinalPrice($this->_sortProduct, $a)
            : $a['vendor_price'];
        $bvPrice = $this->_sortProduct instanceof Product
            ? $this->getVPFinalPrice($this->_sortProduct, $b)
            : $b['vendor_price'];
        $arank = $this->getVendorRank($av, $avPrice);
        $brank = $this->getVendorRank($bv, $bvPrice);
        return $arank > $brank ? -1 : ($arank < $brank ? 1 : ($bvPrice > $avPrice ? -1 : ($bvPrice < $avPrice ? 1 : 0)));
    }
    protected $_sortProduct;
    public function getSortedVendors($vendors, $_product=null)
    {
        $this->_sortProduct = $_product;
        @usort($vendors, [$this, 'vendors_sort_cmp']);
        $this->_sortProduct = null;
        return $vendors;
    }
    public function getVPFinalPrice($product, $vendorData)
    {
        return $this->getVendorProductFinalPrice($product, $vendorData);
    }
    public function getVendorProductFinalPrice($product, $vendorData)
    {
        Profiler::start('udmulti_getVendorProductFinalPrice');
        $this->useVendorPrice($product, $vendorData);
        $finalPrice = $product->getFinalPrice();
        $this->revertVendorPrice($product);
        Profiler::stop('udmulti_getVendorProductFinalPrice');
        return $finalPrice;
    }
    public function useVendorPrice($product, $vendorData=null)
    {
        $this->_hlp->getObj('\Unirgy\DropshipMultiPrice\Helper\ProtectedCode')->useVendorPrice($product, $vendorData);
        return $this;
    }
    public function canUseVendorPrice($product)
    {
        return (bool)$product->getCustomOption('info_buyRequest');
        //return ($vendorOption = $this->getVendorOption($product)) && isset($vendorOption['vendor_price']);
    }

    public function revertVendorPrice($product)
    {
        $this->_hlp->getObj('\Unirgy\DropshipMultiPrice\Helper\ProtectedCode')->revertVendorPrice($product);
        return $this;
    }
    public function getAdditionalOptions($item)
    {
        return $this->_iHlp->getAdditionalOptions($item);
    }
    public function getItemOption($item, $code)
    {
        return $this->_iHlp->getItemOption($item, $code);
    }
    public function saveAdditionalOptions($item, $options)
    {
        $this->_iHlp->saveAdditionalOptions($item, $options);
        return $this;
    }
    public function saveItemOption($item, $code, $value, $serialize)
    {
        $this->_iHlp->saveItemOption($item, $code, $value, $serialize);
        return $this;
    }
    public function deleteItemOption($item, $code, $value, $serialize)
    {
        $this->_iHlp->deleteItemOption($item, $code);
        return $this;
    }
    public function getVendorOption($item)
    {
        $vendorOption = null;
        $vendorOption = $this->getItemOption($item, 'udmp_vendor_data');
        if (!empty($vendorOption)) {
            if (is_string($vendorOption)) {
                $vendorOption = unserialize($vendorOption);
            }
            if (!is_array($vendorOption)) {
                $vendorOption = null;
            }
        }
        return $vendorOption;
    }
    public function addBRVendorOption($item, $buyRequest=null)
    {
        //if ($this->_iHlp->getIsCartUpdateActionFlag()) return $this;
        $iHlp = $this->_iHlp;
        if (null === $buyRequest) {
            $buyRequest = $iHlp->getItemOption($item, 'info_buyRequest');
            if (!is_array($buyRequest)) {
                $buyRequest = unserialize($buyRequest);
            }
        }
        $brUdropshipVendor = null;
        if ($buyRequest instanceof DataObject
            && $buyRequest->getCode() == 'info_buyRequest'
            && $buyRequest->hasValue()
        ) {
            $buyRequest = $buyRequest->getValue();
            if (!is_array($buyRequest)) {
                $buyRequest = unserialize($buyRequest);
            }
        }
        $product = $item->getProduct();
        if ($item instanceof Product) {
            $product = $item;
        }
        $_brVid = (int)@$buyRequest['udropship_vendor'];
        if ($_brVid) {
            $brUdropshipVendor = $_brVid;
        } else {
            $brUdropshipVendor = $product->getUdmultiBestVendor();
        }
        if ($brUdropshipVendor && $product
            && $this->_hlp->getVendor($brUdropshipVendor)->getId()
            && ($mvData = $product->getMultiVendorData($brUdropshipVendor))
            && $mvData['vendor_id'] == $brUdropshipVendor
            && false !== ($prepMvData = $this->_prepareVendorOptionData($mvData))
        ) {
            $iHlp->deleteForcedVendorIdOption($item);
            $iHlp->deleteItemOption($item, self::UDMP_VENDOR_DATA_OPTION);
            $iHlp->deleteVendorIdOption($item);
            $iHlp->setForcedVendorIdOption($item, $mvData['vendor_id']);
            $iHlp->saveItemOption($item, self::UDMP_VENDOR_DATA_OPTION, $prepMvData, true);
            $iHlp->setVendorIdOption($item, $brUdropshipVendor, true);
            if ($item->getHasChildren()) {
                $children = $item->getChildrenItems() ? $item->getChildrenItems() : $item->getChildren();
                foreach ($children as $child) {
                    $iHlp->setForcedVendorIdOption($child, $mvData['vendor_id']);
                }
            }
        }
    }
    public function addVendorOption($item, $vId=null)
    {
        if ($this->_iHlp->getIsCartUpdateActionFlag()) return $this;
        if (null === $vId) {
            $vId = $item->getUdropshipVendor();
        }
        $iHlp = $this->_iHlp;
        $iHlp->deleteItemOption($item, self::UDMP_VENDOR_DATA_OPTION);
        $iHlp->deleteVendorIdOption($item);
        $iHlp->setVendorIdOption($item, $vId, true);
        if ($this->_hlp->getVendor($vId)->getId()
            && ($mvData = $item->getProduct()->getMultiVendorData($vId))
            && $mvData['vendor_id'] == $vId
            && false !== ($prepMvData = $this->_prepareVendorOptionData($mvData))
        ) {
            $iHlp->saveItemOption($item, self::UDMP_VENDOR_DATA_OPTION, $prepMvData, true);
        }
        return $this;
    }
    protected function _prepareVendorOptionData($data)
    {
        if (empty($data['vendor_id'])
            || !($v = $this->_hlp->getVendor($data['vendor_id']))
            || !$v->getId()
        ) {
            return false;
        }
        $vendorOption = $data;
        $vendorOption['udropship_vendor'] = $data['vendor_id'];
        $vendorOption['label'] = (string)__('Vendor');
        $vendorOption['value'] = $this->_hlp->getVendor($data['vendor_id'])->getVendorName();
        return $vendorOption;
    }

    public function getExtCanonicState($extendedState, $returnType='code', $useDefault=false)
    {
        return $this->_hlp->getObj('\Unirgy\DropshipMultiPrice\Model\Source')->getExtCanonicState($extendedState, $returnType, $useDefault);
    }
    public function getCanonicState($canonicState, $returnType='code', $useDefault=false)
    {
        return $this->_hlp->getObj('\Unirgy\DropshipMultiPrice\Model\Source')->getCanonicState($canonicState, $returnType, $useDefault);
    }
    public function getExtState($extState, $returnType='code', $useDefault=false)
    {
        return $this->_hlp->getObj('\Unirgy\DropshipMultiPrice\Model\Source')->getExtState($extState, $returnType, $useDefault);
    }

    public function getFullGroupedMultipriceData($product)
    {
        Profiler::start('udmulti_getFullGroupedMultipriceData');
        $simpleProducts = [];
        if ($product->getTypeId()=='configurable') {
            $simpleProducts = $product->getTypeInstance(true)->getUsedProducts($product);
        }
        array_unshift($simpleProducts, $product);
        $this->_multiHlp->attachMultivendorData($simpleProducts, true);
        $vendors = [];
        foreach($simpleProducts as $simpleProduct) {
            $_vendors = $simpleProduct->getMultiVendorData();
            $cfgMvData = $simpleProduct->getMultiVendorData();
            if (!empty($_vendors) && is_array($_vendors)) {
                foreach ($_vendors as &$_v) {
                    foreach ($cfgMvData as $_vCfg) {
                        if ($_vCfg['vendor_id']==$_v['vendor_id']) {
                            if (!$this->isConfigurableSimplePrice()) {
                                $_v['__price_product'] = $product;
                                $_v['__price_data'] = $_vCfg;
                            } else {
                                $_v['__price_product'] = $simpleProduct;
                                $_v['__price_data'] = $_v;
                            }
                        }
                    }
                }
                unset($_v);
                $vendors = array_merge($vendors, $_vendors);
            }
        }
        Profiler::stop('udmulti_getFullGroupedMultipriceData');
        return $this->_getGroupedMultipriceData($product, $vendors);
    }
    public function getGroupedMultipriceData($product)
    {
        Profiler::start('udmulti_getGroupedMultipriceData');
        $this->_multiHlp->attachMultivendorData([$product], true);
        $vendors = $product->getMultiVendorData();
        Profiler::stop('udmulti_getGroupedMultipriceData');
        return $this->_getGroupedMultipriceData($product, $vendors);
    }
    protected function _getGroupedMultipriceData($product, $vendors)
    {
        $vendors = $this->getSortedVendors($vendors, $product);
        $canonicStatesByExt['all'] = $canonicStates['all'] = $vendorStates['all'] = [
            'value' => 'all',
            'html_value' => 'all',
            'label' => __('All'),
            'html_label' => __('All'),
        ];
        $canonicStatesPrice = ['all'=>[null,null]];
        $canonicStatesCnt = ['all'=>0];
        foreach ($vendors as $_data) {
            $_data['state'] = $this->getExtState($_data['state'], 'code', true);
            $_canonicState = $this->getExtCanonicState($_data['state'], 'pair');
            $_extState = $this->getExtState($_data['state'], 'pair');
            if (empty($_data['state']) || empty($_canonicState) || empty($_extState)) continue;
            reset($_canonicState); reset($_extState);
            $vendorStates[key($_extState)] = [
                'value' => key($_extState),
                'html_value' => htmlspecialchars(key($_extState), ENT_QUOTES),
                'label' => current($_extState),
                'html_label' => htmlspecialchars(current($_extState), ENT_QUOTES),
            ];
            $_canTmp = [
                'value' => key($_canonicState),
                'html_value' => htmlspecialchars(key($_canonicState), ENT_QUOTES),
                'label' => current($_canonicState),
                'html_label' => htmlspecialchars(current($_canonicState), ENT_QUOTES),
            ];
            $canonicStatesByExt[key($_extState)] = $_canTmp;
            $canonicStates[key($_canonicState)] = $_canTmp;
            if (empty($canonicStatesCnt[key($_canonicState)])) {
                $canonicStatesCnt[key($_canonicState)] = 1;
            } else {
                $canonicStatesCnt[key($_canonicState)]++;
            }
            if (empty($canonicStatesPrice[key($_canonicState)])) {
                $canonicStatesPrice[key($_canonicState)] = [null,null];
            }
            $canonicStatesCnt['all']++;
            $priceData = isset($_data['__price_data'])
                ? $_data['__price_data'] : $_data;
            $priceProduct = isset($_data['__price_product'])
                ? $_data['__price_product'] : $product;
            $finalPrice = $this->getVPFinalPrice($priceProduct, $priceData);
            if ($canonicStatesPrice['all'][0]===null || $canonicStatesPrice['all'][0]>$finalPrice) {
                $canonicStatesPrice['all'][0] = $finalPrice;
            }
            if ($canonicStatesPrice['all'][1]===null || $canonicStatesPrice['all'][1]<$finalPrice) {
                $canonicStatesPrice['all'][1] = $finalPrice;
            }
            if ($canonicStatesPrice[key($_canonicState)][0]===null || $canonicStatesPrice[key($_canonicState)][0]>$finalPrice) {
                $canonicStatesPrice[key($_canonicState)][0] = $finalPrice;
            }
            if ($canonicStatesPrice[key($_canonicState)][1]===null || $canonicStatesPrice[key($_canonicState)][1]<$finalPrice) {
                $canonicStatesPrice[key($_canonicState)][1] = $finalPrice;
            }
        }
        //$pluralKeys = array('new');
        $pluralKeys = [];
        foreach ($canonicStatesCnt as $cscKey => $csc) {
            //$canonicStatesByExt[$cscKey]['orig_label'] = $canonicStatesByExt[$cscKey]['label'];
            //$canonicStatesByExt[$cscKey]['orig_html_label'] = $canonicStatesByExt[$cscKey]['html_label'];
            $canonicStates[$cscKey]['orig_label'] = $canonicStates[$cscKey]['label'];
            $canonicStates[$cscKey]['orig_html_label'] = $canonicStates[$cscKey]['html_label'];
            //$vendorStates[$cscKey]['orig_label'] = $vendorStates[$cscKey]['label'];
            //$vendorStates[$cscKey]['orig_html_label'] = $vendorStates[$cscKey]['html_label'];
            if ($csc>1 && in_array($cscKey, $pluralKeys)) {
                //$canonicStatesByExt[$cscKey]['label'] .= 's';
                //$canonicStatesByExt[$cscKey]['html_label'] .= 's';
                $canonicStates[$cscKey]['label'] .= 's';
                $canonicStates[$cscKey]['html_label'] .= 's';
                //$vendorStates[$cscKey]['label'] .= 's';
                //$vendorStates[$cscKey]['html_label'] .= 's';
            }
        }
        $result = compact('canonicStatesByExt', 'canonicStatesCnt', 'canonicStatesPrice', 'canonicStates', 'vendorStates');
        return $result;
    }
    public function hasOtherOffers($product)
    {
        $vendors = $product->getMultiVendorData();
        unset($vendors[$this->_hlp->getLocalVendorId()]);
        return count($vendors)>0;
    }

    public function isConfigurableSimplePrice()
    {
        return $this->_hlp->isModuleActive('OrganicInternet_SimpleConfigurableProducts');
    }

    public function getCfgMultiPriceDataJson($prodBlock)
    {
        return $this->getMultiPriceDataJson($prodBlock);
    }
    public function getMultiPriceDataJson($prodBlock)
    {
        $product = $prodBlock->getProduct();
        $product = !$product ? $this->_registry->registry('current_product') : $product;
        $product = !$product ? $this->_registry->registry('product') : $product;
        $result = [];
        $udmHlp = $this->_multiHlp;
        $simpleProducts = [];
        if ($product->getTypeId()=='configurable') {
            $simpleProducts = $product->getTypeInstance(true)->getUsedProducts($product);
        }
        array_unshift($simpleProducts, $product);
        $udmHlp->attachMultivendorData($simpleProducts, true);
        foreach ($simpleProducts as $simpleProduct) {
            $mvData = $simpleProduct->getMultiVendorData();
            $cfgMvData = $product->getMultiVendorData();
            if (!empty($mvData) && is_array($mvData) && !empty($cfgMvData) && is_array($cfgMvData)) {
                foreach ($mvData as &$_v) {
                    $_foundCfg = false;
                    foreach ($cfgMvData as $_vCfg) {
                        if ($_vCfg['vendor_id']==$_v['vendor_id']) {
                            $_foundCfg = true;
                            $_v['__price_product'] = $simpleProduct;
                            $_v['__price_data'] = $_v;
                        }
                    }
                    if (!$_foundCfg) {
                        $_v['__price_product'] = $simpleProduct;
                        $_v['__price_data'] = $_v;
                    }
                }
                unset($_v);
                $simpleProduct->setMultiVendorData($mvData);
            }
            $_result = $this->prepareMultiVendorHtmlData($prodBlock, $simpleProduct);
            if ($_result) {
                foreach ($_result['mvData'] as &$__mvd) {
                    unset($__mvd['__price_product']);
                    unset($__mvd['__price_data']);
                }
                unset($__mvd);
                $result[$simpleProduct->getId()] = $_result;
            }
        }
        return $this->_hlp->jsonEncode($result);
    }
    public function prepareMultiVendorHtmlData($prodBlock, $product)
    {
        Profiler::start('udmulti_prepareMultiVendorHtmlData');
        $udHlp = $this->_hlp;
        $mpHlp = $this;
        $udmHlp = $this->_multiHlp;
        if (($isMicro = $udHlp->isModuleActive('Unirgy_DropshipMicrosite'))) {
            $msHlp = $this->_hlp->getObj('Unirgy\DropshipMicrosite\Helper\Data');
        }
        $mvData = $product->getMultiVendorData();
        $mvData = $mpHlp->getSortedVendors($mvData, $product);
        $gmpData = $mpHlp->getGroupedMultipriceData($product);

        foreach ($mvData as &$mv) {
            $mv['state'] = $this->getExtState($mv['state'], 'code', true);
            $mv['canonic_state'] = $this->getExtCanonicState($mv['state'], 'code', true);
            $_mv = [];
            $v = $udHlp->getVendor($mv['vendor_id']);
            $_mv['shipping_price_html'] = $this->getShippingPrice($product, $mv, 1);
            $_mv['freeshipping'] = (bool)$mv['freeshipping'];
            $_mv['is_in_stock'] = (bool)$udmHlp->isSalableByVendorData($product, $mv['vendor_id'], $mv);
            $_mv['is_certified'] = (bool)$v->getIsCertified();
            $_mv['is_featured'] = (bool)$v->getIsFeatured();
            $_mv['is_pro'] = (bool)$v->getIsProAccount();
            $_mv['vendor_name'] = $v->getVendorName();
            $_mv['review_html'] = '';
            $_mv['vendor_base_url'] = '';
            $_mv['vendor_logo'] = $v->getLogo() ? $this->_hlp->getResizedVendorLogoUrl($v, 80, 65) : '';
            if ($this->_hlp->isModuleActive('Unirgy_DropshipVendorRatings')) {
                $_mv['review_html'] = $this->_hlp->getObj('Unirgy\DropshipVendorRatings\Helper\Data')->getReviewsSummaryHtml($v);
            }
            if ($isMicro && $msHlp->isAllowedAction('microsite', $v)) {
                $_mv['vendor_base_url'] = $msHlp->getVendorBaseUrl($v);
            }
            $_mv['is_allowed_microsite'] = $isMicro && $msHlp->isAllowedAction('microsite', $v);
            $priceProduct = isset($mv['__price_product'])
                ? $mv['__price_product'] : $product;
            $priceData = isset($mv['__price_data'])
                ? $mv['__price_data'] : $mv;

            $mpHlp->useVendorPrice($priceProduct, $priceData);

            $origPrice = $priceProduct->getPrice();
            $priceProduct->setFinalPrice(null);
            $priceProduct->reloadPriceInfo();

            $idSuffix = sprintf('_udmp_%d_%d', $priceProduct->getId(), $mv['vendor_id']);

            $priceBlockId = 'udmp.price.render-'.$priceProduct->getId().'-'.$v->getId();
            $priceBlock = $prodBlock->getLayout()->getBlock($priceBlockId);
            if (!$priceBlock) {
                $priceBlock = $prodBlock->getLayout()->createBlock('Magento\Catalog\Pricing\Render', $priceBlockId,
                    ['data' => [
                        'price_render' => 'product.price.render.default',
                        'price_type_code' => 'final_price',
                        'zone' => 'item_view',
                        'price_id_suffix' => $idSuffix,
                    ]]
                );
            }
            $prodBlock->setProductItem($priceProduct);
            $prodBlock->setChild($priceBlockId, $priceBlock);
            $_mv['price_html'] = $priceBlock->toHtml();

            $tpPriceBlockId = 'udmp.price.tier.render-'.$priceProduct->getId().'-'.$v->getId();
            $tpPriceBlock = $prodBlock->getLayout()->getBlock($tpPriceBlockId);
            if (!$tpPriceBlock) {
                $tpPriceBlock = $prodBlock->getLayout()->createBlock('Magento\Catalog\Pricing\Render', $tpPriceBlockId,
                    ['data' => [
                        'price_render' => 'product.price.render.default',
                        'price_type_code' => 'tier_price',
                        'zone' => 'item_view',
                        'price_id_suffix' => $idSuffix,
                    ]]
                );
            }
            $_mv['tier_price_html'] = $tpPriceBlock->toHtml();

            $_mv['idSuffix']     = $idSuffix;

            $mpHlp->revertVendorPrice($priceProduct);
            $priceProduct->setPrice($origPrice);

            $_mv['state_label'] = $gmpData['vendorStates'][$mv['state']]['html_label'];
            $mv = $_mv+$mv;
        }
        unset($mv);
        if (empty($mvData)) return false;
        $_result = [
            'product_id' => $product->getId(),
            'grouped_multiprice_data' => $gmpData,
            'mvData' => $mvData
        ];
        Profiler::stop('udmulti_prepareMultiVendorHtmlData');
        return $_result;
    }
    public function hasFreeshipping($product)
    {
        $this->_multiHlp->attachMultivendorData([$product], true);
        $mvData = $product->getMultiVendorData();
        $hasFS = false;
        if (is_array($mvData)) {
            foreach ($mvData as $mv) {
                if (@$mv['freeshipping']) {
                    $hasFS = true;
                    break;
                }
            }
        }
        return $hasFS;
    }
    public function getShippingPrice($product, $mv, $format=0)
    {
        $udHlp = $this->_hlp;
        $v = $udHlp->getVendor($mv['vendor_id']);
        $_catIds = $product->getCategoryIds();
        $shippingPrice = null;
        if (!empty($mv['freeshipping'])) {
            $shippingPrice = 0;
        } elseif (null !== @$mv['shipping_price'] && '' !== @$mv['shipping_price']) {
            $shippingPrice = @$mv['shipping_price'];
        }
        if (null === $shippingPrice && !empty($_catIds)
            && $this->_hlp->isModuleActive('udtiership')
            && $this->_hlp->isModuleActive('udshipclass')
        ) {
            reset($_catIds);
            $catId = current($_catIds);
            $cats = $this->_categoryCollection->addIdFilter([$catId]);
            $cat = $cats->getItemById($catId);
            $catPath = explode(',', $this->_helperCatalog->getPathInStore($cat));
            $topCatId = end($catPath);
            $topCats = $this->_helperCatalog->getTopCategories();
            if ($topCatId && $topCats->getItemById($topCatId)) {
                $tsHlp = $this->_hlp->getObj('Unirgy\DropshipTierShipping\Helper\Data');
                $vTierShip = $tsHlp->getVendorTiershipRates($v);
                $gTierShip = $tsHlp->getGlobalTierShipConfig();
                $vscId = $this->_hlp->getObj('Unirgy\DropshipShippingClass\Helper\Data')->getVendorShipClass($v->getId());
                $cscId = $this->_hlp->getObj('Unirgy\DropshipShippingClass\Helper\Data')->getCustomerShipClass();
                $shippingPrice = $tsHlp->getRateToUse($vTierShip, $gTierShip, $topCatId, $vscId, $cscId, 'cost');
            }
        }
        return !$format
            ? $shippingPrice
            : ($format==1
                ? $this->_hlp->formatPrice($shippingPrice, false)
                : $this->_hlp->formatPrice($shippingPrice, true)
            );
    }
    public function attachFullPriceComparisonByState($products)
    {
        foreach ($products as $product) {
            $fgmpData = $this->getFullGroupedMultipriceData($product);
            $product->setData('FullGroupedMultipriceData', $fgmpData);
            $pcByState = @$fgmpData['canonicStatesPrice'];
            $pcByState = is_array($pcByState) ? $pcByState : [];
            $cntByState = @$fgmpData['canonicStatesCnt'];
            $cntByState = is_array($cntByState) ? $cntByState : [];
            $canonicStates = @$fgmpData['canonicStates'];
            $canonicStates = is_array($canonicStates) ? $canonicStates : [];
            $product->setData('PriceComparisonCanonicStates', $canonicStates);
            $product->setData('FullPriceComparisonByState', $pcByState);
            $product->setData('FullPriceComparisonByStateCnt', $pcByState);
            unset($pcByState['all']);
            unset($cntByState['all']);
            $product->setData('PriceComparisonByState', $pcByState);
            $product->setData('PriceComparisonByStateCnt', $cntByState);
        }
        return $this;
    }
    public function attachPriceComparisonByState($products)
    {
        foreach ($products as $product) {

            $canonicStatesByExt['all'] = $canonicStates['all'] = $vendorStates['all'] = [
                'value' => 'all',
                'html_value' => 'all',
                'label' => __('All'),
                'html_label' => __('All'),
            ];
            $canonicStatesPrice = ['all'=>[null,null]];
            $canonicStatesCnt = ['all'=>0];

            $udmpSrc = $this->_hlp->getObj('\Unirgy\DropshipMultiPrice\Model\Source');
            $canStates = $udmpSrc->setPath('vendor_product_state_canonic')->toOptionHash();
            foreach ($canStates as $csKey=>$csLbl) {
                $curCnt = $product->getData('udmp_'.$csKey.'_cnt');
                $curMin = $product->getData('udmp_'.$csKey.'_min_price');
                $curMax = $product->getData('udmp_'.$csKey.'_max_price');
                if (!$curCnt) continue;
                $_canonicState = [$csKey=>$csLbl];
                $_extState = $udmpSrc->getCanonicExtStates($csKey, 'pair', true);
                if (empty($_extState)) continue;
                reset($_canonicState); reset($_extState);
                $vendorStates[key($_extState)] = [
                    'value' => key($_extState),
                    'html_value' => htmlspecialchars(key($_extState), ENT_QUOTES),
                    'label' => current($_extState),
                    'html_label' => htmlspecialchars(current($_extState), ENT_QUOTES),
                ];
                $_canTmp = [
                    'value' => key($_canonicState),
                    'html_value' => htmlspecialchars(key($_canonicState), ENT_QUOTES),
                    'label' => current($_canonicState),
                    'html_label' => htmlspecialchars(current($_canonicState), ENT_QUOTES),
                ];
                $canonicStatesByExt[key($_extState)] = $_canTmp;
                $canonicStates[key($_canonicState)] = $_canTmp;
                $canonicStatesCnt[key($_canonicState)] = $curCnt;
                $canonicStatesPrice[key($_canonicState)] = [$curMin,$curMax];
                $canonicStatesCnt['all'] += $curCnt;
                if ($canonicStatesPrice['all'][0]===null || $canonicStatesPrice['all'][0]>$curMin) {
                    $canonicStatesPrice['all'][0] = $curMin;
                }
                if ($canonicStatesPrice['all'][1]===null || $canonicStatesPrice['all'][1]<$curMax) {
                    $canonicStatesPrice['all'][1] = $curMax;
                }
            }
            $pluralKeys = [];
            foreach ($canonicStatesCnt as $cscKey => $csc) {
                //$canonicStatesByExt[$cscKey]['orig_label'] = $canonicStatesByExt[$cscKey]['label'];
                //$canonicStatesByExt[$cscKey]['orig_html_label'] = $canonicStatesByExt[$cscKey]['html_label'];
                $canonicStates[$cscKey]['orig_label'] = $canonicStates[$cscKey]['label'];
                $canonicStates[$cscKey]['orig_html_label'] = $canonicStates[$cscKey]['html_label'];
                //$vendorStates[$cscKey]['orig_label'] = $vendorStates[$cscKey]['label'];
                //$vendorStates[$cscKey]['orig_html_label'] = $vendorStates[$cscKey]['html_label'];
                if ($csc>1 && in_array($cscKey, $pluralKeys)) {
                    //$canonicStatesByExt[$cscKey]['label'] .= 's';
                    //$canonicStatesByExt[$cscKey]['html_label'] .= 's';
                    $canonicStates[$cscKey]['label'] .= 's';
                    $canonicStates[$cscKey]['html_label'] .= 's';
                    //$vendorStates[$cscKey]['label'] .= 's';
                    //$vendorStates[$cscKey]['html_label'] .= 's';
                }
            }
            $fgmpData = compact('canonicStatesByExt', 'canonicStatesCnt', 'canonicStatesPrice', 'canonicStates', 'vendorStates');

            $product->setData('FullGroupedMultipriceData', $fgmpData);
            $pcByState = @$fgmpData['canonicStatesPrice'];
            $pcByState = is_array($pcByState) ? $pcByState : [];
            $cntByState = @$fgmpData['canonicStatesCnt'];
            $cntByState = is_array($cntByState) ? $cntByState : [];
            $canonicStates = @$fgmpData['canonicStates'];
            $canonicStates = is_array($canonicStates) ? $canonicStates : [];
            $product->setData('PriceComparisonCanonicStates', $canonicStates);
            $product->setData('FullPriceComparisonByState', $pcByState);
            $product->setData('FullPriceComparisonByStateCnt', $pcByState);
            unset($pcByState['all']);
            unset($cntByState['all']);
            $product->setData('PriceComparisonByState', $pcByState);
            $product->setData('PriceComparisonByStateCnt', $cntByState);
        }
        return $this;
    }
    public function getCheckSql($expression, $true, $false)
    {
        if ($expression instanceof \Zend_Db_Expr || $expression instanceof Select) {
            $expression = sprintf("IF((%s), %s, %s)", $expression, $true, $false);
        } else {
            $expression = sprintf("IF(%s, %s, %s)", $expression, $true, $false);
        }
        return new \Zend_Db_Expr($expression);
    }
    public function getDatePartSql($date)
    {
        return new \Zend_Db_Expr(sprintf('DATE(%s)', $date));
    }
    protected $_indexerMap = [
        'Magento\Catalog\Model\ResourceModel\Product\Indexer\Price\DefaultPrice' => 'Unirgy\DropshipMultiPrice\Model\PriceIndexer\DefaultPrice',
        'Magento\Bundle\Model\ResourceModel\Indexer\Price' => 'Unirgy\DropshipMultiPrice\Model\PriceIndexer\Bundle',
        'Magento\GroupedProduct\Model\ResourceModel\Product\Indexer\Price\Grouped' => 'Unirgy\DropshipMultiPrice\Model\PriceIndexer\Grouped',
        'Magento\GroupedProduct\Model\ResourceModel\Product\Indexer\Price\GroupedInterface' => 'Unirgy\DropshipMultiPrice\Model\PriceIndexer\Grouped',
        'Magento\ConfigurableProduct\Model\ResourceModel\Product\Indexer\Price\Configurable' => 'Unirgy\DropshipMultiPrice\Model\PriceIndexer\Configurable',
        'Magento\Downloadable\Model\ResourceModel\Indexer\Price' => 'Unirgy\DropshipMultiPrice\Model\PriceIndexer\Downloadable',
        'Magento\GiftCard\Model\ResourceModel\Indexer\Price' => 'Unirgy\DropshipMultiPrice\Model\PriceIndexer\GiftCard'
    ];
    public function mapPriceIndexer($indexer)
    {
        $indexer = $indexer ?: 'Magento\Catalog\Model\ResourceModel\Product\Indexer\Price\DefaultPrice';
        $indexer = trim($indexer, '\\');
        return $this->_hlp->isUdmultiActive() && isset($this->_indexerMap[$indexer])
            ? $this->_indexerMap[$indexer]
            : $indexer;
    }
}
