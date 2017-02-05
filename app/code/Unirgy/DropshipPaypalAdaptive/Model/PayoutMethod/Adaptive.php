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

namespace Unirgy\DropshipPaypalAdaptive\Model\PayoutMethod;

use Magento\Framework\App\Config\ScopeConfigInterface;
use Magento\Store\Model\ScopeInterface;
use Magento\Store\Model\StoreManagerInterface;
use Unirgy\DropshipPayout\Model\Method\MethodInterface;
use Unirgy\DropshipPaypalAdaptive\Helper\Data as HelperData;
use Unirgy\Dropship\Model\Vendor\Statement\StatementInterface;

class Adaptive implements MethodInterface
{
    /**
     * @var ScopeConfigInterface
     */
    protected $_scopeConfig;

    /**
     * @var StoreManagerInterface
     */
    protected $_storeManager;

    /**
     * @var HelperData
     */
    protected $_adapHlp;
    protected $_hlp;

    public function __construct(
        ScopeConfigInterface $configScopeConfigInterface,
        StoreManagerInterface $modelStoreManagerInterface,
        HelperData $helperData,
        \Unirgy\Dropship\Helper\Data $udropshipHelper
    )
    {
        $this->_scopeConfig = $configScopeConfigInterface;
        $this->_storeManager = $modelStoreManagerInterface;
        $this->_adapHlp = $helperData;
        $this->_hlp = $udropshipHelper;
    }

    protected $_hasExtraInfo=true;
    public function hasExtraInfo($payout)
    {
        return $this->_hasExtraInfo;
    }
    protected $_isOnline=true;
    public function isOnline($flag=null)
    {
        $result = $this->_isOnline;
        if ($flag!==null) {
            $this->_isOnline = (bool)$flag;
        }
        return $result;
    }
    public function isTestMode()
    {
        return $this->_scopeConfig->getValue('udropship/payout_paypal/test_mode', ScopeInterface::SCOPE_STORE);
    }
    protected $_sandboxAppId = 'APP-80W284485P519543T';
    public function getApiEndpoint($call)
    {
        $url = 'https://svcs%s.paypal.com/AdaptivePayments/'.$call;
        return sprintf($url, $this->isTestMode() ? '.sandbox' : '');
    }
    protected $_logFile = 'payout_upadaptive.log';
    public function logFile()
    {
        return $this->_logFile;
    }

    protected function _generateUniqueId()
    {
        $unq = sha1(uniqid(microtime(), true));
        return substr($unq, 0, 15).substr($unq, 25);
    }
    
    public function pay($payout)
    {
        if ($payout instanceof StatementInterface) {
            $payout = [$payout];
        }

        $ptReq = [];
        $ptToPay = [];
        $idx = 0;
        $vIdIdx = [];
        foreach ($payout as $pt) {
            if (!$pt->getIsOnline() && $pt->getIsOnline()!==null) continue;
            $pt->unsPayoutMethodError();
            $vId = $pt->getVendorId();
            if ($pt->getTotalDue()<=0) {
                $pt->setPayoutMethodErrors(['Total Due must be greater than 0']);
            } else {
                if (!array_key_exists($vId, $vIdIdx)) {
                    $vIdIdx[$vId] = $idx;
                    $ptReq[sprintf('receiverList.receiver(%d).email', $idx)] = trim($pt->getVendor()->getPayoutPaypalEmail());
                    $ptReq[sprintf('receiverList.receiver(%d).amount', $idx)] = 0;
                    $idx++;
                }
                $ptReq[sprintf('receiverList.receiver(%d).amount', $vIdIdx[$vId])] += $pt->getTotalDue();
                $ptToPay[] = $pt->getId();
            }
        }

        if (empty($ptReq)) return;

        $ptReq['actionType'] = 'PAY';
        $ptReq['senderEmail'] = $this->_scopeConfig->getValue('udropship/payout_paypal/subject', ScopeInterface::SCOPE_STORE);
        //$ptReq['sender.accountId'] = $this->_configScopeConfigInterface->getValue('udropship/payout_paypal/merchantid', ScopeInterface::SCOPE_STORE);
        $ptReq['currencyCode'] = $this->_storeManager->getStore()->getBaseCurrencyCode();
        $ptReq['requestEnvelope.errorLanguage'] = 'en_US';
        $ptReq['returnUrl'] = $this->_hlp->createObj('\Magento\Framework\Url')->getUrl('upadaptive/adaptive/dummy', ['_secure' => true]);
        $ptReq['cancelUrl'] = $this->_hlp->createObj('\Magento\Framework\Url')->getUrl('upadaptive/adaptive/dummy', ['_secure' => true]);
        $ptReq['reverseAllParallelPaymentsOnError'] = 'true';

        $headers = [];
        $headers['X-PAYPAL-SECURITY-USERID'] = $this->_scopeConfig->getValue('udropship/payout_paypal/username', ScopeInterface::SCOPE_STORE);
        $headers['X-PAYPAL-SECURITY-PASSWORD'] = $this->_scopeConfig->getValue('udropship/payout_paypal/password', ScopeInterface::SCOPE_STORE);
        $headers['X-PAYPAL-SECURITY-SIGNATURE'] = $this->_scopeConfig->getValue('udropship/payout_paypal/signature', ScopeInterface::SCOPE_STORE);
        $headers['X-PAYPAL-APPLICATION-ID'] = $this->_scopeConfig->getValue('udropship/payout_paypal/appid', ScopeInterface::SCOPE_STORE);
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
                foreach ($payout as $pt) {
                    if (in_array($pt->getId(), $ptToPay)) {
                        $vId = $pt->getVendorId();
                        $idx = $vIdIdx[$vId];
                        $pt->setTransactionId($response->getData(sprintf('paymentInfoList.paymentInfo(%d).transactionId', $idx)));
                        $pt->setTransactionStatus($response->getData(sprintf('paymentInfoList.paymentInfo(%d).transactionStatus', $idx)));
                        $pt->setSenderTransactionId($response->getData(sprintf('paymentInfoList.paymentInfo(%d).senderTransactionId', $idx)));
                        $pt->setSenderTransactionStatus($response->getData(sprintf('paymentInfoList.paymentInfo(%d).senderTransactionStatus', $idx)));
                        $pt->setPaypalCorrelationId($response->getData('responseEnvelope.correlationId'));
                        $pt->afterPay();
                    }
                }
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
                foreach ($payout as $pt) {
                    if (in_array($pt->getId(), $ptToPay)) {
                        $pt->setPayoutMethodErrors($errArr);
                    }
                }
                throw new \Exception(implode("\n", $errArr));
            default:
                $xml = @simplexml_load_string($rawResponse);
                if ($xml && isset($xml->error->message)) {
                    $errArr = [$xml->error->message];
                } else {
                    $errArr = ['Unknown Error'];
                }
                foreach ($payout as $pt) {
                    if (in_array($pt->getId(), $ptToPay)) {
                        $pt->setPayoutMethodErrors($errArr);
                    }
                }
                throw new \Exception(implode("\n", $errArr));
        }

    }

    protected function _postRequest($request, $headers, $call)
    {
        return $this->_adapHlp->postRequest($request, $headers, $call, $this);
    }

    public function getExtraInfo($payout)
    {
        return sprintf('TRANSACTION STATUS: %s
SENDER TRANSACTION ID: %s
SENDER TRANSACTION STATUS: %s
', $payout->getTransactionStatus(), $payout->getSenderTransactionId(), $payout->getSenderTransactionStatus());
    }

    public function getExtraInfoHtml($payout)
    {
        return sprintf('<nobr>TRANSACTION STATUS: %s</nobr><br />
<nobr>SENDER TRANSACTION ID: %s</nobr><br />
<nobr>SENDER TRANSACTION STATUS: %s</nobr><br />', $payout->getTransactionStatus(), $payout->getSenderTransactionId(), $payout->getSenderTransactionStatus());
    }

}
