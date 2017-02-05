<?php

namespace Unirgy\DropshipPaypalAdaptive\Controller\Adaptive;

use Magento\Framework\App\Action\Context;
use Magento\Framework\App\ObjectManager;
use Magento\Quote\Model\QuoteFactory;
use Magento\Sales\Model\OrderFactory;

class Redirect extends AbstractAdaptive
{
    public function execute()
    {
        $session = ObjectManager::getInstance()->get('Magento\Checkout\Model\Session');
        $session->setUpadaptiveQuoteId($session->getQuoteId());
        $session->setUpadaptiveOrderId($session->getLastOrderId());
        $orderId = $session->getLastOrderId();
        $order = $this->_orderFactory->create()->load($orderId);
        $method = $order->getPayment()->getMethodInstance();
        $method->setStore($order->getStoreId());
        $redirectUrl = $method->getPaypalRedirectUrl();
        $session->unsQuoteId();
        $session->unsRedirectUrl();
        return $this->_response->setRedirect($redirectUrl);
    }
}
