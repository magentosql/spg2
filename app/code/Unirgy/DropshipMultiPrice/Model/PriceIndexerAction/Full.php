<?php

namespace Unirgy\DropshipMultiPrice\Model\PriceIndexerAction;

class Full extends \Magento\Catalog\Model\Indexer\Product\Price\Action\Full
{
    public function getTypeIndexers()
    {
        if ($this->_indexers === null) {
            $_multiPriceHlp = \Magento\Framework\App\ObjectManager::getInstance()->get('\Unirgy\DropshipMultiPrice\Helper\Data');
            $this->_indexers = [];
            $types = $this->_catalogProductType->getTypesByPriority();
            foreach ($types as $typeId => $typeInfo) {
                $modelName = isset(
                    $typeInfo['price_indexer']
                ) ? $typeInfo['price_indexer'] : get_class($this->_defaultIndexerResource);

                $isComposite = !empty($typeInfo['composite']);

                $modelName = $_multiPriceHlp->mapPriceIndexer($modelName);

                $indexer = $this->_indexerPriceFactory->create(
                    $modelName
                )->setTypeId(
                    $typeId
                )->setIsComposite(
                    $isComposite
                );
                $this->_indexers[$typeId] = $indexer;
            }
        }

        return $this->_indexers;
    }
}
