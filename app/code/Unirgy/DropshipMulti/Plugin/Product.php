<?php

namespace Unirgy\DropshipMulti\Plugin;

class Product
{
    public function afterGetCollection(\Magento\Catalog\Model\Product $subject, $result)
    {
        $_multiHlp = \Magento\Framework\App\ObjectManager::getInstance()->get('\Unirgy\DropshipMulti\Helper\Data');
        if ($_multiHlp->isSkipProductObject($subject)) {
            $result->setFlag('skip_udmulti_load',1);
        }
        return $result;
    }
}