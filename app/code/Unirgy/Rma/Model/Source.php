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
 * @package    Unirgy_RMA
 * @copyright  Copyright (c) 2008-2009 Unirgy LLC (http://www.unirgy.com)
 * @license    http:///www.unirgy.com/LICENSE-M1.txt
 */

namespace Unirgy\Rma\Model;

use Unirgy\Dropship\Helper\Data as HelperData;
use Unirgy\Dropship\Model\Source\AbstractSource;
use Unirgy\Rma\Helper\Data as RmaHelperData;

class Source extends AbstractSource
{
    /**
     * @var HelperData
     */
    protected $_hlp;

    /**
     * @var RmaHelperData
     */
    protected $_rmaHlp;

    public function __construct(
        HelperData $helperData, 
        RmaHelperData $rmaHelperData,
        array $data = []
    )
    {
        $this->_hlp = $helperData;
        $this->_rmaHlp = $rmaHelperData;

        parent::__construct($data);
    }


    public function toOptionHash($selector=false)
    {
        $hlp = $this->_hlp;

        $options = [];

        switch ($this->getPath()) {

        case 'rma_status':
            $options = $this->_rmaHlp->getStatusTitles();
            break;
        case 'rma_reason':
            $options = $this->_rmaHlp->getReasonTitles();
            break;
        case 'rma_item_condition':
            $options = $this->_rmaHlp->getItemConditionTitles();
            break;

        case 'rma_use_ups_account':
        case 'rma_use_endicia_account':
        case 'rma_use_fedex_account':
            $options = [
                'global' => __('Global'),
                'vendor' => __('Vendor'),
            ];
            break;

        case 'vendor_rma_grid_sortdir':
            $options = [
                'asc' => __('Ascending'),
                'desc' => __('Descending'),
            ];
            break;

        case 'vendor_rma_grid_sortby':
            $options = [
                'increment_id' => __('RMA ID'),
                'rma_date' => __('RMA Date'),
                'udropship_status' => __('RMA Status'),
                'rma_reason' => __('Reason to return'),
            ];
            break;

        case 'rma_use_address':
            $options = [
                'origin' => __('Origin'),
                'custom' => __('Custom'),
            ];
            break;

        case 'urma/fedex/fedex_dropoff_type':
            $options = [
                'REGULAR_PICKUP' => __('Regular Pickup'),
                'REQUEST_COURIER' => __('Request Courier'),
                'DROP_BOX' => __('Drop Box'),
                'BUSINESS_SERVICE_CENTER' => __('Business Service Center'),
                'STATION' => __('Station'),
            ];
            break;

        case 'urma/fedex/fedex_service_type':
            break;

        case 'urma/fedex/fedex_packaging_type':
            break;

        case 'urma/fedex/fedex_label_stock_type':
            $options = [
                'PAPER_4X6' => __('PDF: Paper 4x6'),
                'PAPER_4X8' => __('PDF: Paper 4x8'),
                'PAPER_4X9' => __('PDF: Paper 4x9'),
                'PAPER_7X4.75' => __('PDF: Paper 7x4.75'),
                'PAPER_8.5\X11\BOTTOM\HALF\LABEL' => __('PDF: Paper 8.5x11 Bottom Half Label'),
                'PAPER_8.5\X11\TOP\HALF\LABEL' => __('PDF: Paper 8.5x11 Top Half Label'),

                'STOCK_4X6' => __('EPL: Stock 4x6'),
                'STOCK_4X6.75_LEADING_DOC_TAB' => __('EPL: Stock 4x6.75 Leading Doc Tab'),
                'STOCK_4X6.75_TRAILING_DOC_TAB' => __('EPL: Stock 4x6.75 Trailing Doc Tab'),
                'STOCK_4X8' => __('EPL: Stock 4x8'),
                'STOCK_4X9_LEADING_DOC_TAB' => __('EPL: Stock 4x9 Leading Doc Tab'),
                'STOCK_4X9_TRAILING_DOC_TAB' => __('EPL: Stock 4x9 Trailing Doc Tab'),
            ];
            break;

        case 'urma/fedex/fedex_signature_option':
            $options = [
                'NO_SIGNATURE_REQUIRED' => 'No Signature Required',
                'SERVICE_DEFAULT' => 'Default Appropriate Signature Option',
                'DIRECT' => 'Direct',
                'INDIRECT' => 'Indirect',
                'ADULT' => 'Adult',
            ];
            break;

        case 'urma/fedex/fedex_notify_on':
            $options = [
                ''  => '* None *',
                'shipment'  => 'Shipment',
                'exception' => 'Exception',
                'delivery'  => 'Delivery',
            ];
            break;

        case 'urma/endicia/endicia_label_type':
            $options = [
                'Default'=>'Default',
                'CertifiedMail'=>'CertifiedMail',
                'DestinationConfirm'=>'DestinationConfirm',
                //'International'=>'International',
            ];
            break;

        case 'urma/endicia/endicia_label_size':
            $options = [
                '4X6'=>'4X6',
                '4X5'=>'4X5',
                '4X4.5'=>'4X4.5',
                'DocTab'=>'DocTab',
                '6x4'=>'6x4',
            ];
            break;
        case 'urma/endicia/endicia_mail_class':
            $options = [
                'FirstClassMailInternational'=>'First-Class Mail International',
                'PriorityMailInternational'=>'Priority Mail International',
                'ExpressMailInternational'=>'Express Mail International',
                'Express'=>'Express Mail',
                'First'=>'First-Class Mail',
                'LibraryMail'=>'Library Mail',
                'MediaMail'=>'Media Mail',
                'ParcelPost'=>'Parcel Post',
                'ParcelSelect'=>'Parcel Select',
                'Priority'=>'Priority Mail',
            ];
            break;
        case 'urma/endicia/endicia_mailpiece_shape':
            $options = [
                'Card'=>'Card',
                'Letter'=>'Letter',
                'Flat'=>'Flat',
                'Parcel'=>'Parcel',
                'FlatRateBox'=>'FlatRateBox',
                'FlatRateEnvelope'=>'FlatRateEnvelope',
                'IrregularParcel'=>'IrregularParcel',
                'LargeFlatRateBox'=>'LargeFlatRateBox',
                'LargeParcel'=>'LargeParcel',
                'OversizedParcel'=>'OversizedParcel',
                'SmallFlatRateBox'=>'SmallFlatRateBox',
            ];
            break;

        case 'urma/endicia/endicia_insured_mail':
            $options = [
                'OFF' => 'No Insurance',
                'ON'  => 'USPS Insurance',
                'UspsOnline' => 'USPS Online Insurance',
                'Endicia' => 'Endicia Insurance',
            ];
            break;

        case 'urma/endicia/endicia_customs_form_type':
            $options = [
                'Form2976' => 'Form 2976 (same as CN22)',
                'Form2976A' => 'Form 2976A (same as CP72)',
            ];
            break;

        case 'urma/ups/ups_pickup':
            $options = [
                '' => '* Default',
                '01' => 'Daily Pickup',
                '03' => 'Customer Counter',
                '06' => 'One Time Pickup',
                '07' => 'On Call Air',
                '11' => 'Suggested Retail',
                '19' => 'Letter Center',
                '20' => 'Air Service Center',
            ];
            break;

        case 'urma/ups/ups_container':
            $options = [
                '' => '* Default',
                '00' => 'Customer Packaging',
                '01' => 'UPS Letter Envelope',
                '03' => 'UPS Tube',
                '21' => 'UPS Express Box',
                '24' => 'UPS Worldwide 25 kilo',
                '25' => 'UPS Worldwide 10 kilo',
            ];
            break;

        case 'urma/ups/ups_dest_type':
            $options = [
                '' => '* Default',
                '01' => 'Residential',
                '02' => 'Commercial',
            ];
            break;

        case 'urma/ups/ups_delivery_confirmation':
            $options = [
                '' => 'No Delivery Confirmation',
                '1' => 'Delivery Confirmation',
                '2' => 'Delivery Confirmation Signature Required',
                '3' => 'Delivery Confirmation Adult Signature Required',
            ];
            break;

        case 'urma/ups/ups_shipping_method_combined':
            $options = [
                'UPS CGI' => [
                    '1DM'    => __('Next Day Air Early AM'),
                    '1DML'   => __('Next Day Air Early AM Letter'),
                    '1DA'    => __('Next Day Air'),
                    '1DAL'   => __('Next Day Air Letter'),
                    '1DAPI'  => __('Next Day Air Intra (Puerto Rico)'),
                    '1DP'    => __('Next Day Air Saver'),
                    '1DPL'   => __('Next Day Air Saver Letter'),
                    '2DM'    => __('2nd Day Air AM'),
                    '2DML'   => __('2nd Day Air AM Letter'),
                    '2DA'    => __('2nd Day Air'),
                    '2DAL'   => __('2nd Day Air Letter'),
                    '3DS'    => __('3 Day Select'),
                    'GND'    => __('Ground'),
                    'GNDCOM' => __('Ground Commercial'),
                    'GNDRES' => __('Ground Residential'),
                    'STD'    => __('Canada Standard'),
                    'XPR'    => __('Worldwide Express'),
                    'WXS'    => __('Worldwide Express Saver'),
                    'XPRL'   => __('Worldwide Express Letter'),
                    'XDM'    => __('Worldwide Express Plus'),
                    'XDML'   => __('Worldwide Express Plus Letter'),
                    'XPD'    => __('Worldwide Expedited'),
                ],
                'UPS XML' => [
                    '01' => __('UPS Next Day Air'),
                    '02' => __('UPS Second Day Air'),
                    '03' => __('UPS Ground'),
                    '07' => __('UPS Worldwide Express'),
                    '08' => __('UPS Worldwide Expedited'),
                    '11' => __('UPS Standard'),
                    '12' => __('UPS Three-Day Select'),
                    '13' => __('UPS Next Day Air Saver'),
                    '14' => __('UPS Next Day Air Early A.M.'),
                    '54' => __('UPS Worldwide Express Plus'),
                    '59' => __('UPS Second Day Air A.M.'),
                    '65' => __('UPS Saver'),

                    '82' => __('UPS Today Standard'),
                    '83' => __('UPS Today Dedicated Courrier'),
                    '84' => __('UPS Today Intercity'),
                    '85' => __('UPS Today Express'),
                    '86' => __('UPS Today Express Saver'),
                ],
            ];
            break;

        default:
            throw new \Exception(__('Invalid request for source options: '.$this->getPath()));
        }

        if ($selector) {
            $options = [''=>__('* Please select')] + $options;
        }

        return $options;
    }

}
