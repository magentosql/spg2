<?php

namespace Unirgy\DropshipMulti\Model;

class SkipProductFactory extends \Magento\Catalog\Model\ProductFactory
{
    public function create(array $data = array())
    {
        $product = parent::create($data);
        $_multiHlp = \Magento\Framework\App\ObjectManager::getInstance()->get('\Unirgy\DropshipMulti\Helper\Data');
        $_multiHlp->skipProductObject($product);
        return $product;
    }
}