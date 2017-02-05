<?php
namespace Unirgy\Rma\Plugin;

use Magento\Framework\Registry;
use Unirgy\Dropship\Helper\Data as HelperData;
use Unirgy\Rma\Helper\Data as RmaHelperData;

class AdminhtmlOrderView
{
    /**
     * @var HelperData
     */
    protected $_hlp;

    /**
     * @var Registry
     */
    protected $_coreRegistry;

    /**
     * @var RmaHelperData
     */
    protected $_rmaHlp;

    public function __construct(
        HelperData $helperData,
        Registry $frameworkRegistry,
        RmaHelperData $rmaHelperData,
        \Magento\Framework\AuthorizationInterface $authorization
    )
    {
        $this->_hlp = $helperData;
        $this->_coreRegistry = $frameworkRegistry;
        $this->_rmaHlp = $rmaHelperData;
        $this->_authorization = $authorization;
    }
    public function beforeSetLayout(\Magento\Sales\Block\Adminhtml\Order\View $subject, \Magento\Framework\View\LayoutInterface $layout)
    {
        if ($this->_coreRegistry->registry('sales_order')
            && $this->_hlp->isUdropshipOrder($this->_coreRegistry->registry('sales_order'))
            && $this->_authorization->isAllowed('Unirgy_Rma::action_urma')
            && $this->_rmaHlp->canRMA($this->_coreRegistry->registry('sales_order'))
        ) {
            $subject->addButton('create_urma', [
                'label'   => __('Create uReturn'),
                'class'   => 'create_urma',
                'onclick' => 'setLocation(\'' . $subject->getUrl('urma/order_rma/new') . '\')'
            ]);
            return null;
        }
    }
}
