<?php

namespace Unirgy\DropshipMulti\Model\ResourceModel;

class SkipProductCollectionFactory extends \Magento\Catalog\Model\ResourceModel\Product\CollectionFactory
{
    public function create(array $data = array())
    {
        $collection = parent::create($data);
        $collection->setFlag('skip_udmulti_load',1);
        return $collection;
    }
}