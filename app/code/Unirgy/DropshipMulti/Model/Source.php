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
 * @package    Unirgy_DropshipSplit
 * @copyright  Copyright (c) 2008-2009 Unirgy LLC (http://www.unirgy.com)
 * @license    http:///www.unirgy.com/LICENSE-M1.txt
 */

/**
* Currently not in use
*/
namespace Unirgy\DropshipMulti\Model;

use Magento\CatalogInventory\Model\Source\Backorders;
use Magento\Framework\App\Config\ScopeConfigInterface;
use Unirgy\DropshipMulti\Helper\Data as DropshipMultiHelperData;
use Unirgy\Dropship\Helper\Data as HelperData;
use Unirgy\Dropship\Model\Source\AbstractSource;

class Source extends AbstractSource
{
    /**
     * @var HelperData
     */
    protected $_hlp;

    /**
     * @var DropshipMultiHelperData
     */
    protected $_multiHlp;

    /**
     * @var Backorders
     */
    protected $_sourceBackorders;

    /**
     * @var ScopeConfigInterface
     */
    protected $_scopeConfig;

    public function __construct(
        HelperData $helperData, 
        DropshipMultiHelperData $dropshipMultiHelperData, 
        Backorders $sourceBackorders, 
        ScopeConfigInterface $configScopeConfigInterface,
        array $data = []
    )
    {
        $this->_hlp = $helperData;
        $this->_multiHlp = $dropshipMultiHelperData;
        $this->_sourceBackorders = $sourceBackorders;
        $this->_scopeConfig = $configScopeConfigInterface;

        parent::__construct($data);
    }

    const AVAIL_BACKORDERS_YES_NONOTIFY=10;
    const AVAIL_BACKORDERS_YES_NOTIFY=11;
    const BACKORDERS_USE_CONFIG = -1;
    public function toOptionHash($selector=false)
    {
        $hlp = $this->_hlp;
        $hlpm = $this->_multiHlp;

        switch ($this->getPath()) {

        case 'udropship/stock/total_qty_method':
            $options = [
                'max' => 'Max available from any associated vendor',
                //'sum' => 'Sum stock of all associated vendors',
            ];
            break;

        case 'udropship/stock/default_multivendor_status':
        case 'vendor_product_status':
            $options = [
                -1 => __('Pending'),
                0 => __('Inactive'),
                1 => __('Active'),
            ];
            break;

        case 'backorders':
            $options = [
                self::BACKORDERS_USE_CONFIG => __('* Use Config'),
            ];
            foreach ($this->_sourceBackorders->toOptionArray() as $opt) {
                $options[$opt['value']] = $opt['label'];
            }
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