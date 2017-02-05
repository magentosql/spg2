<?php

namespace Unirgy\Rma\Controller\Order;

use Magento\Framework\App\ObjectManager;
use Magento\Framework\Registry;
use Magento\Sales\Model\OrderFactory;
use Unirgy\Dropship\Helper\Data as DropshipHelperData;
use Unirgy\Rma\Helper\Data as HelperData;
use Unirgy\Rma\Model\RmaFactory;

abstract class AbstractOrder extends \Magento\Sales\Controller\AbstractController\View
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

    public function __construct(
        RmaFactory $rmaFactory,
        OrderFactory $orderFactory,
        Registry $registry,
        HelperData $urmaHelper,
        DropshipHelperData $udropshipHelper,
        \Magento\Framework\App\Action\Context $context,
        \Magento\Sales\Controller\AbstractController\OrderLoaderInterface $orderLoader,
        \Magento\Framework\View\Result\PageFactory $resultPageFactory
    )
    {
        $this->_rmaFactory = $rmaFactory;
        $this->_orderFactory = $orderFactory;
        $this->_coreRegistry = $registry;
        $this->_rmaHlp = $urmaHelper;
        $this->_hlp = $udropshipHelper;
        parent::__construct($context, $orderLoader, $resultPageFactory);
    }

    protected function _initRma($forSave=false)
    {
        $rma = false;
        $rmaId = $this->getRequest()->getParam('rma_id');
        $orderId = $this->getRequest()->getParam('order_id');
        if ($rmaId) {
            $rma = $this->_rmaFactory->create()->load($rmaId);
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
            $rma->setIsCutomer(true);
            $trans->addObject($rma);
        }
        $trans->addObject($rma->getOrder())->save();

        foreach ($rmas as $rma) {
            $rma->sendEmail(!empty($data['send_email']), $comment);
            $this->_rmaHlp->sendNewRmaNotificationEmail($rma, $comment);
        }
    }
    public function execute()
    {
        $result = $this->orderLoader->load($this->_request);
        if ($result instanceof \Magento\Framework\Controller\ResultInterface) {
            return $result;
        }

        /** @var \Magento\Framework\View\Result\Page $resultPage */
        $resultPage = $this->resultPageFactory->create();
        $resultPage->getLayout()->initMessages();

        /** @var \Magento\Framework\View\Element\Html\Links $navigationBlock */
        $navigationBlock = $resultPage->getLayout()->getBlock('customer_account_navigation');
        if ($navigationBlock) {
            $navigationBlock->setActive('sales/order/history');
        }
        return $resultPage;
    }
}