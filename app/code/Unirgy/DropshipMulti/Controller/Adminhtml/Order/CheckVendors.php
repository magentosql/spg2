<?php

namespace Unirgy\DropshipMulti\Controller\Adminhtml\Order;

use Magento\Backend\App\Action\Context;
use Magento\Sales\Model\OrderFactory;
use Magento\Sales\Model\Order\ItemFactory;
use Unirgy\DropshipMulti\Helper\Data as HelperData;
use Unirgy\Dropship\Helper\ProtectedCode;
use Unirgy\Dropship\Model\Stock\Availability;
use Magento\Framework\Controller\ResultFactory;

class CheckVendors extends AbstractOrder
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
     * @var ItemFactory
     */
    protected $_orderItemFactory;

    /**
     * @var ProtectedCode
     */
    protected $_hlpPr;

    /**
     * @var Availability
     */
    protected $_stockAvailability;

    /** @var \Unirgy\Dropship\Helper\Data */
    protected $_hlp;

    public function __construct(
        Context $context,
        \Unirgy\Dropship\Helper\Data $udropshipHelper,
        HelperData $multiHelper,
        OrderFactory $modelOrderFactory, 
        ItemFactory $orderItemFactory, 
        ProtectedCode $udropshipProtected,
        Availability $stockAvailability
    )
    {
        $this->_hlp = $udropshipHelper;
        $this->_multiHlp = $multiHelper;
        $this->_orderFactory = $modelOrderFactory;
        $this->_orderItemFactory = $orderItemFactory;
        $this->_hlpPr = $udropshipProtected;
        $this->_stockAvailability = $stockAvailability;

        parent::__construct($context);
    }

    public function execute()
    {
        $result = [];
        try {
            // get parameters
            $orderId = $this->getRequest()->getParam('order_id');
            $vendors = $this->getRequest()->getParam('vendors');
            $hlp = $this->_multiHlp;

            if (!$this->getRequest()->getPost() || !$orderId || !$vendors) {
                throw new \Exception(__('Invalid parameters.'));
            }

            $items = $this->_orderFactory->create()->load($orderId)
                ->getAllItems();
            $this->_hlpPr->reassignApplyStockAvailability($items);

            $availability = $this->_stockAvailability;

            foreach ($items as $item) {
                if ($item->getProductType()=='configurable') {
                    $children = $item->getChildrenItems() ? $item->getChildrenItems() : $item->getChildren();
                    foreach ($children as $child) {
                        foreach ($child->getUdropshipStockLevels() as $vId=>$status) {
                            $result['stock'][$item->getId()][$vId] = $status || $item->getUdropshipVendor()==$vId;
                        }
                        break;
                    }
                } else {
                    foreach ($item->getUdropshipStockLevels() as $vId=>$status) {
                        $result['stock'][$item->getId()][$vId] = $status || $item->getUdropshipVendor()==$vId;
                    }
                }
            }

            $result['message'] = '<span class="success">'.__('The vendors stock has been checked successfully.').'</span>';
        } catch (\Exception $e) {
            $result['message'] = '<span class="error">'.$e->getMessage().'</span>';
        }
        return $this->resultFactory->create(ResultFactory::TYPE_RAW)->setContents($this->_hlp->jsonEncode($result));
    }
}
