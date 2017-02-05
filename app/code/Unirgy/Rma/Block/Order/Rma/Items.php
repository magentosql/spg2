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
 * Sales order view items block
 *
 * @category   Mage
 * @package    Magento_Sales
 * @author     Magento Core Team <core@magentocommerce.com>
 */
namespace Unirgy\Rma\Block\Order\Rma;

use Magento\Framework\Registry;
use Magento\Framework\View\Element\Template\Context;
use Magento\Sales\Block\Items\AbstractItems;

class Items extends AbstractItems
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

    /**
     * Retrieve current order model instance
     *
     * @return \Magento\Sales\Model\Order
     */
    public function getOrder()
    {
        return $this->_coreRegistry->registry('current_order');
    }

    public function getPrintRmaUrl($rma){
        return $this->_urlBuilder->getUrl('*/*/printRma', ['rma_id' => $rma->getId()]);
    }

    public function getPrintAllRmasUrl($order){
        return $this->_urlBuilder->getUrl('*/*/printRma', ['order_id' => $order->getId()]);
    }

    public function getCommentsHtml($rma)
    {
        $html = '';
        $comments = $this->getChildBlock('rma_comments');
        if ($comments) {
            $comments->setEntity($rma)
                ->setTitle(__('About Your Return'));
            $html = $comments->toHtml();
        }
        return $html;
    }
}
