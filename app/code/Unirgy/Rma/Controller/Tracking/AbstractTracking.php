<?php

namespace Unirgy\Rma\Controller\Tracking;

use Magento\Framework\App\Action\Action;
use Magento\Framework\App\Action\Context;
use Magento\Sales\Model\Order;
use Unirgy\Rma\Model\RmaFactory;

abstract class AbstractTracking extends Action
{
    /**
     * @var RmaFactory
     */
    protected $_modelRmaFactory;

    public function __construct(Context $context, 
        RmaFactory $modelRmaFactory)
    {
        $this->_modelRmaFactory = $modelRmaFactory;

        parent::__construct($context);
    }




    /**
     * Initialize order model instance
     *
     * @return Order || false
     */
    protected function _initRma()
    {
        $id = $this->getRequest()->getParam('rma_id');

        $rma = $this->_modelRmaFactory->create()->load($id);

        return $rma;
    }
}
