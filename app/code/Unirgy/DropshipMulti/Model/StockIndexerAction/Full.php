<?php

namespace Unirgy\DropshipMulti\Model\StockIndexerAction;

use Magento\Framework\App\ResourceConnection;

class Full extends \Magento\CatalogInventory\Model\Indexer\Stock\Action\Full
{
    public function __construct(
        \Unirgy\DropshipMulti\Helper\Data $udmultiHelper,
        ResourceConnection $resource,
        \Magento\CatalogInventory\Model\ResourceModel\Indexer\StockFactory $indexerFactory,
        \Magento\Catalog\Model\Product\Type $catalogProductType,
        \Magento\Framework\Indexer\CacheContext $cacheContext,
        \Magento\Framework\Event\ManagerInterface $eventManager
    ) {
        $this->_multiHlp = $udmultiHelper;
        parent::__construct($resource, $indexerFactory, $catalogProductType, $cacheContext, $eventManager);
    }
    protected function _getTypeIndexers()
    {
        if (empty($this->_indexers)) {
            foreach ($this->_catalogProductType->getTypesByPriority() as $typeId => $typeInfo) {
                $indexerClassName = isset($typeInfo['stock_indexer']) ? $typeInfo['stock_indexer'] : '';

                $indexer = $this->_indexerFactory->create($this->_multiHlp->mapStockIndexer($indexerClassName))
                    ->setTypeId($typeId)
                    ->setIsComposite(!empty($typeInfo['composite']));

                $this->_indexers[$typeId] = $indexer;
            }
        }
        return $this->_indexers;
    }
}