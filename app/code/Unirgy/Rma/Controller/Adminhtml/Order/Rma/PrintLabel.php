<?php

namespace Unirgy\Rma\Controller\Adminhtml\Order\Rma;

use Magento\Backend\App\Action\Context;
use Magento\Framework\Exception;
use Magento\Framework\Registry;
use Magento\Sales\Model\OrderFactory;
use Unirgy\Dropship\Helper\Data as DropshipHelperData;
use Unirgy\Dropship\Model\Label\BatchFactory;
use Unirgy\Rma\Helper\Data as HelperData;
use Unirgy\Rma\Model\RmaFactory;

class PrintLabel extends AbstractRma
{
    /**
     * @var BatchFactory
     */
    protected $_labelBatchFactory;

    public function __construct(
        BatchFactory $labelBatchFactory,
        Context $context,
        RmaFactory $modelRmaFactory,
        OrderFactory $modelOrderFactory,
        Registry $frameworkRegistry,
        HelperData $helperData,
        DropshipHelperData $dropshipHelperData,
        \Magento\Backend\Model\View\Result\ForwardFactory $resultForwardFactory,
        \Magento\Framework\View\Result\PageFactory $resultPageFactory,
        \Magento\Framework\Controller\Result\RedirectFactory $resultRedirectFactory,
        \Magento\Framework\Controller\Result\RawFactory $resultRawFactory
    )
    {
        $this->_labelBatchFactory = $labelBatchFactory;

        parent::__construct($context, $modelRmaFactory, $modelOrderFactory, $frameworkRegistry, $helperData, $dropshipHelperData, $resultForwardFactory, $resultPageFactory, $resultRedirectFactory, $resultRawFactory);
    }

    public function execute()
    {
        try {
            if ($rma = $this->_initRma(false)) {
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
            $response = $this->_hlp->jsonEncode($response);
        }
        return $this->_resultRawFactory->create()->setContents($response);
    }
}
