<?php

namespace Unirgy\Rma\Controller\Tracking;

use Magento\Framework\App\Action\Context;
use Magento\Framework\Registry;
use Unirgy\Rma\Model\RmaFactory;
use Unirgy\Rma\Model\ShippingInfoFactory;
use Magento\Framework\Exception\NotFoundException;

class Popup extends AbstractTracking
{
    /**
     * @var ShippingInfoFactory
     */
    protected $_shippingInfoFactory;

    /**
     * @var Registry
     */
    protected $_coreRegistry;

    public function __construct(Context $context, 
        RmaFactory $modelRmaFactory,
        ShippingInfoFactory $shippingInfoFactory,
        Registry $frameworkRegistry)
    {
        $this->_shippingInfoFactory = $shippingInfoFactory;
        $this->_coreRegistry = $frameworkRegistry;

        parent::__construct($context, $modelRmaFactory);
    }

    /**
     * Popup action
     * Shows tracking info if it's present, otherwise redirects to 404
     */
    public function execute()
    {
        $shippingInfoModel = $this->_shippingInfoFactory->create()->loadByHash($this->getRequest()->getParam('hash'));
        $this->_coreRegistry->register('current_shipping_info', $shippingInfoModel);
        if (count($shippingInfoModel->getTrackingInfo()) == 0) {
            throw new NotFoundException(__('Page not found.'));
        }
        $this->_view->loadLayout();
        $this->_view->getPage()->getConfig()->getTitle()->set(__('Tracking Information'));
        $this->_view->renderLayout();
    }
}
