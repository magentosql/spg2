<?php

namespace Unirgy\Rma\Controller\Adminhtml\Order\Rma;

use Magento\Backend\App\Action\Context;
use Magento\Framework\Registry;
use Magento\Framework\View\LayoutFactory;
use Magento\Sales\Model\OrderFactory;
use Unirgy\Dropship\Helper\Data as DropshipHelperData;
use Unirgy\Rma\Helper\Data as HelperData;
use Unirgy\Rma\Model\RmaFactory;
use Unirgy\Rma\Model\Rma\TrackFactory;

class RemoveTrack extends AbstractRma
{
    /**
     * @var TrackFactory
     */
    protected $_rmaTrackFactory;

    public function __construct(
        TrackFactory $rmaTrackFactory,
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
        $this->_rmaTrackFactory = $rmaTrackFactory;

        parent::__construct($context, $modelRmaFactory, $modelOrderFactory, $frameworkRegistry, $helperData, $dropshipHelperData, $resultForwardFactory, $resultPageFactory, $resultRedirectFactory, $resultRawFactory);
    }

    public function execute()
    {
        $trackId    = $this->getRequest()->getParam('track_id');
        $rmaId = $this->getRequest()->getParam('rma_id');
        $track = $this->_rmaTrackFactory->create()->load($trackId);
        if ($track->getId()) {
            try {
                if ($rmaId = $this->_initRma(false)) {
                    $track->delete();

                    $this->_view->loadLayout();
                    $response = $this->_view->getLayout()->getBlock('rma_tracking')->toHtml();
                } else {
                    $response = [
                        'error'     => true,
                        'message'   => __('Cannot initialize rma for delete tracking number.'),
                    ];
                }
            } catch (\Exception $e) {
                $response = [
                    'error'     => true,
                    'message'   => __('Cannot delete tracking number.'),
                ];
            }
        } else {
            $response = [
                'error'     => true,
                'message'   => __('Cannot load track with retrieving identifier.'),
            ];
        }
        if (is_array($response)) {
            $response = $this->_hlp->jsonEncode($response);
        }
        return $this->_resultRawFactory->create()->setContents($response);
    }
}
