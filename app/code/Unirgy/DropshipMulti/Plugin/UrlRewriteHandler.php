<?php

namespace Unirgy\DropshipMulti\Plugin;
use Magento\CatalogUrlRewrite\Observer\UrlRewriteHandler as CatalogUrlRewriteHandler;
use Magento\Catalog\Model\Category as CatalogCategory;

class UrlRewriteHandler
{
    public function beforeGetCategoryProductsUrlRewrites(CatalogUrlRewriteHandler $subject, CatalogCategory $category, $storeId, $saveRewriteHistory)
    {
        $_multiHlp = \Magento\Framework\App\ObjectManager::getInstance()->get('\Unirgy\DropshipMulti\Helper\Data');
        $_multiHlp->skipCategoryObject($category);
    }
}