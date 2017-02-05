<?php

namespace Unirgy\DropshipMulti\Controller\Adminhtml\Order;

use Magento\Backend\App\Action\Context;
use Magento\Sales\Model\OrderFactory;
use Unirgy\DropshipMulti\Helper\Data as HelperData;
use Unirgy\Dropship\Helper\Data as DropshipHelperData;
use Unirgy\Dropship\Helper\ProtectedCode;

class UpdateVendors extends AbstractOrder
{
    /**
     * @var HelperData
     */
    protected $_multiHlp;

    /**
     * @var OrderFactory
     */
    protected $_orderFactory;

    /**
     * @var DropshipHelperData
     */
    protected $_hlp;

    /**
     * @var ProtectedCode
     */
    protected $_hlpPr;

    public function __construct(
        Context $context,
        HelperData $helperData,
        OrderFactory $modelOrderFactory, 
        DropshipHelperData $udropshipHelper,
        ProtectedCode $udropshipProtected,
        \Magento\Framework\Controller\Result\RawFactory $resultRawFactory
    )
    {
        $this->_resultRawFactory = $resultRawFactory;
        $this->_multiHlp = $helperData;
        $this->_orderFactory = $modelOrderFactory;
        $this->_hlp = $udropshipHelper;
        $this->_hlpPr = $udropshipProtected;

        parent::__construct($context);
    }

    public function execute()
    {
        try {
            // get parameters
            $orderId = $this->getRequest()->getParam('order_id');
            $vendors = $this->getRequest()->getParam('vendors');
            $hlp = $this->_multiHlp;

            if (!$this->getRequest()->getPost() || !$orderId || !$vendors) {
                throw new \Exception(__('Invalid parameters.'));
            }

            $order = $this->_orderFactory->create()->load($orderId);
            $storeId = $order->getStoreId();

            if (!$this->_hlp->isUdropshipOrder($order)) {
                Mage::app()->getResponse()->setBody('<span class="error">Order is not dropshippable</span>');
                return;
            }
            
            $items = $order->getAllItems();

            $this->_hlpPr->reassignApplyStockAvailability($items);
            
            $hasOutOfStockError = '';
            foreach ($items as $item) {
                if ($item->isDummy(true)) continue;
                if ($item->getProductType()=='configurable') {
                    $children = $item->getChildrenItems() ? $item->getChildrenItems() : $item->getChildren();
                    foreach ($children as $child) {
                        $vendors[$child->getId()]['id'] = $vendors[$item->getId()]['id'];
                        if ($this->_hlp->getItemStockCheckQty($child)
                            && !$child->getData("udropship_stock_levels/{$vendors[$item->getId()]['id']}/status")
                            && $child->getUdropshipVendor()!=$vendors[$item->getId()]['id']
                        ) {
                            $hasOutOfStockError .= __(
                                "%1 x %2 is not available at vendor '%3'",
                                $this->_hlp->getItemStockCheckQty($child), $child->getSku(),
                                $this->_hlp->getVendorName($vendors[$item->getId()]['id'])
                            )."\n";
                        }
                        break;
                    }
                } else {
                    if ($this->_hlp->getItemStockCheckQty($item)>0
                        && !$item->getData("udropship_stock_levels/{$vendors[$item->getId()]['id']}/status")
                        && $item->getUdropshipVendor()!=$vendors[$item->getId()]['id']
                    ) {
                        $hasOutOfStockError .= __(
                            "%1 x %2 is not available at vendor '%3'",
                            $this->_hlp->getItemStockCheckQty($item), $item->getSku(),
                            $this->_hlp->getVendorName($vendors[$item->getId()]['id'])
                        )."\n";
                    }
                }
            }
            
            if (!empty($hasOutOfStockError)) throw new \Exception(trim($hasOutOfStockError));

            $result = $hlp->updateOrderItemsVendors($orderId, $vendors);

            if ($result) {
                $msg = '<span class="success">'.__('The vendors have been updated successfully.').'</span>';
            } else {
                $msg = '<span class="notice">'.__('No changes were neccessary.').'</span>';
            }
        } catch (\Exception $e) {
            $msg = '<span class="error">'.$e->getMessage().'</span>';
        }
        return $this->_resultRawFactory->create()->setContents($msg);
    }
}
