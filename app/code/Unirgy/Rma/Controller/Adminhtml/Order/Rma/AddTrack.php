<?php

namespace Unirgy\Rma\Controller\Adminhtml\Order\Rma;

use Magento\Backend\App\Action\Context;
use Magento\Framework\Exception;
use Magento\Framework\Registry;
use Magento\Framework\View\LayoutFactory;
use Magento\Sales\Model\OrderFactory;
use Unirgy\Dropship\Helper\Data as DropshipHelperData;
use Unirgy\Rma\Helper\Data as HelperData;
use Unirgy\Rma\Model\RmaFactory;
use Unirgy\Rma\Model\Rma\TrackFactory;

class AddTrack extends AbstractRma
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
        try {
            $carrier = $this->getRequest()->getPost('carrier');
            $number  = $this->getRequest()->getPost('number');
            $finalPrice = $this->getRequest()->getPost('final_price');
            $title  = $this->getRequest()->getPost('title');
            if (empty($carrier)) {
                throw new \Exception(__('The carrier needs to be specified.'));
            }
            if (empty($number)) {
                throw new \Exception(__('Tracking number cannot be empty.'));
            }
            if ($rma = $this->_initRma(false)) {
                $track = $this->_rmaTrackFactory->create()
                    ->setTrackNumber($number)
                    ->setFinalPrice($finalPrice)
                    ->setCarrierCode($carrier)
                    ->setTitle($title);
                $rma->addTrack($track)->save();

                $this->_view->loadLayout();
                $response = $this->_view->getLayout()->getBlock('rma_tracking')->toHtml();
            } else {
                $response = [
                    'error'     => true,
                    'message'   => __('Cannot initialize rma for adding tracking number.'),
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
                'message'   => __('Cannot add tracking number.'),
            ];
        }
        if (is_array($response)) {
            $response = $this->_hlp->jsonEncode($response);
        }
        return $this->_resultRawFactory->create()->setContents($response);
    }
}
