<?php

namespace Unirgy\Rma\Block\Order;

class Link extends \Magento\Sales\Block\Order\Link
{
    public function __construct(
        \Unirgy\Rma\Helper\Data $urmaHelper,
        \Magento\Framework\View\Element\Template\Context $context,
        \Magento\Framework\App\DefaultPathInterface $defaultPath,
        \Magento\Framework\Registry $registry,
        array $data = []
    ) {
        parent::__construct($context, $defaultPath, $registry, $data);
        $this->_rmaHlp = $urmaHelper;
    }
    protected function _toHtml()
    {
        $order = $this->_registry->registry('current_order');
        $this->_rmaHlp->initOrderRmasCollection($order);
        if (!$order->getHasUrmas()) {
            return '';
        }
        return \Magento\Framework\View\Element\Html\Link\Current::_toHtml();
    }
}
