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
 * @package    Unirgy_Dropship
 * @copyright  Copyright (c) 2008-2009 Unirgy LLC (http://www.unirgy.com)
 * @license    http:///www.unirgy.com/LICENSE-M1.txt
 */
 
namespace Unirgy\DropshipPo\Block\Adminhtml\Po\View;

use Magento\Backend\Block\Template;

class Form extends Template
{
    protected function _construct()
    {
        parent::_construct();
        $this->setTemplate('Unirgy_DropshipPo::udpo/po/view/form.phtml');
    }
}