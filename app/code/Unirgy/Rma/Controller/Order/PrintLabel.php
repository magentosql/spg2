<?php

namespace Unirgy\Rma\Controller\Order;

use Magento\Framework\App\ObjectManager;
use Magento\Framework\Exception;
use Magento\Framework\Registry;
use Magento\Sales\Model\OrderFactory;
use Unirgy\Dropship\Helper\Data as DropshipHelperData;
use Unirgy\Dropship\Model\Label\BatchFactory;
use Unirgy\Rma\Helper\Data as HelperData;

class PrintLabel extends AbstractOrder
{
    /**
     * @var BatchFactory
     */
    protected $_labelBatchFactory;

    public function __construct(
        BatchFactory $labelBatchFactory,
        $rmaFactory,
        OrderFactory $orderFactory,
        Registry $registry,
        HelperData $urmaHelper,
        DropshipHelperData $udropshipHelper,
        \Magento\Framework\App\Action\Context $context,
        \Magento\Sales\Controller\AbstractController\OrderLoaderInterface $orderLoader,
        \Magento\Framework\View\Result\PageFactory $resultPageFactory
    )
    {
        $this->_labelBatchFactory = $labelBatchFactory;
        parent::__construct($rmaFactory, $orderFactory, $registry, $urmaHelper, $udropshipHelper, $context, $orderLoader, $resultPageFactory);
    }

    public function execute()
    {
        try {
            if ($rma = $this->_initRma()) {
                $this->_labelBatchFactory->create()
                    ->setForcedFilename('rma_label_'.$rma->getIncrementId())
                    ->setVendor($rma->getVendor())
                    ->renderRmas([$rma])
                    ->prepareLabelsDownloadResponse();
            } else {
                $response = [
                    'error'     => true,
                    'message'   => __('Cannot initialize rma.'),
                ];
            }
        } catch (\Magento\Framework\Exception\LocalizedException $e) {
            $response = [
                'error'     => true,
                'message'   => $e->getMessage(),
            ];
        } catch (\Exception $e) {
            $response = [
                'error'     => true,
                'message'   => __('Cannot printf label.'),
            ];
        }
        if (is_array($response)) {
            $this->messageManager->addError($response['message']);
            $this->_redirect('*/*/rma', ['order_id'=>$this->getRequest()->getParam('order_id')]);
        }
    }
}
