<?php

namespace Unirgy\Rma\Model\ResourceModel\Rma;

use Magento\Framework\DB\Adapter\AdapterInterface;
use Magento\Framework\Data\Collection\Db\FetchStrategyInterface;
use Magento\Framework\Data\Collection\EntityFactoryInterface;
use Magento\Framework\Event\ManagerInterface;
use Magento\Framework\Model\ResourceModel\Db\AbstractDb;
use Magento\Framework\Model\ResourceModel\Db\VersionControl\Snapshot;
use Magento\Sales\Model\OrderFactory;
use Magento\Sales\Model\ResourceModel\Order\Collection\AbstractCollection;
use Psr\Log\LoggerInterface;

class Collection extends AbstractCollection
{
    /**
     * @var OrderFactory
     */
    protected $_modelOrderFactory;

    public function __construct(EntityFactoryInterface $entityFactory, 
        LoggerInterface $logger, 
        FetchStrategyInterface $fetchStrategy, 
        ManagerInterface $eventManager, 
        Snapshot $entitySnapshot, 
        OrderFactory $modelOrderFactory, 
        AdapterInterface $connection = null, 
        AbstractDb $resource = null)
    {
        $this->_modelOrderFactory = $modelOrderFactory;

        parent::__construct($entityFactory, $logger, $fetchStrategy, $eventManager, $entitySnapshot, $connection, $resource);
    }

    protected $_eventPrefix = 'urma_rma_collection';
    protected $_eventObject = 'rma_collection';
    protected $_orderField = 'main_table.order_id';

    protected function _construct()
    {
        $this->_init('Unirgy\Rma\Model\Rma', 'Unirgy\Rma\Model\ResourceModel\Rma');
    }

    protected function _afterLoad()
    {
        $this->walk('afterLoad');
    }
    
    public function addOrders()
    {
        $this->addAttributeToSelect('order_id', 'inner');

        $orderIds = [];
        foreach ($this as $rma) {
            if ($rma->getOrderId()) {
                $orderIds[$rma->getOrderId()] = 1;
            }
        }

        if ($orderIds) {
            $orders = $this->_modelOrderFactory->create()->getCollection()
                ->addAttributeToSelect('*')
                ->addAttributeToFilter('entity_id', ['in'=>array_keys($orderIds)]);
            foreach ($this as $rma) {
                $rma->setOrder($orders->getItemById($rma->getOrderId()));
            }
        }
        return $this;
    }
}
