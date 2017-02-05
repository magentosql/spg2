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
 
namespace Unirgy\DropshipPaypalAdaptive\Helper;

use Magento\Framework\App\Helper\AbstractHelper;
use Magento\Framework\App\Helper\Context;
use Magento\Framework\DataObject;
use Unirgy\DropshipPayout\Model\PayoutFactory;
use Unirgy\Dropship\Helper\Data as HelperData;
use Unirgy\Dropship\Model\Vendor;

class Data extends AbstractHelper
{
    /**
     * @var HelperData
     */
    protected $_hlp;

    /**
     * @var PayoutFactory
     */
    protected $_modelPayoutFactory;

    public function __construct(Context $context, 
        HelperData $helperData, 
        PayoutFactory $modelPayoutFactory)
    {
        $this->_hlp = $helperData;
        $this->_modelPayoutFactory = $modelPayoutFactory;

        parent::__construct($context);
    }

    public function createPayout($vendor, $status='pending', $payoutType=null, $payoutMethod=null)
    {
        if (!$vendor instanceof Vendor) {
            $vendor = $this->_hlp->getVendor($vendor);
        }
        $payout = $this->_modelPayoutFactory->create()->addData([
            'payout_type' => !is_null($payoutType) ? $payoutType : $vendor->getPayoutType(),
            'payout_method' => !is_null($payoutMethod) ? $payoutMethod : $vendor->getPayoutMethod(),
            'payout_status' => $status,
            'vendor_id' => $vendor->getId(),
            'po_type' => $vendor->getStatementPoType()
        ]);
        return $payout->initTotals();
    }
    protected $_sandboxAppId = 'APP-80W284485P519543T';
    public function getApiEndpoint($call, $isTest)
    {
        $url = 'https://svcs%s.paypal.com/AdaptivePayments/'.$call;
        return sprintf($url, $isTest ? '.sandbox' : '');
    }
    public function postRequest($request, $headers, $call, $method)
    {
        $strPOST = '';
        foreach ($request AS $key => $value) {
            $strPOST .= $key.'='.urlencode($value).'&';
        }
        $strPOST = stripslashes($strPOST);
        $cHeaders = [];
        foreach ($headers as $hKey=>$hVal) {
            $cHeaders[] = $hKey.': ' . $hVal;
        }

        $callUrl = $method->getApiEndpoint($call);

        $cpt = curl_init();
        curl_setopt($cpt, CURLOPT_URL, $callUrl);
        if (!$method->isTestMode()) {
            curl_setopt($cpt, CURLOPT_SSL_VERIFYHOST, 2);
        } else {
            curl_setopt($cpt, CURLOPT_SSL_VERIFYHOST, false);
        }
        curl_setopt($cpt, CURLOPT_RETURNTRANSFER, 1);
        curl_setopt($cpt, CURLOPT_SSL_VERIFYPEER, FALSE);
        curl_setopt($cpt, CURLOPT_POST, 1);
        curl_setopt($cpt, CURLOPT_POSTFIELDS, $strPOST);
        curl_setopt($cpt, CURLOPT_HTTPHEADER, $cHeaders);

        $curlResult = curl_exec($cpt);
        $curlerror = curl_error($cpt);
        $curlinfo = curl_getinfo($cpt);
        curl_close($cpt);

        $r_arr=explode("&",$curlResult);
        foreach($r_arr AS $buf)
        {
            $temp=urldecode($buf);
            $temp=explode("=",$temp,2);
            $postatt=@$temp[0];
            $postvar=@$temp[1];
            $returnvalue[$postatt]=$postvar;
        }

        $this->_hlp->dump('REQUEST', $method->logFile());
        $this->_hlp->dump($callUrl, $method->logFile());
        $this->_hlp->dump($headers, $method->logFile());
        $this->_hlp->dump($strPOST, $method->logFile());
        $this->_hlp->dump($request, $method->logFile());

        $this->_hlp->dump('RESPONSE', $method->logFile());
        $this->_hlp->dump($curlResult, $method->logFile());
        $this->_hlp->dump($returnvalue, $method->logFile());
        //$this->_helperData->dump($curlerror, $method->logFile());
        //$this->_helperData->dump($curlinfo, $method->logFile());

        $response = new DataObject(['response_data'=>new DataObject($returnvalue), 'raw_response'=>$curlResult]);
        return $response;
    }
}
