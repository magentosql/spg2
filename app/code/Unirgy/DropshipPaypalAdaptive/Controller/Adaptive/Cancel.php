<?php

namespace Unirgy\DropshipPaypalAdaptive\Controller\Adaptive;

use Magento\Framework\App\Action\Context;
use Magento\Framework\App\ObjectManager;
use Magento\Quote\Model\QuoteFactory;
use Magento\Sales\Model\OrderFactory;

class Cancel extends AbstractAdaptive
{
    public function execute()
    {
        $session = ObjectManager::getInstance()->get('Magento\Checkout\Model\Session');
        $session->setQuoteId($session->getUpadaptiveQuoteId(true));
        if ($session->getLastRealOrderId()) {
            $order = $this->_orderFactory->create()->loadByIncrementId($session->getLastRealOrderId());
            if ($order->getId()) {
                $order->cancel()->save();
            }
            $this->_restoreQuote();
        }
        $this->_redirect('checkout/cart');
    }
}
