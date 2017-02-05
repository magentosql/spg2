<?php

namespace Unirgy\Rma\Block\Adminhtml\Rma\View;

use Magento\Backend\Block\Text\ListText;
use Magento\Framework\Registry;
use Magento\Framework\View\Element\Context;

class Comments extends ListText
{
    /**
     * @var Registry
     */
    protected $_coreRegistry;

    public function __construct(Context $context, 
        Registry $frameworkRegistry, 
        array $data = [])
    {
        $this->_coreRegistry = $frameworkRegistry;

        parent::__construct($context, $data);
    }

    public function getRma()
    {
        return $this->_coreRegistry->registry('current_rma');
    }

    public function getOrder()
    {
        return $this->getRma()->getOrder();
    }

    public function getSource()
    {
        return $this->getRma();
    }
}