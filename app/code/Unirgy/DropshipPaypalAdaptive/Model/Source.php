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

use Unirgy\DropshipPaypalAdaptive\Helper\Data as DropshipPaypalAdaptiveHelperData;
use Unirgy\Dropship\Helper\Data as HelperData;
use Unirgy\Dropship\Model\Source\AbstractSource;

class Source extends AbstractSource
{
    /**
     * @var HelperData
     */
    protected $_hlp;

    /**
     * @var DropshipPaypalAdaptiveHelperData
     */
    protected $_adapHlp;

    public function __construct(
        HelperData $helperData, 
        DropshipPaypalAdaptiveHelperData $dropshipPaypalAdaptiveHelperData,
        array $data = []
    )
    {
        $this->_hlp = $helperData;
        $this->_adapHlp = $dropshipPaypalAdaptiveHelperData;

        parent::__construct($data);
    }

    public function toOptionHash($selector=false)
    {
        $hlp = $this->_hlp;
        $ptHlp = $this->_adapHlp;

        $options = [];
        $path = $this->getPath();
        if (false !== strpos($path, 'upadaptive/settings_payments_upadaptive/payment_action')) {
            $path = 'upadaptive/settings_payments_upadaptive/payment_action';
        }
        switch ($path) {

            case 'upadaptive/settings_payments_upadaptive/payment_action':
            case 'payment/upadaptive/payment_action':
                $options = [
                    \Magento\Paypal\Model\Config::PAYMENT_ACTION_SALE => __('Sale')
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
