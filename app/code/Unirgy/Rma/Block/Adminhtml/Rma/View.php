<?php

namespace Unirgy\Rma\Block\Adminhtml\Rma;

use Magento\Backend\Block\Widget\Context;
use Magento\Backend\Block\Widget\Form\Container;
use Magento\Framework\Registry;

class View extends Container
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

    protected function _construct()
    {
        $this->_blockGroup  = 'Unirgy_Rma';
        $this->_objectId    = 'rma_id';
        $this->_controller  = 'adminhtml_rma';
        $this->_mode        = 'view';

        parent::_construct();

        $this->removeButton('reset');
        $this->removeButton('delete');
        $this->removeButton('save');

    }
    
	public function getRma()
    {
        return $this->_coreRegistry->registry('current_rma');
    }

    public function getHeaderText()
    {
        return __('uReturn #%1$s | %2$s', $this->getRma()->getIncrementId(), $this->formatDate($this->getRma()->getCreatedAtDate(), 'medium', true));
    }

    public function getBackUrl()
    {
        return $this->getUrl(
            'sales/order/view',
            [
                'order_id'  => $this->getRma()->getOrderId(),
                'active_tab'=> 'order_rmas'
            ]);
    }

    public function getPrintUrl()
    {
        return $this->getUrl('urma/rma/print', [
            'rma_id' => $this->getRma()->getId()
        ]);
    }

    public function updateBackButtonUrl($flag)
    {
        if ($flag) {
            return $this->updateButton('back', 'onclick', 'setLocation(\'' . $this->getUrl('urma/rma/') . '\')');
        }
        return $this;
    }
}