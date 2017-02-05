<?php

namespace Unirgy\DropshipSellYours\Block\Product;

use Magento\Catalog\Block\Product\ListProduct as ProductListProduct;

class ListProduct extends ProductListProduct
{
    protected function _prepareLayout()
    {
        if ($this->_coreRegistry->registry('current_category')) {
            $this->setCategoryId($this->_coreRegistry->registry('current_category')->getId());
        }
        return parent::_prepareLayout();
    }
    protected function _getProductCollection()
    {
        $collection = parent::_getProductCollection();
        $collection->setFlag('has_stock_status_filter', 1);
        return $collection;
    }
}