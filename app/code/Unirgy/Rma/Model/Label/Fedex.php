<?php

namespace Unirgy\Rma\Model\Label;

use Magento\CatalogInventory\Api\StockRegistryInterface;
use Magento\Catalog\Model\ResourceModel\Product\CollectionFactory;
use Magento\Directory\Helper\Data as HelperData;
use Magento\Directory\Model\CountryFactory;
use Magento\Directory\Model\CurrencyFactory;
use Magento\Directory\Model\RegionFactory;
use Magento\Framework\App\Config\ScopeConfigInterface;
use Magento\Framework\DataObject;
use Magento\Framework\Module\Dir\Reader;
use Magento\Framework\Xml\Security;
use Magento\Quote\Model\Quote\Address\RateResult\ErrorFactory;
use Magento\Quote\Model\Quote\Address\RateResult\MethodFactory;
use Magento\Shipping\Model\Rate\ResultFactory;
use Magento\Shipping\Model\Simplexml\ElementFactory;
use Magento\Shipping\Model\Tracking\ResultFactory as TrackingResultFactory;
use Magento\Shipping\Model\Tracking\Result\ErrorFactory as ResultErrorFactory;
use Magento\Shipping\Model\Tracking\Result\StatusFactory;
use Magento\Store\Model\StoreManagerInterface;
use Psr\Log\LoggerInterface;
use Unirgy\Dropship\Helper\Data as DropshipHelperData;
use Unirgy\Dropship\Model\Label\Fedex as LabelFedex;
use Unirgy\Dropship\Model\Source;

class Fedex extends LabelFedex
{
    public function requestRma($track)
    {
        $hlp = $this->_hlp;
        $this->_track = $track;

        $this->_rma = $this->_track->getRma();
        $this->_order = $this->_rma->getOrder();
        $orderId = $this->_order->getIncrementId();

        $poId = $this->_rma->getIncrementId();

        $this->_reference = $this->_track->getReference() ? $this->_track->getReference() : $orderId;

        $this->_address = $this->_order->getShippingAddress();
        $store = $this->_order->getStore();
        $currencyCode = $this->_order->getBaseCurrencyCode();
        $v = $this->getVendor();

        $skus = [];
        foreach ($this->getMpsRequest('items') as $_item) {
            $item = is_array($_item) ? $_item['item'] : $_item;
            $skus[] = $item->getSku();
        }

        $fedexData = [];
        foreach ([
            'fedex_dropoff_type',
            'fedex_signature_option',
        ] as $fedexKey) {
            $fedexData[$fedexKey] = $track->hasData($fedexKey) ? $track->getData($fedexKey) : $v->getData($fedexKey);
        }
        $fedexData = new DataObject($fedexData);

        $weight = $this->_track->getWeight();
        if (!$weight) {
            $weight = 0;
            foreach ($this->getMpsRequest('items') as $_item) {
                $item = $_item['item'];
                $_weight = (!empty($_item['weight']) ? $_item['weight'] : $item->getWeight());
                $_qty = (!empty($_item['qty']) ? $_item['qty'] : $item->getQty());
                $weight += $_weight*$_qty;
            }
        }

        $value = $this->_track->getValue();
        if (!$value) {
            $value = 0;
            foreach ($this->getMpsRequest('items') as $_item) {
                $item = $_item['item'];
                $value += ($item->getBasePrice() ? $item->getBasePrice() : $item->getPrice())*$item->getQty();
            }
        }
        $weight = sprintf("%.2f", max($weight, 1/16));
        $totalWeight = $this->_track->getTotalWeight();
        if (!$totalWeight) {
            $totalWeight = $weight;
        }

        $length = $this->_track->getLength() ? $this->_track->getLength() : $v->getDefaultPkgLength();
        $width = $this->_track->getWidth() ? $this->_track->getWidth() : $v->getDefaultPkgWidth();
        $height = $this->_track->getHeight() ? $this->_track->getHeight() : $v->getDefaultPkgHeight();

        $a = $this->_address;

        if (($shippingMethod = $this->_rma->getUdropshipMethod())) {
            $arr = explode('_', $shippingMethod, 2);
            $carrierCode = $arr[0];
            $methodCode = $arr[1];
        } else {
            $ship = explode('_', $this->_order->getShippingMethod(), 2);
            $carrierCode = $ship[0];
            $methodCode = $v->getShippingMethodCode($ship[1]);
        }

        $isFedexSoap = true;

        if ($carrierCode=='fedexsoap') {
            $services = $hlp->getCarrierMethods('fedexsoap');
        } else {
            $services = $hlp->getCarrierMethods('fedex');
        }
#echo "<pre>"; print_r($services); echo "</pre>".$methodCode;
        if (!$isFedexSoap && (empty($services[$methodCode]) || empty($this->_codeUnderscore[$methodCode]))
            || $isFedexSoap && (empty($services[$methodCode]) || false === array_search($methodCode, $this->_codeUnderscore))
        ) {
            throw new \Exception('Invalid shipping method');
        }

        if (!$isFedexSoap) {
            $serviceCode = $this->_codeUnderscore[$methodCode];
        } else {
            $serviceCode = $methodCode;
        }

        $shipment = [
            'ShipTimestamp' => date('c', $this->_hlp->getNextWorkDayTime()),
            'DropoffType' => $fedexData->getFedexDropoffType(),//'REGULAR_PICKUP', // REGULAR_PICKUP, REQUEST_COURIER, DROP_BOX, BUSINESS_SERVICE_CENTER and STATION
            'ServiceType' => $serviceCode,//'PRIORITY_OVERNIGHT', // STANDARD_OVERNIGHT, PRIORITY_OVERNIGHT, FEDEX_GROUND, ...
            // Express US: PRIORITY_OVERNIGHT, STANDARD_OVERNIGHT, FEDEX_2_DAY, FEDEX_EXPRESS_SAVER, FIRST_OVERNIGHT
            'PackagingType' => 'YOUR_PACKAGING', // FEDEX_BOX, FEDEX_PAK, FEDEX_TUBE, YOUR_PACKAGING, ...
            // Express US: FEDEX_BOX, FEDEX_ENVELOPE, FEDEX_PAK, FEDEX_TUBE, YOUR_PACKAGING
            'TotalWeight' => ['Value' => $totalWeight, 'Units' => 'LB'], // LB and KG
            'Shipper' => [
                'Contact' => [
                    'PersonName' => $a->getName(),
                    'CompanyName' => $a->getCompany(),
                    'PhoneNumber' => $a->getTelephone(),
                ],
                'Address' => [
                    'StreetLines' => [$a->getStreetLine(1), $a->getStreetLine(2)],
                    'City' => $a->getCity(),
                    'StateOrProvinceCode' => $a->getRegionCode(),
                    'PostalCode' => $a->getPostcode(),
                    'CountryCode' => $a->getCountryId(),
                    'Residential' => $this->isRmaResidentialDelivery($v, $track),
                ],
            ],
            'Recipient' => [
                'Contact' => [
                    'PersonName' => $v->getVendorAttn(),
                    'CompanyName' => $v->getVendorName(),
                    'PhoneNumber' => $v->getTelephone(),
                ],
                'Address' => [
                    'StreetLines' => [$v->getStreet(1), $v->getStreet(2)],
                    'City' => $v->getCity(),
                    'StateOrProvinceCode' => $v->getRegionCode(),
                    'PostalCode' => $v->getZip(),
                    'CountryCode' => $v->getCountryId(),
                ],
            ],
            'ShippingChargesPayment' => [
                'PaymentType' => 'SENDER', // RECIPIENT, SENDER and THIRD_PARTY
                'Payor' => [
                    'AccountNumber' => $v->getFedexAccountNumber(),
                    'CountryCode' => $v->getCountryId(),
                ]
            ],
            'RateRequestTypes' => ['ACCOUNT'], // ACCOUNT and LIST
            'PackageCount' => $this->getUdropshipPackageCount() ? $this->getUdropshipPackageCount() : 1,
            'RequestedPackages' => [
                '0' => [
                    'SequenceNumber' => $this->getUdropshipPackageIdx() ? $this->getUdropshipPackageIdx() : 1,
                    'Weight' => ['Value' => $weight, 'Units' => 'LB'], // LB and KG
                    'Dimensions' => [
                        'Length' => $length,
                        'Width' => $width,
                        'Height' => $height,
                        'Units' => $v->getDimensionUnits(),// valid values IN or CM
                    ],
                    'CustomerReferences' => [
                        '0' => ['CustomerReferenceType' => 'CUSTOMER_REFERENCE', 'Value' => $this->_reference],
                        '1' => ['CustomerReferenceType' => 'INVOICE_NUMBER', 'Value' => $orderId],
                        '2' => ['CustomerReferenceType' => 'P_O_NUMBER', 'Value' => $poId]
                    ],// CUSTOMER_REFERENCE, INVOICE_NUMBER, P_O_NUMBER, SHIPMENT_INTEGRITY, STORE_NUMBER, BILL_OF_LADING
                ]
            ],
            'LabelSpecification' => [
                'LabelFormatType' => 'COMMON2D', // COMMON2D, LABEL_DATA_ONLY
                'ImageType' => $v->getLabelType()=='EPL' ? 'EPL2' : 'PNG',  // DPL, EPL2, PDF, ZPLII and PNG
                'LabelStockType' => $v->getFedexLabelStockType(),
                'LabelPrintingOrientation' => $v->getPdfLabelRotate()==180 ? 'BOTTOM_EDGE_OF_TEXT_FIRST': 'TOP_EDGE_OF_TEXT_FIRST',
            ],
        ];
        if ($v->getFedexInsurance()) {
            $shipment['RequestedPackages']['0']['InsuredValue'] = ['Amount' => $value, 'Currency' => $currencyCode];
        }
        if ($fedexData->getFedexSignatureOption()!='NO_SIGNATURE_REQUIRED') {
            $shipment['PackageSpecialServicesRequested']['SpecialServiceTypes'][] = 'SIGNATURE_OPTION';
            $shipment['PackageSpecialServicesRequested']['SignatureOptionDetail'] = [
                'OptionType' => $fedexData->getFedexSignatureOption(),
                //'SignatureReleaseNumber' => '',
            ];
        }
        if ($v->getFedexDryIceWeight()!=0){
            $shipment['RequestedPackages']['0']['SpecialServicesRequested']['SpecialServiceTypes'] = ['DRY_ICE'];
            $shipment['RequestedPackages']['0']['SpecialServicesRequested']['DryIceWeight']['Units'] = 'KG';
            $shipment['RequestedPackages']['0']['SpecialServicesRequested']['DryIceWeight']['Value'] = $v->getFedexDryIceWeight();
        }

        if (false) {
            $shipment['LabelSpecification']['CustomLabelDetail'] = [
                'TextEntries' => [
                    '0' => [
                        'Position' => ['X'=>1, 'Y'=>1],
                        'Format' => '...',
                        'ThermalFontID' => 1 // 1..23
                    ],
                ],
                'GraphicEntries' => [
                    '0' => [
                        'Position' => ['X'=>1, 'Y'=>1],
                        'PrinterGraphicID' => '/sdfg/sdfg.png',
                    ],
                ],
            ];
        }
        if (false) {
            $shipment['SpecialServicesRequested'] = [
                'SpecialServiceTypes' => ['COD'],
                'CodDetail' => ['CollectionType' => 'ANY'], // ANY, GUARANTEED_FUNDS
                'CodCollectionAmount' => ['Amount' => 150, 'Currency' => 'USD']
            ];
        }

        if ($this->hasUdropshipMasterTrackingId()) {
            $shipment['MasterTrackingId'] = ['TrackingNumber' => $this->getUdropshipMasterTrackingId()];
        }

        if ($a->getCountryId()!=$v->getCountryId()) {
            $shipment['InternationalDetail'] = [
                'DutiesPayment' => [
                    'PaymentType' => 'SENDER', // RECIPIENT, SENDER and THIRD_PARTY
                    'Payor' => [
                        'AccountNumber' => $v->getFedexAccountNumber(),
                        'CountryCode' => $v->getCountryId(),
                    ]
                ],
                'DocumentContent' => 'NON_DOCUMENTS', //or 'DOCUMENTS_ONLY',
                'CustomsValue' => ['Amount' => $value, 'Currency' => $currencyCode],
            ];
            if ($v->getFedexITN()) {
                $shipment['InternationalDetail']['ExportDetail']['ExportComplianceStatement'] = $v->getFedexItn();
            }
            $i = 0;
            foreach ($this->getMpsRequest('items') as $_item) {
                $item = $_item['item'];
                $itemPrice = $item->getBasePrice() ? $item->getBasePrice() : $item->getPrice();
                $_weight = (!empty($_item['weight']) ? $_item['weight'] : $item->getWeight());
                $_qty = (!empty($_item['qty']) ? $_item['qty'] : $item->getQty());
                $shipment['InternationalDetail']['Commodities'][(string)$i++] = [
                    'NumberOfPieces' => 1,
                    'Description' => $item->getName(),
                    'CountryOfManufacture' => $v->getCountryId(),
                    'Weight' => ['Value' => $_weight, 'Units' => 'LB'],
                    'Quantity' => $_qty,
                    'QuantityUnits' => 'EA',
                    'UnitPrice' => ['Amount' => $itemPrice, 'Currency' => $currencyCode],
                    'CustomsValue' => ['Amount' => $itemPrice*$_qty, 'Currency' => $currencyCode]
                ];
            }
        }

        $nEmailsValid = $this->getValidNotifyEmails($v);
        $nTypesValid = $this->getValidNotifyTypes($v);

        if (!empty($nEmailsValid) && !empty($nTypesValid)) {
            $shipment['SpecialServicesRequested']['SpecialServiceTypes'] = 'EMAIL_NOTIFICATION';
            $neIdx = 0; foreach ($nEmailsValid as $_nEmail) {
                //$neIdx = (string)$neIdx;
                $shipment['SpecialServicesRequested']['EMailNotificationDetail']['Recipients'][$neIdx]['EMailNotificationRecipientType'] = 'OTHER';
                $shipment['SpecialServicesRequested']['EMailNotificationDetail']['Recipients'][$neIdx]['Localization']['LanguageCode'] = 'en';
                $shipment['SpecialServicesRequested']['EMailNotificationDetail']['Recipients'][$neIdx]['EMailAddress'] = $_nEmail;
                $shipment['SpecialServicesRequested']['EMailNotificationDetail']['Recipients'][$neIdx]['Format'] = 'TEXT';
                foreach ($nTypesValid as $_nType) {
                    if ($_nType == 'shipment') {
                        $shipment['SpecialServicesRequested']['EMailNotificationDetail']['Recipients'][$neIdx]['NotifyOnShipment'] = true;
                    } elseif ($_nType == 'exception') {
                        $shipment['SpecialServicesRequested']['EMailNotificationDetail']['Recipients'][$neIdx]['NotifyOnException'] = true;
                    } elseif ($_nType == 'delivery') {
                        $shipment['SpecialServicesRequested']['EMailNotificationDetail']['Recipients'][$neIdx]['NotifyOnDelivery'] = true;
                    }
                }
                if (++$neIdx>=6) break;
            }
        }

        $request = [
            'WebAuthenticationDetail' => [
                'UserCredential' => [
                    'Key' => $v->getFedexUserKey(),
                    'Password' => $v->getFedexUserPassword(),
                ]
            ],
            'ClientDetail' => [
                'AccountNumber' => $v->getFedexAccountNumber(),
                'MeterNumber' => $v->getFedexMeterNumber(),
            ],
            'TransactionDetail' => [
                'CustomerTransactionId' => '*** Express Domestic Shipping Request v6 using PHP ***'
            ],
            'Version' => ['ServiceId' => 'ship', 'Major' => '6', 'Intermediate' => '0', 'Minor' => '0'],
            'RequestedShipment' => $shipment,
        ];

        $client = $this->getSoapClient($v, 'ship');

        $response = $client->processShipment($request);

        if (isset($response->CompletedShipmentDetail->MasterTrackingId->TrackingNumber)) {
            $this->setUdropshipMasterTrackingId($response->CompletedShipmentDetail->MasterTrackingId->TrackingNumber);
        }

        /*
        $this->_hlp->dump('REQUEST', 'fedex_return_label');
        $this->_hlp->dump($client->__getLastRequest(), 'fedex_return_label');
        $this->_hlp->dump('RESPONSE', 'fedex_return_label');
        $this->_hlp->dump($client->__getLastResponse(), 'fedex_return_label');
        */

        if ($response->HighestSeverity == 'FAILURE' || $response->HighestSeverity == 'ERROR') {
            $errors = [];
            if (is_array($response->Notifications)) {
                foreach ($response->Notifications as $notification) {
                    $errors[] = $notification->Severity . ': ' . $notification->Message;
                }
            } else {
                $errors[] = $response->Notifications->Severity . ': ' . $response->Notifications->Message;
            }
            throw new \Exception(join(', ', $errors));
        }

        $track->setCarrierCode($carrierCode);
        $track->setTitle($this->_hlp->getScopeConfig('carriers/'.$carrierCode.'/title', $store));
        $track->setTrackNumber($response->CompletedShipmentDetail->CompletedPackageDetails->TrackingId->TrackingNumber);
        $track->setMasterTrackingId($this->getUdropshipMasterTrackingId());
        $track->setPackageCount($this->getUdropshipPackageCount() ? $this->getUdropshipPackageCount() : 1);
        $track->setPackageIdx($this->getUdropshipPackageIdx() ? $this->getUdropshipPackageIdx() : 1);

        if (isset($response->CompletedShipmentDetail)
            && isset($response->CompletedShipmentDetail->ShipmentRating)
        ) {
            $shipmentRateDetails = $response->CompletedShipmentDetail->ShipmentRating->ShipmentRateDetails;
            $finalPrice = null;
            if (is_array($shipmentRateDetails)) {
                $rates = [];
                foreach ($shipmentRateDetails as $details) {
                    $rates[$details->RateType] = $details->TotalNetCharge->Amount;
                }
                if (isset($rates['RATED_ACCOUNT'])) {
                    $finalPrice = $rates['RATED_ACCOUNT'];
                } elseif (isset($rates['PAYOR_ACCOUNT'])) {
                    $finalPrice = $rates['RATED_ACCOUNT'];
                } else {
                    $finalPrice = current($rates);
                }
            } else {
                $finalPrice = $shipmentRateDetails->TotalNetCharge->Amount;
            }
            $track->setFinalPrice($finalPrice);
        }
        //$track->setResultExtra(serialize($extra));

        $labelImages = [
            base64_encode($response->CompletedShipmentDetail->CompletedPackageDetails->Label->Parts->Image),
            //$response->CompletedShipmentDetail->CodReturnDetail->Label->Parts->Image,
        ];

        $labelModel = $this->_hlp->getLabelTypeInstance($v->getLabelType());
        $labelModel->setVendor($v)->updateTrack($track, $labelImages);
        return $this;
    }

    public function isRmaResidentialDelivery($v, $track)
    {
        $residential = $v->getFedexResidential();
        $sAddr = $track->getRma()->getOrder()->getShippingAddress();
        if ($sAddr->getIsCommercial()) {
            $residential = false;
        } elseif ($sAddr->getIsResidential()) {
            $residential = true;
        }
        return $residential;
    }
}