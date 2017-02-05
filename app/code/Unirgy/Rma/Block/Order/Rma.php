<?php
/**
 * Magento
 *
 * NOTICE OF LICENSE
 *
 * This source file is subject to the Open Software License (OSL 3.0)
 * that is bundled with this package in the file LICENSE.txt.
 * It is also available through the world-wide-web at this URL:
 * http://opensource.org/licenses/osl-3.0.php
 * If you did not receive a copy of the license and are unable to
 * obtain it through the world-wide-web, please send an email
 * to license@magentocommerce.com so we can send you a copy immediately.
 *
 * DISCLAIMER
 *
 * Do not edit or add to this file if you wish to upgrade Magento to newer
 * versions in the future. If you wish to customize Magento for your
 * needs please refer to http://www.magentocommerce.com for more information.
 *
 * @category    Mage
 * @package     Magento_Sales
 * @copyright   Copyright (c) 2010 Magento Inc. (http://www.magentocommerce.com)
 * @license     http://opensource.org/licenses/osl-3.0.php  Open Software License (OSL 3.0)
 */

/**
 * Sales order view block
 *
 * @category   Mage
 * @package    Magento_Sales
 * @author      Magento Core Team <core@magentocommerce.com>
 */
namespace Unirgy\Rma\Block\Order;

use Magento\Framework\Registry;
use Magento\Framework\View\Element\Template;
use Magento\Framework\View\Element\Template\Context;
use Magento\Payment\Helper\Data as HelperData;

class Rma extends Template
{
    /**
     * @var HelperData
     */
    protected $_paymentHelper;

    /**
     * @var Registry
     */
    protected $_coreRegistry;

    public function __construct(Context $context, 
        HelperData $helperData,
        Registry $frameworkRegistry, 
        array $data = [])
    {
        $this->_paymentHelper = $helperData;
        $this->_coreRegistry = $frameworkRegistry;

        parent::__construct($context, $data);
    }

    protected function _construct()
    {
        parent::_construct();
        $this->setTemplate('Unirgy_Rma::urma/sales/order/rma.phtml');
    }

    protected function _prepareLayout()
    {
        $this->pageConfig->getTitle()->set(__('Order # %1', $this->getOrder()->getRealOrderId()));
        $infoBlock = $this->_paymentHelper->getInfoBlock($this->getOrder()->getPayment(), $this->getLayout());
        $this->setChild('payment_info', $infoBlock);
    }

    public function getPaymentInfoHtml()
    {
        return $this->getChildHtml('payment_info');
    }

    /**
     * Retrieve current order model instance
     *
     * @return \Magento\Sales\Model\Order
     */
    public function getOrder()
    {
        return $this->_coreRegistry->registry('current_order');
    }

    public function getBackUrl()
    {
        return $this->_urlBuilder->getUrl('*/*/history');
    }

    public function getInvoiceUrl($order)
    {
        return $this->_urlBuilder->getUrl('*/*/invoice', ['order_id' => $order->getId()]);
    }

    public function getViewUrl($order)
    {
        return $this->_urlBuilder->getUrl('*/*/view', ['order_id' => $order->getId()]);
    }

    public function getCreditmemoUrl($order)
    {
        return $this->_urlBuilder->getUrl('*/*/creditmemo', ['order_id' => $order->getId()]);
    }

    public function getShipmentUrl($order)
    {
        return $this->_urlBuilder->getUrl('*/*/shipment', ['order_id' => $order->getId()]);
    }


    public function getPrintRmaUrl($rma){
        return $this->_urlBuilder->getUrl('*/*/printRma', ['rma_id' => $rma->getId()]);
    }

    public function getPrintAllRmaUrl($order){
        return $this->_urlBuilder->getUrl('*/*/printRma', ['order_id' => $order->getId()]);
    }
}
