<?php

namespace Unirgy\DropshipPaypalAdaptive\Controller\Adaptive;

use Magento\Framework\App\Action\Context;
use Magento\Framework\App\ObjectManager;
use Magento\Quote\Model\QuoteFactory;
use Magento\Sales\Model\OrderFactory;
use Psr\Log\LoggerInterface;

class Success extends AbstractAdaptive
{
    /**
     * @var LoggerInterface
     */
    protected $_logger;

    public function __construct(Context $context, 
        OrderFactory $modelOrderFactory, 
        QuoteFactory $modelQuoteFactory, 
        LoggerInterface $logLoggerInterface)
    {
        $this->_logger = $logLoggerInterface;

        parent::__construct($context, $modelOrderFactory, $modelQuoteFactory);
    }

    public function  execute()
    {
        $session = ObjectManager::getInstance()->get('Magento\Checkout\Model\Session');
        $session->setQuoteId($session->getUpadaptiveQuoteId(true));
        $orderId = $session->getUpadaptiveOrderId(true);
        $order = null;
        if ($session->getLastRealOrderId()) {
            $order = $this->_orderFactory->create()->loadByIncrementId($session->getLastRealOrderId());
        }
        try {
            if ($order && $order->getId() && $orderId) {
                $method = $order->getPayment()->getMethodInstance();
                $method->setStore($order->getStoreId());
                $method->processReturn($order);
                ObjectManager::getInstance()->get('Magento\Checkout\Model\Session')->getQuote()->setIsActive(false)->save();
                $this->_redirect('checkout/onepage/success', ['_secure'=>true]);
            } elseif ($order && $order->getId()) {
                $this->_redirect('checkout/onepage/success', ['_secure'=>true]);
            } else {
                $this->_redirect('checkout/cart');
            }
        } catch (\Exception $e) {
            $this->_logger->error($e);
            $this->messageManager->addError(__('There was error during payment finalization.'));
            if ($order->getId()) {
                $order->cancel()->save();
            }
            $this->_restoreQuote();
            $this->_redirect('checkout/cart');
        }
    }
}
