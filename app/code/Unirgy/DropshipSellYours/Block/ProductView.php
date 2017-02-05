<?php

namespace Unirgy\DropshipSellYours\Block;

use Magento\Catalog\Api\ProductRepositoryInterface;
use Magento\Catalog\Block\Product\AbstractProduct;
use Magento\Catalog\Block\Product\Context;
use Magento\Catalog\Block\Product\View;
use Magento\Catalog\Helper\Product;
use Magento\Catalog\Model\ProductTypes\ConfigInterface;
use Magento\Customer\Model\Session;
use Magento\Framework\App\ObjectManager;
use Magento\Framework\Json\EncoderInterface as JsonEncoderInterface;
use Magento\Framework\Locale\FormatInterface;
use Magento\Framework\Pricing\PriceCurrencyInterface;
use Magento\Framework\Registry;
use Magento\Framework\Stdlib\StringUtils;
use Magento\Framework\Url\EncoderInterface;
use Magento\Framework\View\LayoutFactory;
use Unirgy\Dropship\Helper\Catalog;

class ProductView extends View
{
    /**
     * @var Catalog
     */
    protected $_helperCatalog;

    public function __construct(Context $context, 
        EncoderInterface $urlEncoder, 
        JsonEncoderInterface $jsonEncoder, 
        StringUtils $string, 
        Product $productHelper, 
        ConfigInterface $productTypeConfig, 
        FormatInterface $localeFormat, 
        Session $customerSession, 
        ProductRepositoryInterface $productRepository, 
        PriceCurrencyInterface $priceCurrency, 
        Catalog $helperCatalog,
        array $data = [])
    {
        $this->_helperCatalog = $helperCatalog;

        parent::__construct($context, $urlEncoder, $jsonEncoder, $string, $productHelper, $productTypeConfig, $localeFormat, $customerSession, $productRepository, $priceCurrency, $data);
    }

    protected function _prepareLayout()
    {
        if ($breadcrumbsBlock = $this->getLayout()->getBlock('breadcrumbs')) {
            $product = $this->getProduct();
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
            if ($this->_coreRegistry->registry('current_category')) {
                $cat = $this->_coreRegistry->registry('current_category');
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
            $breadcrumbsBlock->addCrumb('sellyours_query', [
                'label'=>htmlspecialchars($product->getName()),
                'title'=>htmlspecialchars($product->getName()),
                'link'=>$this->getUrl('*/*/*', ['_current'=>true])
            ]);
        }

        return AbstractProduct::_prepareLayout();
    }
}