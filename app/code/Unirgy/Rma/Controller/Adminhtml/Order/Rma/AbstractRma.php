<?php

namespace Unirgy\Rma\Controller\Adminhtml\Order\Rma;

use Magento\Backend\App\Action;
use Magento\Backend\App\Action\Context;
use Magento\Framework\App\ObjectManager;
use Magento\Framework\Registry;
use Magento\Sales\Model\OrderFactory;
use Unirgy\Dropship\Helper\Data as DropshipHelperData;
use Unirgy\Rma\Helper\Data as HelperData;
use Unirgy\Rma\Model\RmaFactory;

abstract class AbstractRma extends Action
{
    /**
     * @var RmaFactory
     */
    protected $_rmaFactory;

    /**
     * @var OrderFactory
     */
    protected $_orderFactory;

    /**
     * @var Registry
     */
    protected $_coreRegistry;

    /**
     * @var HelperData
     */
    protected $_rmaHlp;

    /**
     * @var DropshipHelperData
     */
    protected $_hlp;

    protected $resultPageFactory;
    protected $_resultRawFactory;
    protected $resultForwardFactory;
    protected $_resultRedirectFactory;

    public function __construct(Context $context, 
        RmaFactory $modelRmaFactory, 
        OrderFactory $modelOrderFactory, 
        Registry $frameworkRegistry, 
        HelperData $helperData,
        DropshipHelperData $dropshipHelperData,
        \Magento\Backend\Model\View\Result\ForwardFactory $resultForwardFactory,
        \Magento\Framework\View\Result\PageFactory $resultPageFactory,
        \Magento\Framework\Controller\Result\RedirectFactory $resultRedirectFactory,
        \Magento\Framework\Controller\Result\RawFactory $resultRawFactory
    )
    {
        $this->_rmaFactory = $modelRmaFactory;
        $this->_orderFactory = $modelOrderFactory;
        $this->_coreRegistry = $frameworkRegistry;
        $this->_rmaHlp = $helperData;
        $this->_hlp = $dropshipHelperData;
        $this->resultForwardFactory = $resultForwardFactory;
        $this->resultPageFactory = $resultPageFactory;
        $this->_resultRedirectFactory = $resultRedirectFactory;
        $this->_resultRawFactory = $resultRawFactory;

        parent::__construct($context);
    }

    protected function _getItemQtys()
    {
        $data = $this->getRequest()->getParam('urma');
        if (isset($data['items'])) {
            $qtys = $data['items'];
        } else {
            $qtys = [];
        }
        return $qtys;
    }

    protected function _initRma($forSave=true)
    {
        $rma = false;
        $rmaId = $this->getRequest()->getParam('rma_id');
        $orderId = $this->getRequest()->getParam('order_id');
        if ($rmaId) {
            $rma = $this->_rmaFactory->create()->load($rmaId);
            if (!$rma->getId()) {
                throw new \Exception(__('This Return no longer exists.'));
            }
        } elseif ($orderId) {
            $order      = $this->_orderFactory->create()->load($orderId);

            if (!$order->getId()) {
                throw new \Exception(__('The order no longer exists.'));
            }

            $data = $this->getRequest()->getParam('rma');
            if (isset($data['items'])) {
                $qtys = $data['items'];
            } else {
                $qtys = [];
            }
            if (isset($data['items_condition'])) {
                $conditions = $data['items_condition'];
            } else {
                $conditions = [];
            }

            if ($forSave) {
                $rma = $this->_hlp->createObj('Unirgy\Rma\Model\ServiceOrder', ['order'=>$order])->prepareRmaForSave($qtys, $conditions);
            } else {
                $rma = $this->_hlp->createObj('Unirgy\Rma\Model\ServiceOrder', ['order'=>$order])->prepareRma($qtys);
            }

        }

        $this->_coreRegistry->register('current_rma', $rma);
        if (!empty($rma)) {
            if ($forSave) {
                reset($rma);
                $_rma = current($rma);
                $this->_coreRegistry->register('current_order', $_rma->getOrder());
            } else {
                $this->_coreRegistry->register('current_order', $rma->getOrder());
            }
        }

        return $rma;
    }

    protected function _saveRma()
    {
        $rmas = $this->_initRma(true);
        $data = $this->getRequest()->getPost('rma');
        $data['send_email'] = true;
        $comment = '';

        if (empty($rmas)) {
            throw new \Exception('Return could not be created');
        }

        /** @var \Magento\Backend\Model\Auth $auth */
        $auth = $this->_hlp->getObj('\Magento\Backend\Model\Auth');
        $adminUser = $auth->getUser();

        foreach ($rmas as $rma) {
            $order = $rma->getOrder();
            $rma->register();
        }

        if (!empty($data['comment_text'])) {
            foreach ($rmas as $rma) {
                $rma->addComment($data['comment_text'], true, true);
            }
            $comment = $data['comment_text'];
        }

        if (!empty($data['send_email'])) {
            foreach ($rmas as $rma) {
                $rma->setEmailSent(true);
            }
        }
        $rma->setRmaReason(@$data['rma_reason']);

        $order->setCustomerNoteNotify(!empty($data['send_email']));
        $order->setIsInProcess(true);
        $trans = $this->_hlp->transactionFactory()->create();
        foreach ($rmas as $rma) {
            $rma->setIsAdmin(true);
            $rma->setUsername($adminUser->getUsername());
            $trans->addObject($rma);
        }
        $trans->addObject($rma->getOrder())->save();

        foreach ($rmas as $rma) {
            $rma->sendEmail(!empty($data['send_email']), $comment);
            $this->_rmaHlp->sendNewRmaNotificationEmail($rma, $comment);
        }

        return $rmas;
    }

    protected function _isAllowed()
    {
        return $this->_authorization->isAllowed('Unirgy_Rma::urma')
        && (
            !in_array($this->getRequest()->getActionName(), ['new', 'save'])
            || $this->_authorization->isAllowed('Unirgy_Rma::action_urma')
        );
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
