<?php

namespace Unirgy\Rma\Block\Adminhtml\Rma;

use Magento\Backend\Block\Widget\Context;
use Magento\Backend\Block\Widget\Form\Container;
use Magento\Framework\Registry;

class Create extends Container
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

        $this->_blockGroup = 'Unirgy_Rma';
        $this->_objectId = 'order_id';
        $this->_controller = 'adminhtml_rma';
        $this->_mode = 'create';

        parent::__construct($context, $data);

    }

    protected function _construct()
    {
        parent::_construct();
        $this->_blockGroup = 'Unirgy_Rma';
        $this->_objectId = 'order_id';
        $this->_controller = 'adminhtml_rma';
        $this->_mode = 'create';

        $this->removeButton('save');
        $this->removeButton('delete');
    }

    /**
     * Retrieve shipment model instance
     *
     * @return \Magento\Sales\Model\Order\Shipment
     */
    public function getRma()
    {
        return $this->_coreRegistry->registry('current_rma');
    }

    public function getHeaderText()
    {
        $header = __('New Return for Order #%1', $this->getRma()->getOrder()->getRealOrderId());
        return $header;
    }

    public function getBackUrl()
    {
        return $this->getUrl('sales/order/view', ['order_id'=>$this->getRma()->getOrderId()]);
    }
}
