<?php

namespace Unirgy\Rma\Controller\Tracking;

use Magento\Framework\App\Action\Context;
use Magento\Framework\Controller\Result\RawFactory;
use Unirgy\Rma\Model\RmaFactory;

class Ajax extends AbstractTracking
{
    /**
     * @var RawFactory
     */
    protected $_resultRawFactory;

    public function __construct(Context $context, 
        RmaFactory $modelRmaFactory, 
        RawFactory $resultRawFactory)
    {
        $this->_resultRawFactory = $resultRawFactory;

        parent::__construct($context, $modelRmaFactory);
    }

    public function execute()
    {
        if ($rma = $this->_initRma()) {
            $response = '';
            $tracks = $rma->getTracksCollection();

            $className = Mage::getConfig()->getBlockClassName('core/template');
            $block = new $className();
            $block->setType('core/template')
                ->setIsAnonymous(true)
                ->setTemplate('sales/order/trackinginfo.phtml');

            foreach ($tracks as $track){
                $trackingInfo = $track->getNumberDetail();
                $block->setTrackingInfo($trackingInfo);
                $response .= $block->toHtml()."\n<br />";
            }

            $this->_resultRawFactory->create()->setContents($response);
        }
    }
}
