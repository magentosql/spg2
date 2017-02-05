<?php

namespace Unirgy\Rma\Controller\Adminhtml\Rma;

use Magento\Backend\App\Action;
use Magento\Backend\App\Action\Context;
use Unirgy\Rma\Helper\Data as HelperData;

abstract class AbstractRma extends Action
{
    protected $_rmaHlp;
    protected $_hlp;
    protected $resultForwardFactory;
    protected $resultPageFactory;
    protected $_resultRedirectFactory;
    protected $_fileFactory;

    public function __construct(
        \Unirgy\Rma\Helper\Data $urmaHelper,
        \Unirgy\Dropship\Helper\Data $udropshipHelper,
        \Magento\Backend\Model\View\Result\ForwardFactory $resultForwardFactory,
        \Magento\Framework\View\Result\PageFactory $resultPageFactory,
        \Magento\Framework\Controller\Result\RedirectFactory $resultRedirectFactory,
        \Magento\Framework\App\Response\Http\FileFactory $fileFactory,
        \Magento\Backend\App\Action\Context $context
    )
    {
        $this->_rmaHlp = $urmaHelper;
        $this->_hlp = $udropshipHelper;
        $this->resultForwardFactory = $resultForwardFactory;
        $this->resultPageFactory = $resultPageFactory;
        $this->_resultRedirectFactory = $resultRedirectFactory;
        $this->_fileFactory = $fileFactory;

        parent::__construct($context);
    }


    protected function _construct()
    {
        $this->setUsedModuleName('Unirgy_Rma');
    }

    protected function _prepareRmaPdf($udpos)
    {
        foreach ($udpos as $udpo) {
            $order = $udpo->getOrder();
            $order->setData('__orig_shipping_amount', $order->getShippingAmount());
            $order->setData('__orig_base_shipping_amount', $order->getBaseShippingAmount());
            $order->setShippingAmount($udpo->getShippingAmount());
            $order->setBaseShippingAmount($udpo->getBaseShippingAmount());
        }
        $pdf = $this->_rmaHlp->getVendorPoMultiPdf($udpos);
        foreach ($udpos as $udpo) {
            $order = $udpo->getOrder();
            $order->setShippingAmount($order->getData('__orig_shipping_amount'));
            $order->setBaseShippingAmount($order->getData('__orig_base_shipping_amount'));
        }
        return $pdf;
    }


    protected function _isAllowed()
    {
        return $this->_authorization->isAllowed('Unirgy_Rma::urma');
    }

    protected function _initAction()
    {
        /** @var \Magento\Backend\Model\View\Result\Page $resultPage */
        $resultPage = $this->resultPageFactory->create();
        $resultPage->setActiveMenu('Unirgy_Rma::urma');
        $resultPage->getConfig()->getTitle()->prepend(__('Returns'));
        $resultPage->addBreadcrumb(__('Sales'), __('Sales'));
        $resultPage->addBreadcrumb(__('Dropship'), __('Dropship'));
        $resultPage->addBreadcrumb(__('Returns'), __('Returns'));
        return $resultPage;
    }


}