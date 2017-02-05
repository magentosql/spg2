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

namespace Unirgy\DropshipPaypalAdaptive\Model;

use Magento\Framework\Api\AttributeValueFactory;
use Magento\Framework\Api\ExtensionAttributesFactory;
use Magento\Framework\App\Config\ScopeConfigInterface;
use Magento\Framework\App\ObjectManager;
use Magento\Framework\Data\Collection\AbstractDb;
use Magento\Framework\Model\Context;
use Magento\Framework\Model\ResourceModel\AbstractResource;
use Magento\Framework\Registry;
use Magento\Payment\Helper\Data as HelperData;
use Magento\Payment\Model\Info;
use Magento\Payment\Model\Method\AbstractMethod;
use Magento\Payment\Model\Method\Logger;
use Magento\Sales\Model\Order;
use Magento\Sales\Model\Order\Invoice;
use Magento\Sales\Model\Order\Payment\Transaction;
use Magento\Store\Model\ScopeInterface;
use Magento\Store\Model\StoreManagerInterface;
use Unirgy\DropshipPayout\Model\Payout;
use Unirgy\DropshipPaypalAdaptive\Helper\Data as DropshipPaypalAdaptiveHelperData;
use Unirgy\Dropship\Helper\Data as DropshipHelperData;
use Unirgy\Dropship\Helper\ProtectedCode as HelperProtectedCode;

class Adaptive extends AbstractMethod
{
    /**
     * @var DropshipHelperData
     */
    protected $_hlp;

    /**
     * @var HelperProtectedCode
     */
    protected $_hlpPr;

    /**
     * @var DropshipPaypalAdaptiveHelperData
     */
    protected $_adapHlp;

    /**
     * @var StoreManagerInterface
     */
    protected $_storeManager;

    protected $_orderNotifier;

    public function __construct(
        Context $context,
        Registry $registry, 
        ExtensionAttributesFactory $extensionFactory, 
        AttributeValueFactory $customAttributeFactory, 
        HelperData $paymentData, 
        ScopeConfigInterface $scopeConfig, 
        Logger $logger, 
        DropshipHelperData $helperData, 
        HelperProtectedCode $dropshipHelperProtectedCode,
        DropshipPaypalAdaptiveHelperData $dropshipPaypalAdaptiveHelperData,
        StoreManagerInterface $modelStoreManagerInterface,
        \Magento\Sales\Model\OrderNotifier $orderNotifier,
        AbstractResource $resource = null, 
        AbstractDb $resourceCollection = null, 
        array $data = [])
    {
        $this->_hlp = $helperData;
        $this->_hlpPr = $dropshipHelperProtectedCode;
        $this->_adapHlp = $dropshipPaypalAdaptiveHelperData;
        $this->_storeManager = $modelStoreManagerInterface;
        $this->_orderNotifier = $orderNotifier;

        parent::__construct($context, $registry, $extensionFactory, $customAttributeFactory, $paymentData, $scopeConfig, $logger, $resource, $resourceCollection, $data);
    }

    protected $_code  = Config::METHOD_UPADAPTIVE;
    protected $_formBlockType = '\Unirgy\DropshipPaypalAdaptive\Block\Form';
    protected $_infoBlockType = '\Unirgy\DropshipPaypalAdaptive\Block\Info';
    protected $_isInitializeNeeded      = true;
    protected $_canUseInternal          = false;
    protected $_canUseForMultishipping  = false;
    protected $_canFetchTransactionInfo = true;

    protected $_config = null;

    public function setInfoInstance(\Magento\Payment\Model\InfoInterface $info)
    {
        parent::setInfoInstance($info);
        if ($info && $info->getOrder() && $info->getOrder()->getStore()) {
            $this->setStore($info->getOrder()->getStoreId());
        }
        $this->getConfig();
        return $this;
    }

    public function canUseForCurrency($currencyCode)
    {
        return $this->getConfig()->isCurrencyCodeSupported($currencyCode);
    }

    public function getSession()
    {
        return ObjectManager::getInstance()->get('Magento\Paypal\Model\Session');
    }

    public function getCheckout()
    {
        return ObjectManager::getInstance()->get('Magento\Checkout\Model\Session');
    }

    public function getQuote()
    {
        return $this->getCheckout()->getQuote();
    }

    public function getOrderPlaceRedirectUrl()
    {
        return $this->_hlp->createObj('\Magento\Framework\Url')->getUrl('upadaptive/adaptive/redirect', ['_secure' => true]);
    }

    public function getPaypalRedirectUrl()
    {
        $url = 'https://www%s.paypal.com/cgi-bin/webscr?cmd=_ap-payment&paykey=%s';
        return sprintf($url, $this->isTestMode() ? '.sandbox' : '', $this->getInfoInstance()->getAdditionalInformation('upadative_pair_key'));
    }

    public function initialize($paymentAction, $stateObject)
    {
        $payment = $this->getInfoInstance();
        $order = $payment->getOrder();
        $state = Order::STATE_PENDING_PAYMENT;
        $stateObject->setState($state);
        $stateObject->setStatus('pending_payment');
        $stateObject->setIsNotified(false);

        $isParallel = $this->_scopeConfig->isSetFlag('payment/upadaptive/use_parallel', ScopeInterface::SCOPE_STORE);

        $order->setUdnosaveFlag(true);
        if ($this->_hlp->isUdpoActive()) {
            $pos = $this->_hlp->getObj('\Unirgy\DropshipPo\Helper\ProtectedCode')->splitOrderToPos($order);
        } else {
            $pos = $this->_hlpPr->splitOrderToShipments($order);
        }
        $order->setUdnosaveFlag(false);

        $__totalPayout = 0;
        $__payouts = [];
        foreach ($pos as $po) {
            if ($this->_hlp->isModulesActive('Unirgy_DropshipTierCommission')) {
                $this->_hlp->getObj('\Unirgy\DropshipTierCommission\Helper\Data')->processPo($po);
            }
            $__v = $this->_hlp->getVendor($po->getUdropshipVendor());
            if (!$isParallel && $__v->getPayoutMethod()!='paypal_adaptive') {
                continue;
            }
            $__payout = $this->_createPayout($__v);
            $__payout->setIsOnline(false);
            $__payout->addPo($po)->finishPayout();
            $__payouts[] = $__payout;
            $__ptTotal = $isParallel ? $__payout->getTotalPayment() : $__payout->getTotalPayout();
            $__totalPayout += round($__ptTotal, 2);
        }

        $orderBaseGrandTotal = round($order->getBaseGrandTotal(),2);
        $__payoutAdjInit = $orderBaseGrandTotal-$__totalPayout;

        if (($__payoutAdjInit<0 || $isParallel) && count($__payouts)>0) {
            $__payoutAdj = $__payoutAdjInit/count($__payouts);
            $__payoutAdj = round($__payoutAdj, 2);
            $__payoutAdjExt = $__payoutAdjInit-count($__payouts)*$__payoutAdj;
            foreach ($__payouts as $__payout) {
                $__payout->addAdjustment($__payoutAdj+$__payoutAdjExt, 'sync payout with order totals');
                $__payoutAdjExt = 0;
                $__payout->finishPayout();
            }
        }

        if (!$isParallel) {
            $ptReq['receiverList.receiver(0).email'] = $this->_config->getValue('businessAccount');
            $ptReq['receiverList.receiver(0).amount'] =  round($order->getBaseGrandTotal(),2);
            $ptReq['receiverList.receiver(0).primary'] =  'true';
        }
        $idx = $isParallel ? 0 : 1;
        $vIdIdx = [];
        foreach ($__payouts as $pt) {
            $pt->unsPayoutMethodError();
            $vId = $pt->getVendorId();
            $__due = $isParallel ? $pt->getPaymentDue() : $pt->getTotalDue();
            if ($__due<=0) {
                $pt->setPayoutMethodErrors(['Total Due must be greater than 0']);
            } else {
                if (!array_key_exists($vId, $vIdIdx)) {
                    $vIdIdx[$vId] = $idx;
                    $ptReq[sprintf('receiverList.receiver(%d).email', $idx)] = trim($pt->getVendor()->getPayoutPaypalEmail());
                    $ptReq[sprintf('receiverList.receiver(%d).amount', $idx)] = 0;
                    $idx++;
                }
                $ptReq[sprintf('receiverList.receiver(%d).amount', $vIdIdx[$vId])] += round($__due,2);
                $ptToPay[] = $pt->getId();
            }
        }

        if (empty($ptReq)) return;

        $ptReq['actionType'] = 'PAY';
        $ptReq['feesPayer'] = 'EACHRECEIVER'; // other values SECONDARYONLY, PRIMARYRECEIVER, SENDER, EACHRECEIVER
        $ptReq['currencyCode'] = $order->getBaseCurrencyCode();
        $ptReq['requestEnvelope.errorLanguage'] = 'en_US';
        $ptReq['returnUrl'] = $this->_hlp->createObj('\Magento\Framework\Url')->getUrl('upadaptive/adaptive/success', ['_secure' => true]);
        $ptReq['cancelUrl'] = $this->_hlp->createObj('\Magento\Framework\Url')->getUrl('upadaptive/adaptive/cancel', ['_secure' => true]);
        $ptReq['reverseAllParallelPaymentsOnError'] = 'true';

        $headers = [];
        $headers['X-PAYPAL-SECURITY-USERID'] = $this->_config->getValue('apiUsername');
        $headers['X-PAYPAL-SECURITY-PASSWORD'] = $this->_config->getValue('apiPassword');
        $headers['X-PAYPAL-SECURITY-SIGNATURE'] = $this->_config->getValue('apiSignature');
        $headers['X-PAYPAL-APPLICATION-ID'] = $this->_config->getValue('appid');
        $headers['X-PAYPAL-REQUEST-DATA-FORMAT'] = 'NV';
        $headers['X-PAYPAL-RESPONSE-DATA-FORMAT'] = 'NV';
        if ($this->isTestMode()) {
            $headers['X-PAYPAL-APPLICATION-ID'] = $this->_sandboxAppId;
        }

        $_response = $this->_postRequest($ptReq, $headers, 'Pay');
        $response = $_response->getResponseData();
        $rawResponse = $_response->getRawResponse();

        switch(strtolower($response->getData('responseEnvelope.ack'))) {
            case 'success':
            case 'successwithwarning':
                $this->getInfoInstance()->setAdditionalInformation('upadative_vendors', $vIdIdx);
                $this->getInfoInstance()->setAdditionalInformation('upadative_pair_key', $response->getData('payKey'));
                break;
            case 'failure':
            case 'failurewithwarning':
                $errArr = [];
                foreach ($response->getData() as $rkey=>$rVal) {
                    if (false===stripos($rkey, 'error') || false===stripos($rkey, 'message')) continue;
                    $errArr[] = sprintf('Error: %s', $rVal);
                }
                if (empty($errArr)) {
                    $errArr = ['Unknown Error'];
                }
                throw new \Exception(implode("\n", $errArr));
            default:
                $xml = @simplexml_load_string($rawResponse);
                if ($xml && isset($xml->error->message)) {
                    $errArr = [$xml->error->message];
                } else {
                    $errArr = ['Unknown Error'];
                }
                throw new \Exception(implode("\n", $errArr));
        }

    }

    public function fetchTransactionInfo(\Magento\Payment\Model\InfoInterface $payment, $transactionId)
    {
        return $this->_fetchTransactionInfo($payment, $transactionId, false);
    }

    protected  function _fetchTransactionInfo(\Magento\Payment\Model\InfoInterface $payment, $transactionId, $all=false)
    {
        $order = $payment->getOrder();
        $ptReq['payKey'] = $payment->getAdditionalInformation('upadative_pair_key');
        $ptReq['requestEnvelope.errorLanguage'] = 'en_US';

        $headers = [];
        $headers['X-PAYPAL-SECURITY-USERID'] = $this->_config->getValue('apiUsername');
        $headers['X-PAYPAL-SECURITY-PASSWORD'] = $this->_config->getValue('apiPassword');
        $headers['X-PAYPAL-SECURITY-SIGNATURE'] = $this->_config->getValue('apiSignature');
        $headers['X-PAYPAL-APPLICATION-ID'] = $this->_config->getValue('appid');
        $headers['X-PAYPAL-REQUEST-DATA-FORMAT'] = 'NV';
        $headers['X-PAYPAL-RESPONSE-DATA-FORMAT'] = 'NV';
        if ($this->isTestMode()) {
            $headers['X-PAYPAL-APPLICATION-ID'] = $this->_sandboxAppId;
        }

        $_response = $this->_postRequest($ptReq, $headers, 'PaymentDetails');
        $response = $_response->getResponseData();
        $rawResponse = $_response->getRawResponse();

        return $all ? $_response : $response->getData();
    }

    protected function _createPayout($__v)
    {
        return $this->_adapHlp->createPayout($__v, Payout::STATUS_PROCESSING, Payout::TYPE_AUTO, 'paypal_adaptive');
    }

    protected function _completePayment($order, $response)
    {
        $payment = $order->getPayment();
        if ($order->canInvoice()) {
            if ($this->_hlp->isUdpoActive()) {
                $this->_hlp->getObj('\Unirgy\DropshipPo\Helper\Data')->initOrderUdposCollection($order);
                $this->_hlp->getObj('\Unirgy\DropshipPo\Helper\ProtectedCode')->splitOrderToPos($order);
                $pos = $order->getUdposCollection();
            } else {
                $this->_hlpPr->splitOrderToShipments($order);
                $pos = $order->getShipmentsCollection();
            }

            $vIdIdx = $payment->getAdditionalInformation('upadative_vendors');
            $__totalPayout = 0;
            $__payouts = [];
            foreach ($pos as $udpo) {
                $__v = $this->_hlp->getVendor($udpo->getUdropshipVendor());
                $__payout = $this->_createPayout($__v);
                $__payout->setIsOnline(false);
                $__payout->addPo($udpo)->finishPayout();
                $__payouts[] = $__payout;
                $__totalPayout += $__payout->getTotalPayout();
            }

            $__payoutAdj = $order->getBaseGrandTotal()-$__totalPayout;

            if ($__payoutAdj<0 && count($__payouts)>0) {
                $__payoutAdj = $__payoutAdj/count($__payouts);
                foreach ($__payouts as $__payout) {
                    $__payout->addAdjustment($__payoutAdj, 'sync payout with order totals');
                    $__payout->finishPayout();
                }
            }

            $trans = $this->_hlp->transactionFactory()->create()
                ->addObject($order->setData('___dummy',1));
            if (count($__payouts)>0) {
                foreach ($__payouts as $__payout) {
                    $vId = $__payout->getVendorId();
                    $idx = $vIdIdx[$vId];
                    $__payout->setTransactionId($response->getData(sprintf('paymentInfoList.paymentInfo(%d).transactionId', $idx)));
                    $__payout->setTransactionStatus($response->getData(sprintf('paymentInfoList.paymentInfo(%d).transactionStatus', $idx)));
                    $__payout->setSenderTransactionId($response->getData(sprintf('paymentInfoList.paymentInfo(%d).senderTransactionId', $idx)));
                    $__payout->setSenderTransactionStatus($response->getData(sprintf('paymentInfoList.paymentInfo(%d).senderTransactionStatus', $idx)));
                    $__payout->setPaypalCorrelationId($response->getData('responseEnvelope.correlationId'));
                    $__payout->finishPayout();
                    $__payout->afterPay();
                    $trans->addObject($__payout);
                }
            }
            $trans->save();
            if (count($__payouts)>0) {
                $vPids = [];
                foreach ($__payouts as $__payout) {
                    $vPids[$__payout->getVendorId()] = $__payout->getId();
                }
                $order->setAdditionalInformation('upadative_payouts', $vPids);
            }

            $payment->setIsTransactionClosed(1);
            $payment->setTransactionId($response->getData('paymentInfoList.paymentInfo(0).transactionId'));
            $formatedPrice = $order->getBaseCurrency()->formatTxt($order->getBaseGrandTotal());
            $txnMsg = __('Paid amount of %1.', $formatedPrice);
            $payment->addTransaction(Transaction::TYPE_PAYMENT, null, false, $txnMsg);

            $invoice = $this->_hlp->getObj('\Magento\Sales\Model\Service\InvoiceService')->prepareInvoice($order);

            $invoice->getOrder()->getPayment()->unsParentTransactionId();
            $invoice->getOrder()->getPayment()->unsTransactionId();
            $invoice->getOrder()->getPayment()->unsIsTransactionClosed();

            $invoice->setRequestedCaptureCase(Invoice::CAPTURE_OFFLINE);

            $invoice->register();
            $invoice->getOrder()->setIsInProcess(true);

            if (!$order->getEmailSent()) {
                $this->_orderNotifier->notify($order);
            }

            if (in_array($order->getState(), [Order::STATE_NEW, Order::STATE_PENDING_PAYMENT ])) {
                $order->setState(Order::STATE_PROCESSING, true);
            }

            $order->setData('__dummy',1)->save();

        }
    }

    public function processReturn($order, $responseData=array())
    {
        if (empty($responseData)) {
            $_response = $this->_fetchTransactionInfo($order->getPayment(), $order->getPayment()->getAdditionalInformation('upadative_pair_key'), true);
            $response = $_response->getResponseData();
            $rawResponse = $_response->getRawResponse();
        } else {
            $response = new Varien_Object($responseData);
            $rawResponse = '';
        }
        switch(strtolower($response->getData('status'))) {
            case 'completed':
                $this->_completePayment($order, $response);
                break;
            case 'failure':
            case 'failurewithwarning':
                $errArr = [];
                foreach ($response->getData() as $rkey=>$rVal) {
                    if (false===stripos($rkey, 'error') || false===stripos($rkey, 'message')) continue;
                    $errArr[] = sprintf('Error: %s', $rVal);
                }
                if (empty($errArr)) {
                    $errArr = ['Unknown Error'];
                }
                throw new \Exception(implode("\n", $errArr));
            default:
                $xml = @simplexml_load_string($rawResponse);
                if ($xml && isset($xml->error->message)) {
                    $errArr = [$xml->error->message];
                } else {
                    $errArr = ['Unknown Error'];
                }
                throw new \Exception(implode("\n", $errArr));
        }
    }

    public function getConfig()
    {
        if (null === $this->_config) {
            $params = [$this->_code];
            if ($store = $this->getStore()) {
                $params[] = is_object($store) ? $store->getId() : $store;
            }
            $this->_config = ObjectManager::getInstance()->create('Unirgy\DropshipPaypalAdaptive\Model\Config', ['params'=>$params]);
        }
        return $this->_config;
    }
    public function isAvailable(\Magento\Quote\Api\Data\CartInterface $quote = null)
    {
        if (parent::isAvailable($quote)/* && $this->getConfig()->isMethodAvailable()*/) {
            return true;
        }
        return false;
    }
    public function getConfigData($field, $storeId = null)
    {
        $value = null;
        switch ($field) {
            case 'order_place_redirect_url':
                $value = $this->getOrderPlaceRedirectUrl();
                break;
            default:
                $value = $this->getConfig()->getValue($field, $storeId);
        }
        return $value;
    }
    private function _getAggregatedCartSummary()
    {
        if ($this->_config->getValue('lineItemsSummary')) {
            return $this->_config->getValue('lineItemsSummary');
        }
        return $this->_storeManager->getStore($this->getStore())->getFrontendName();
    }

    public function isTestMode()
    {
        return $this->_config->getValue('sandboxFlag');
    }
    protected $_sandboxAppId = 'APP-80W284485P519543T';
    public function getApiEndpoint($call)
    {
        $url = 'https://svcs%s.paypal.com/AdaptivePayments/'.$call;
        return sprintf($url, $this->isTestMode() ? '.sandbox' : '');
    }
    protected $_logFile = 'payment_upadaptive.log';
    public function logFile()
    {
        return $this->_logFile;
    }

    protected function _postRequest($request, $headers, $call)
    {
        return $this->_adapHlp->postRequest($request, $headers, $call, $this);
    }
}
