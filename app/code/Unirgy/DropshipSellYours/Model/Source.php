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
 * @package    Unirgy_DropshipSellYours
 * @copyright  Copyright (c) 2008-2009 Unirgy LLC (http://www.unirgy.com)
 * @license    http:///www.unirgy.com/LICENSE-M1.txt
 */

namespace Unirgy\DropshipSellYours\Model;

use Unirgy\DropshipSellYours\Helper\Data as DropshipSellYoursHelperData;
use Unirgy\Dropship\Helper\Data as HelperData;
use Unirgy\Dropship\Model\Source\AbstractSource;

class Source extends AbstractSource
{
    /**
     * @var HelperData
     */
    protected $_hlp;

    /**
     * @var DropshipSellYoursHelperData
     */
    protected $_syHlp;

    public function __construct(
        HelperData $helperData, 
        DropshipSellYoursHelperData $dropshipSellYoursHelperData,
        array $data = []
    )
    {
        $this->_hlp = $helperData;
        $this->_syHlp = $dropshipSellYoursHelperData;

        parent::__construct($data);
    }

    public function toOptionHash($selector=false)
    {
        $hlp = $this->_hlp;
        $hlpc = $this->_syHlp;

        switch ($this->getPath()) {

        case 'account_type':
            $options = [
                'basic' => __('Basic'),
                'pro'   => __('Pro'),
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
