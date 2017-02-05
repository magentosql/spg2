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

use Magento\Paypal\Model\Config as ModelConfig;

class Config extends ModelConfig
{
    const METHOD_UPADAPTIVE = 'upadaptive';
    protected function _getSpecificConfigPath($fieldName)
    {
        $path = null;
        switch ($this->_methodCode) {
            case self::METHOD_UPADAPTIVE:
                $path = $this->_mapUpadaptiveFieldset($fieldName);
                if ($path === null) {
                    $path = $this->_mapWppFieldset($fieldName);
                }
                if ($path === null) {
                    $path = $this->_mapGeneralFieldset($fieldName);
                }
                if ($path === null) {
                    $path = $this->_mapGenericStyleFieldset($fieldName);
                }
                break;
            default:
                $path = parent::_getSpecificConfigPath($fieldName);
        }
        return $path;
    }
    protected function _mapUpadaptiveFieldset($fieldName)
    {
        switch ($fieldName)
        {
            case 'active':
            case 'line_items_summary':
            case 'appid':
                return 'payment/' . self::METHOD_UPADAPTIVE . "/{$fieldName}";
            default:
                return $this->_mapMethodFieldset($fieldName);
        }
    }
}