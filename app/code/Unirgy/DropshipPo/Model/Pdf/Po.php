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
 * @package    Unirgy_DropshipPo
 * @copyright  Copyright (c) 2008-2009 Unirgy LLC (http://www.unirgy.com)
 * @license    http:///www.unirgy.com/LICENSE-M1.txt
 */
 
namespace Unirgy\DropshipPo\Model\Pdf;

use Magento\Framework\App\Config\ScopeConfigInterface;
use Magento\Framework\App\Helper\AbstractHelper;
use Magento\Framework\Filesystem;
use Magento\Framework\Locale\Resolver;
use Magento\Framework\Stdlib\DateTime\TimezoneInterface;
use Magento\Framework\Stdlib\StringUtils;
use Magento\Framework\Translate\Inline\StateInterface;
use Magento\Payment\Helper\Data as HelperData;
use Magento\Sales\Model\Order\Address\Renderer;
use Magento\Sales\Model\Order\Pdf\AbstractPdf;
use Magento\Sales\Model\Order\Pdf\Config;
use Magento\Sales\Model\Order\Pdf\ItemsFactory;
use Magento\Sales\Model\Order\Pdf\Total\Factory;
use Magento\Store\Model\ScopeInterface;
use Unirgy\Dropship\Helper\Data as DropshipHelperData;

class Po extends AbstractPdf
{
    /**
     * @var DropshipHelperData
     */
    protected $_hlp;

    /**
     * @var Resolver
     */
    protected $_localeResolver;

    public function __construct(HelperData $paymentData,
        StringUtils $string, 
        ScopeConfigInterface $scopeConfig, 
        Filesystem $filesystem, 
        Config $pdfConfig, 
        Factory $pdfTotalFactory, 
        ItemsFactory $pdfItemsFactory, 
        TimezoneInterface $localeDate, 
        StateInterface $inlineTranslation, 
        Renderer $addressRenderer, 
        DropshipHelperData $helperData, 
        Resolver $localeResolver, 
        array $data = [])
    {
        $this->_hlp = $helperData;
        $this->_localeResolver = $localeResolver;

        parent::__construct($paymentData, $string, $scopeConfig, $filesystem, $pdfConfig, $pdfTotalFactory, $pdfItemsFactory, $localeDate, $inlineTranslation, $addressRenderer, $data);
    }

    protected function _setFontRegular($object, $size = 7)
    {
        if (!$this->getUseFont()) {
            return parent::_setFontRegular($object, $size);
        }
        $font = \Zend_Pdf_Font::fontWithName(constant('\Zend_Pdf_Font::FONT_'.$this->getUseFont()));
        $object->setFont($font, $size);
        return $font;
    }

    protected function _setFontBold($object, $size = 7)
    {
        if (!$this->getUseFont()) {
            return parent::_setFontBold($object, $size);
        }
        $font = \Zend_Pdf_Font::fontWithName(constant('\Zend_Pdf_Font::FONT_'.$this->getUseFont().'_BOLD'));
        $object->setFont($font, $size);
        return $font;
    }

    protected function _setFontItalic($object, $size = 7)
    {
        if (!$this->getUseFont()) {
            return parent::_setFontItalic($object, $size);
        }
        $font = \Zend_Pdf_Font::fontWithName(constant('\Zend_Pdf_Font::FONT_'.$this->getUseFont().'_ITALIC'));
        $object->setFont($font, $size);
        return $font;
    }
    
    protected $_currentPo;
    
    public function getPdf($udpos = [])
    {
        $this->_beforeGetPdf();
        $this->_initRenderer('udpo');

        $pdf = new \Zend_Pdf();
        $this->_setPdf($pdf);
        $style = new \Zend_Pdf_Style();
        $this->_setFontBold($style, 10);
        foreach ($udpos as $udpo) {
            if ($udpo->getStoreId()) {
                $this->_localeResolver->emulate($udpo->getStoreId());
            }
            $page = $pdf->newPage(\Zend_Pdf_Page::SIZE_A4);
            $pdf->pages[] = $page;
            
            $this->_currentPo = $udpo;

            $order = $udpo->getOrder();

            /* Add image */
            $this->insertLogo($page, $udpo->getStore());

            /* Add address */
            $this->insertAddress($page, $udpo->getStore());

            $top = $this->y ? $this->y : 815;
            /* Add head */
            $this->insertOrder($page, $order, $this->_scopeConfig->isSetFlag(self::XML_PATH_SALES_PDF_SHIPMENT_PUT_ORDER_ID, ScopeInterface::SCOPE_STORE, $order->getStoreId()));

            $page->setFillColor(new \Zend_Pdf_Color_GrayScale(1));
            $this->_setFontRegular($page);
            $page->drawText(__('Purchase Order # ') . $udpo->getIncrementId(), 35, ($top-=25), 'UTF-8');

            /* Add table */
            $page->setFillColor(new \Zend_Pdf_Color_Rgb(0.93, 0.92, 0.92));
            $page->setLineColor(new \Zend_Pdf_Color_GrayScale(0.5));
            $page->setLineWidth(0.5);


            /* Add table head */
            $page->drawRectangle(25, $this->y, 570, $this->y-15);
            $this->y -=10;
            $page->setFillColor(new \Zend_Pdf_Color_Rgb(0.4, 0.4, 0.4));
            $page->drawText(__('Products'), 35, $this->y, 'UTF-8');
            $page->drawText(__('SKU'), 255, $this->y, 'UTF-8');
            $page->drawText(__('Cost'), 380, $this->y, 'UTF-8');
            $page->drawText(__('Qty'), 470, $this->y, 'UTF-8');
            $page->drawText(__('Row Cost'), 535, $this->y, 'UTF-8');

            $this->y -=15;

            $page->setFillColor(new \Zend_Pdf_Color_GrayScale(0));

            /* Add body */
            foreach ($udpo->getAllItems() as $item){
                if ($item->getOrderItem()->getParentItem()) {
                    continue;
                }

                if ($this->y<75+10*count($this->getCustomTextArray($udpo))) {
                    $this->drawCustomText($udpo, $page);
                    $page = $this->newPage(['table_header' => true]);
                }

                /* Draw item */
                $page = $this->_drawItem($item, $page, $order);
            }
            $this->drawCustomText($udpo, $page);
            
            $page = $this->insertTotals($page, $udpo);
        }

        $this->_afterGetPdf();

        if ($udpo->getStoreId()) {
            $this->_localeResolver->revert();
        }
        return $pdf;
    }
    
    public function insertTotals($page, $udpo)
    {
        $lineBlock = [
            'height' => 15,
            'lines'  => [[
                [
                    'text'      => __('Total Cost'),
                    'feed'      => 475,
                    'align'     => 'right',
                    'font_size' => 7,
                    'font'      => 'bold'
                ],
                [
                    'text'      => $udpo->getOrder()->getBaseCurrency()->formatTxt($udpo->getTotalCost()),
                    'feed'      => 565,
                    'align'     => 'right',
                    'font_size' => 7,
                    'font'      => 'bold'
                ],
            ]]
        ];

        if ($udpo->getIsManual()) {
            $lineBlock[0]['lines'][] = [
                [
                    'text'      => __('Total Shipping'),
                    'feed'      => 475,
                    'align'     => 'right',
                    'font_size' => 7,
                    'font'      => 'bold'
                ],
                [
                    'text'      => $udpo->getOrder()->getBaseCurrency()->formatTxt($udpo->getBaseShippingAmount()),
                    'feed'      => 565,
                    'align'     => 'right',
                    'font_size' => 7,
                    'font'      => 'bold'
                ],
            ];
            $lineBlock[0]['lines'][] = [
                [
                    'text'      => __('Grand Total'),
                    'feed'      => 475,
                    'align'     => 'right',
                    'font_size' => 7,
                    'font'      => 'bold'
                ],
                [
                    'text'      => $udpo->getOrder()->getBaseCurrency()->formatTxt($udpo->getTotalCost()+$udpo->getBaseShippingAmount()),
                    'feed'      => 565,
                    'align'     => 'right',
                    'font_size' => 7,
                    'font'      => 'bold'
                ],
            ];
        }
        
        return $this->drawLineBlocks($page, [$lineBlock]);
    }
    
    public function newPage(array $settings = [])
    {
        /* Add new table head */
        $page = $this->_getPdf()->newPage(\Zend_Pdf_Page::SIZE_A4);
        $this->_getPdf()->pages[] = $page;
        $this->y = 800;

        if (!empty($settings['table_header'])) {
            $this->_setFontRegular($page);
            $page->setFillColor(new \Zend_Pdf_Color_Rgb(0.93, 0.92, 0.92));
            $page->setLineColor(new \Zend_Pdf_Color_GrayScale(0.5));
            $page->setLineWidth(0.5);
            $page->drawRectangle(25, $this->y, 570, $this->y-15);
            $this->y -=10;

            $page->setFillColor(new \Zend_Pdf_Color_Rgb(0.4, 0.4, 0.4));
            $page->drawText(__('Products'), 35, $this->y, 'UTF-8');
            $page->drawText(__('SKU'), 255, $this->y, 'UTF-8');
            $page->drawText(__('Cost'), 380, $this->y, 'UTF-8');
            $page->drawText(__('Qty'), 470, $this->y, 'UTF-8');
            $page->drawText(__('Row Cost'), 535, $this->y, 'UTF-8');

            $page->setFillColor(new \Zend_Pdf_Color_GrayScale(0));
            $this->y -=20;
        }

        return $page;
    }
    
    protected function insertOrder(&$page, $order, $putOrderId = true)
    {
        $this->y = $this->y ? $this->y : 815;
        $top = $this->y;
        /* @var $order \Magento\Sales\Model\Order */
        $page->setFillColor(new \Zend_Pdf_Color_GrayScale(0.5));

        $page->drawRectangle(25, $top, 570, $top-55);

        $page->setFillColor(new \Zend_Pdf_Color_GrayScale(1));
        $this->_setFontRegular($page);


        if ($putOrderId) {
            $page->drawText(__('Order # ').$order->getRealOrderId(), 35, ($top -= 10), 'UTF-8');
        }
        //$page->drawText(__('Order Date: ') . date( 'D M j Y', strtotime( $order->getCreatedAt() ) ), 35, 760, 'UTF-8');
        $page->drawText(__('Order Date: ') . $this->_hlp->formatDate($order->getCreatedAtStoreDate(), \IntlDateFormatter::MEDIUM, false), 35, ($top -= 30), 'UTF-8');

        $page->setFillColor(new \Zend_Pdf_Color_Rgb(0.93, 0.92, 0.92));
        $page->setLineColor(new \Zend_Pdf_Color_GrayScale(0.5));
        $page->setLineWidth(0.5);
        $page->drawRectangle(25, ($top -= 5), 275, ($top-25));
        $page->drawRectangle(275, $top, 570, ($top-25));

        /* Calculate blocks info */

        /* Billing Address */
        $billingAddress = $this->_formatAddress(
            $this->_hlp->formatCustomerAddress($order->getBillingAddress(), 'pdf', $this->_currentPo->getUdropshipVendor())
        );

        /* Payment */
        $paymentInfo = $this->_paymentData->getInfoBlock($order->getPayment())
            ->setIsSecureMode(true)
            ->toPdf();
        $payment = explode('{{pdf_row_separator}}', $paymentInfo);
        foreach ($payment as $key=>$value){
            if (strip_tags(trim($value))==''){
                unset($payment[$key]);
            }
        }
        reset($payment);

        /* Shipping Address and Method */
        if (!$order->getIsVirtual()) {
            /* Shipping Address */
            $shippingAddress = $this->_formatAddress(
                $this->_hlp->formatCustomerAddress($order->getShippingAddress(), 'pdf', $this->_currentPo->getUdropshipVendor())
            );

            $shippingMethod  = $order->getShippingDescription();
        }

        $page->setFillColor(new \Zend_Pdf_Color_GrayScale(0));
        $this->_setFontRegular($page);
        $page->drawText(__('SOLD TO:'), 35, ($top-15) , 'UTF-8');

        if (!$order->getIsVirtual()) {
            $page->drawText(__('SHIP TO:'), 285, ($top-15) , 'UTF-8');
        }
        else {
            $page->drawText(__('Payment Method:'), 285, ($top-15) , 'UTF-8');
        }

        if (!$order->getIsVirtual()) {
            $y = ($top-25) - (max(count($billingAddress), count($shippingAddress)) * 10 + 5);
        }
        else {
            $y = ($top-25) - (count($billingAddress) * 10 + 5);
        }

        $page->setFillColor(new \Zend_Pdf_Color_GrayScale(1));
        $page->drawRectangle(25, ($top-25), 570, $y);
        $page->setFillColor(new \Zend_Pdf_Color_GrayScale(0));
        $this->_setFontRegular($page);
        $this->y = ($top-35);

        foreach ($billingAddress as $value){
            if ($value!=='') {
                $page->drawText(strip_tags(ltrim($value)), 35, $this->y, 'UTF-8');
                $this->y -=10;
            }
        }

        if (!$order->getIsVirtual()) {
            $this->y = ($top-35);
            foreach ($shippingAddress as $value){
                if ($value!=='') {
                    $page->drawText(strip_tags(ltrim($value)), 285, $this->y, 'UTF-8');
                    $this->y -=10;
                }

            }

            $this->y = $y;
            $page->setFillColor(new \Zend_Pdf_Color_Rgb(0.93, 0.92, 0.92));
            $page->setLineWidth(0.5);
            $page->drawRectangle(25, $this->y, 275, $this->y-25);
            $page->drawRectangle(275, $this->y, 570, $this->y-25);

            $this->y -=15;
            $this->_setFontBold($page);
            $page->setFillColor(new \Zend_Pdf_Color_GrayScale(0));
            $page->drawText(__('Payment Method'), 35, $this->y, 'UTF-8');
            $page->drawText(__('Shipping Method:'), 285, $this->y , 'UTF-8');

            $this->y -=10;
            $page->setFillColor(new \Zend_Pdf_Color_GrayScale(1));

            $this->_setFontRegular($page);
            $page->setFillColor(new \Zend_Pdf_Color_GrayScale(0));

            $paymentLeft = 35;
            $yPayments   = $this->y - 15;
        }
        else {
            $yPayments   = ($top-25);
            $paymentLeft = 285;
        }

        foreach ($payment as $value){
            if (trim($value)!=='') {
                $page->drawText(strip_tags(trim($value)), $paymentLeft, $yPayments, 'UTF-8');
                $yPayments -=10;
            }
        }

        if (!$order->getIsVirtual()) {
            $this->y -=15;

            $page->drawText($shippingMethod, 285, $this->y, 'UTF-8');

            $yShipments = $this->y;

            $curVendor = $this->_hlp->getVendor($this->_currentPo->getUdropshipVendor());
            if (!$curVendor->getHideUdpoPdfShippingAmount()) {
                $totalShippingChargesText = "(" . __('Total Shipping Charges') . " " . $order->formatPriceTxt($order->getShippingAmount()) . ")";
    
                $page->drawText($totalShippingChargesText, 285, $yShipments-7, 'UTF-8');
            }
            $yShipments -=10;
            $tracks = $order->getTracksCollection();
            if (count($tracks)) {
                $page->setFillColor(new \Zend_Pdf_Color_Rgb(0.93, 0.92, 0.92));
                $page->setLineWidth(0.5);
                $page->drawRectangle(285, $yShipments, 510, $yShipments - 10);
                $page->drawLine(380, $yShipments, 380, $yShipments - 10);
                //$page->drawLine(510, $yShipments, 510, $yShipments - 10);

                $this->_setFontRegular($page);
                $page->setFillColor(new \Zend_Pdf_Color_GrayScale(0));
                //$page->drawText(__('Carrier'), 290, $yShipments - 7 , 'UTF-8');
                $page->drawText(__('Title'), 290, $yShipments - 7, 'UTF-8');
                $page->drawText(__('Number'), 385, $yShipments - 7, 'UTF-8');

                $yShipments -=17;
                $this->_setFontRegular($page, 6);
                foreach ($order->getTracksCollection() as $track) {

                    $CarrierCode = $track->getCarrierCode();
                    if ($CarrierCode!='custom')
                    {
                        $carrier = $this->_hlp->getObj('\Magento\Shipping\Model\CarrierFactory')->create($CarrierCode);
                        $carrierTitle = $carrier->getConfigData('title');
                    }
                    else
                    {
                        $carrierTitle = __('Custom Value');
                    }

                    //$truncatedCarrierTitle = substr($carrierTitle, 0, 35) . (strlen($carrierTitle) > 35 ? '...' : '');
                    $truncatedTitle = substr($track->getTitle(), 0, 45) . (strlen($track->getTitle()) > 45 ? '...' : '');
                    //$page->drawText($truncatedCarrierTitle, 285, $yShipments , 'UTF-8');
                    $page->drawText($truncatedTitle, 300, $yShipments , 'UTF-8');
                    $page->drawText($track->getNumber(), 395, $yShipments , 'UTF-8');
                    $yShipments -=7;
                }
            } else {
                $yShipments -= 7;
            }

            $currentY = min($yPayments, $yShipments);

            // replacement of Shipments-Payments rectangle block
            $page->drawLine(25, $this->y + 15, 25, $currentY);
            $page->drawLine(25, $currentY, 570, $currentY);
            $page->drawLine(570, $currentY, 570, $this->y + 15);

            $this->y = $currentY;
            $this->y -= 15;
        }
    }

    public function getSpdTextWidth($string, $page)
    {
        $drawingString = iconv('UTF-8', 'UTF-16BE//IGNORE', $string);
        $characters = [];
        for ($i = 0; $i < strlen($drawingString); $i++) {
            $characters[] = (ord($drawingString[$i++]) << 8) | ord($drawingString[$i]);
        }
        $font = $page->getFont();
        $glyphs = $font->glyphNumbersForCharacters($characters);
        $widths = $font->widthsForGlyphs($glyphs);
        $stringWidth = (array_sum($widths) / $font->getUnitsPerEm()) * $page->getFontSize();
        return $stringWidth;
    }

    protected $_customTextArr = [];
    protected function getCustomTextArray($po)
    {
        if (!isset($this->_customTextArr[$po->getId()])) {
            $customText = $this->_scopeConfig->getValue('udropship/purchase_order/udpo_pdf_custom_text', ScopeInterface::SCOPE_STORE, $po->getStoreId());
            $curVendor = $this->_hlp->getVendor($po->getUdropshipVendor());
            $vUsePSCT = $curVendor->getData('use_udpo_pdf_custom_text');
            if ($vUsePSCT==1) {
                $customText = $curVendor->getData('udpo_pdf_custom_text');
            } elseif ($vUsePSCT==0) {
                $customText = '';
            }
            $_customTextArr = preg_split("/\r\n|\r|\n/", $customText);
            $customTextArr = [];
            foreach ($_customTextArr as $_cti) {
                if (($_cti = trim($_cti))) {
                    $customTextArr[] = $_cti;
                }
            }
            $this->_customTextArr[$po->getId()] = $customTextArr;
        }
        return $this->_customTextArr[$po->getId()];
    }

    protected function drawCustomText($shipment, $page)
    {
        $this->_setFontBold($page);
        foreach ($this->getCustomTextArray($shipment) as $i => $__cti) {
            if (($_cti = preg_replace('/\[%\s*bold\s*%\]/', '', $__cti))!=$__cti) {
                $this->_setFontBold($page);
            } else {
                $this->_setFontRegular($page);
            }
            $_ctiWidth = $this->getSpdTextWidth($_cti, $page);
            $page->drawText($_cti, 35+(545-$_ctiWidth)/2, $this->y-(30+$i*10), 'UTF-8');
        }
        $this->_setFontRegular($page);
    }
}