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
 
namespace Unirgy\DropshipPo\Block\Adminhtml\Po\Editcosts;

use Magento\Framework\App\ObjectManager;
use Magento\Sales\Block\Adminhtml\Items\AbstractItems;

class Items extends AbstractItems
{
    public function getPo()
    {
        return $this->_coreRegistry->registry('current_udpo');
    }
    
    public function getOrder()
    {
        return $this->_coreRegistry->registry('current_order');
    }
    
    protected function _beforeToHtml()
    {
        $this->setChild(
            'submit_button',
            $this->getLayout()->createBlock('Magento\Backend\Block\Widget\Button')->setData([
                'label'     => __('Save Costs Update'),
                'class'     => 'save submit-button',
                'onclick'   => 'disableElements(\'submit-button\');$(\'edit_form\').submit()',
            ])
        );

        return parent::_beforeToHtml();
    }
    
    public function getCommentText()
    {
        return ObjectManager::getInstance()->get('Magento\Backend\Model\Session')->getCommentText(true);
    }
}