<?php

namespace Unirgy\DropshipMulti\Plugin;

class Category
{
    public function afterGetProductCollection(\Magento\Catalog\Model\Category $subject, $result)
    {
        $_multiHlp = \Magento\Framework\App\ObjectManager::getInstance()->get('\Unirgy\DropshipMulti\Helper\Data');
        if ($_multiHlp->isSkipCategoryObject($subject)) {
            $result->setFlag('skip_udmulti_load',1);
        }
        return $result;
    }
}