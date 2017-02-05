<?php

namespace Unirgy\Rma\Block\Order\PrintOrder;

use Magento\Framework\Registry;
use Magento\Framework\View\Element\AbstractBlock;
use Magento\Framework\View\Element\Template\Context;
use Magento\Framework\View\LayoutFactory;
use Magento\Payment\Helper\Data as PaymentHelperData;
use Magento\Sales\Block\Items\AbstractItems;
use Magento\Sales\Model\Order;
use Magento\Sales\Model\Order\Address;
use Unirgy\Rma\Helper\Data as HelperData;

class Rma extends AbstractItems
{
    /**
     * @var Registry
     */
    protected $_frameworkRegistry;

    /**
     * @var HelperData
     */
    protected $_helperData;

    /**
     * @var LayoutFactory
     */
    protected $_viewLayoutFactory;

    /**
     * @var PaymentHelperData
     */
    protected $_paymentHelperData;

    public function __construct(Context $context, 
        Registry $frameworkRegistry, 
        HelperData $helperData, 
        LayoutFactory $viewLayoutFactory, 
        PaymentHelperData $paymentHelperData, 
        array $data = [])
    {
        $this->_frameworkRegistry = $frameworkRegistry;
        $this->_helperData = $helperData;
        $this->_viewLayoutFactory = $viewLayoutFactory;
        $this->_paymentHelperData = $paymentHelperData;

        parent::__construct($context, $data);
    }

    protected $_rmasCollection;

    protected function _beforeToHtml()
    {
        $rma = $this->_frameworkRegistry->registry('current_rma');
        if($rma) {
            $this->_rmasCollection = [$rma];
        } else {
            $this->_helperData->initOrderRmasCollection($this->getOrder());
            $this->_rmasCollection = $this->getOrder()->getRmasCollection();
        }

        return parent::_beforeToHtml();
    }

    protected function _prepareLayout()
    {
        if ($headBlock = $this->_viewLayoutFactory->create()->getBlock('head')) {
            $headBlock->setTitle(__('Order # %1', $this->getOrder()->getRealOrderId()));
        }
        $this->setChild(
            'payment_info',
            $this->_paymentHelperData->getInfoBlock($this->getOrder()->getPayment())
        );
    }

    public function getBackUrl()
    {
        return $this->_urlBuilder->getUrl('*/*/history');
    }

    public function getPrintUrl()
    {
        return $this->_urlBuilder->getUrl('*/*/print');
    }

    public function getPaymentInfoHtml()
    {
        return $this->getChildHtml('payment_info');
    }

    public function getOrder()
    {
        return $this->_frameworkRegistry->registry('current_order');
    }

    public function getRma()
    {
        return $this->_frameworkRegistry->registry('current_rma');
    }

    protected function _prepareItem(AbstractBlock $renderer)
    {
        $renderer->setPrintStatus(true);

        return parent::_prepareItem($renderer);
    }

    public function getRmasCollection()
    {
        return $this->_rmasCollection;
    }

    public function getRmaAddressFormattedHtml($rma)
    {
        $shippingAddress = $rma->getShippingAddress();
        if(!($shippingAddress instanceof Address)) {
            return '';
        }
        return $shippingAddress->format('html');
    }

    /**
     * Getter for billing address of order by format
     *
     * @param Order $order
     * @return string
     */
    public function getBillingAddressFormattedHtml($order)
    {
        $billingAddress = $order->getBillingAddress();
        if(!($billingAddress instanceof Address)) {
            return '';
        }
        return $billingAddress->format('html');
    }

    public function getRmaItems($rma)
    {
        $res = [];
        foreach ($rma->getItemsCollection() as $item) {
            if (!$item->getOrderItem()->getParentItem()) {
                $res[] = $item;
            }
        }
        return $res;
    }
}

