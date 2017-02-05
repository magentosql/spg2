<?php

namespace Unirgy\Rma\Block\Adminhtml\Rma\View;

use Magento\Backend\Block\Template\Context;
use Magento\Backend\Block\Widget\Tabs as WidgetTabs;
use Magento\Backend\Model\Auth\Session;
use Magento\Framework\Json\EncoderInterface;
use Magento\Framework\Registry;

class Tabs extends WidgetTabs
{
    /**
     * @var Registry
     */
    protected $_coreRegistry;

    public function getOrder()
    {
        if ($this->hasOrder()) {
            return $this->getData('order');
        }
        if ($this->_coreRegistry->registry('current_order')) {
            return $this->_coreRegistry->registry('current_order');
        }
        if ($this->_coreRegistry->registry('order')) {
            return $this->_coreRegistry->registry('order');
        }
        throw new \Exception(__('Cannot get the order instance.'));
    }

    public function __construct(Context $context, 
        EncoderInterface $jsonEncoder, 
        Session $authSession, 
        Registry $frameworkRegistry, 
        array $data = [])
    {
        $this->_coreRegistry = $frameworkRegistry;

        parent::__construct($context, $jsonEncoder, $authSession, $data);
        $this->setId('urma_rma_view_tabs');
        $this->setDestElementId('urma_rma_view');
        $this->setTitle(__('Return View'));
    }

}