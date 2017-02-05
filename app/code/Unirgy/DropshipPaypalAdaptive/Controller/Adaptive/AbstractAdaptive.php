<?php
/**
 * Unirgy LLC
 *
 * NOTICE OF LICENSE
 *
 * This source file is subject to the EULA
 * that is bundled with this package in the file LICENSE.txt.
 * It is also available through the world-wide-web at this URL:
 * http://www.unirgy.com/LICENSE-M1.txt
 *
 * @category   Unirgy
 * @package    Unirgy_DropshipPaypalAdaptive
 * @copyright  Copyright (c) 2008-2009 Unirgy LLC (http://www.unirgy.com)
 * @license    http:///www.unirgy.com/LICENSE-M1.txt
 */

namespace Unirgy\DropshipPaypalAdaptive\Controller\Adaptive;

use Magento\Framework\App\Action\Action;
use Magento\Framework\App\Action\Context;
use Magento\Framework\App\ObjectManager;
use Magento\Quote\Model\QuoteFactory;
use Magento\Sales\Model\OrderFactory;

abstract class AbstractAdaptive extends Action
{
    /**
     * @var OrderFactory
     */
    protected $_orderFactory;

    /**
     * @var QuoteFactory
     */
    protected $_quoteFactory;

    public function __construct(Context $context, 
        OrderFactory $modelOrderFactory, 
        QuoteFactory $modelQuoteFactory)
    {
        $this->_orderFactory = $modelOrderFactory;
        $this->_quoteFactory = $modelQuoteFactory;

        parent::__construct($context);
    }

    protected $_order;
    public function getOrder()
    {
        if ($this->_order == null) {
        }
        return $this->_order;
    }


    protected function _expireAjax()
    {
        if (!ObjectManager::getInstance()->get('Magento\Checkout\Model\Session')->getQuote()->hasItems()) {
            $this->getResponse()->setHeader('HTTP/1.1','403 Session Expired');
            exit;
        }
    }

    protected function _restoreQuote()
    {
        $orderId = $this->_getCheckoutSession()->getLastRealOrderId();
        $order = $this->_orderFactory->create()->loadByIncrementId($orderId);
        if ($order->getId()) {
            $quote = $this->_getQuote($order->getQuoteId());
            if ($quote->getId()) {
                $quote->setIsActive(1)
                    ->setReservedOrderId(null)
                    ->save();
                $this->_getCheckoutSession()
                    ->replaceQuote($quote)
                    ->unsLastRealOrderId();
                return true;
            }
        }
        return false;
    }
    protected function _getCheckoutSession()
    {
        return ObjectManager::getInstance()->get('Magento\Checkout\Model\Session');
    }
    protected function _getQuote($quoteId)
    {
        return $this->_quoteFactory->create()->load($quoteId);
    }
}
