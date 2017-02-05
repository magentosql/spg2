<?php

namespace Unirgy\DropshipMultiPrice\Block;

use Magento\Catalog\Block\Product\View\Description;

class ProductVendors extends Description
{
    public function addToParentGroup($groupName)
    {
        if ($this->getParentBlock()) {
            $this->getParentBlock()->addToChildGroup($groupName, $this);
        }
        return $this;
    }
    public function getProductDefaultQty($product = null)
    {
        if (!$product) {
            $product = $this->getProduct();
        }

        $qty = $this->getMinimalQty($product);
        $config = $product->getPreconfiguredValues();
        $configQty = $config->getQty();
        if ($configQty > $qty) {
            $qty = $configQty;
        }

        return $qty;
    }
    public function getMinimalQty($product)
    {
        /** @var \Magento\CatalogInventory\Api\StockRegistryInterface $stockRegistry */
        $stockRegistry = \Magento\Framework\App\ObjectManager::getInstance()->get('\Magento\CatalogInventory\Api\StockRegistryInterface');
        $stockItem = $stockRegistry->getStockItem($product->getId());
        if ($stockItem) {
            return ($stockItem->getMinSaleQty()
            && $stockItem->getMinSaleQty() > 0 ? $stockItem->getMinSaleQty() * 1 : null);
        }
        return null;
    }
}