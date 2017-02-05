<?php

namespace Unirgy\Rma\Controller\Vendor;

use Magento\Backend\Model\View\Result\ForwardFactory;
use Magento\Framework\App\Action\Context;
use Magento\Framework\App\Config\ScopeConfigInterface;
use Magento\Framework\Controller\Result\RawFactory;
use Magento\Framework\HTTP\Header;
use Magento\Framework\Registry;
use Magento\Framework\View\DesignInterface;
use Magento\Framework\View\LayoutFactory;
use Magento\Framework\View\Result\PageFactory;
use Magento\Store\Model\StoreManagerInterface;
use Unirgy\Dropship\Helper\Data as HelperData;
use Unirgy\Rma\Helper\Data as RmaHelperData;
use Unirgy\Rma\Model\ResourceModel\Rma\Track\Collection;
use Unirgy\Rma\Model\RmaFactory;
use Unirgy\Rma\Model\Rma\TrackFactory;

class AddUrmaComment extends AbstractVendor
{
    /**
     * @var RmaFactory
     */
    protected $_modelRmaFactory;

    /**
     * @var TrackFactory
     */
    protected $_rmaTrackFactory;

    /**
     * @var Collection
     */
    protected $_trackCollection;

    public function __construct(Context $context, 
        ScopeConfigInterface $scopeConfig, 
        DesignInterface $viewDesignInterface, 
        StoreManagerInterface $storeManager, 
        LayoutFactory $viewLayoutFactory, 
        Registry $registry, 
        ForwardFactory $resultForwardFactory, 
        HelperData $helper, 
        PageFactory $resultPageFactory, 
        RawFactory $resultRawFactory, 
        Header $httpHeader, 
        RmaHelperData $helperData, 
        RmaFactory $modelRmaFactory, 
        TrackFactory $rmaTrackFactory, 
        Collection $trackCollection)
    {
        $this->_modelRmaFactory = $modelRmaFactory;
        $this->_rmaTrackFactory = $rmaTrackFactory;
        $this->_trackCollection = $trackCollection;

        parent::__construct($context, $scopeConfig, $viewDesignInterface, $storeManager, $viewLayoutFactory, $registry, $resultForwardFactory, $helper, $resultPageFactory, $resultRawFactory, $httpHeader, $helperData);
    }

	public function execute()
    {
        $hlp = $this->_hlp;
        $urmaHlp = $this->_rmaHlp;
        $r = $this->getRequest();
        $id = $r->getParam('id');
        $urma = $this->_modelRmaFactory->create()->load($id);
        $vendor = $hlp->getVendor($urma->getUdropshipVendor());
        $session = $this->_getSession();

        if (!$urma->getId()) {
            return;
        }

        try {
            $track = null;
            $highlight = [];

            $partial = $r->getParam('partial_availability');
            $partialQty = $r->getParam('partial_qty');

            $number = $r->getParam('tracking_id');
            $carrier = $r->getParam('carrier');
            $title  = $r->getParam('carrier_title');

            $rmaStatus = $r->getParam('status');

            if ($number) { // if tracking id was added manually
                $track = $this->_rmaTrackFactory->create()
                    ->setTrackNumber($number)
                    ->setCarrierCode($carrier)
                    ->setTitle($title);

                $urma->addTrack($track);

                $urma->addComment(
                    __('%1 added tracking ID %2', $vendor->getVendorName(), $number),
                    false, true
                );
                $urma->setData('___dummy',1)->save();
                $this->messageManager->addSuccess(__('Tracking ID has been added'));

                $highlight['tracking'] = true;
            }
            
            if (!is_null($rmaStatus) && $rmaStatus!=='' && $rmaStatus!=$urma->getUdropshipStatus()) {
                $rmaStatusChanged = $urmaHlp->processRmaStatusSave($urma, $rmaStatus, true, $vendor);
                if ($rmaStatusChanged) {
                    $this->messageManager->addSuccess(__('RMA status has been changed'));
                } else {
                    $this->messageManager->addError(__('Cannot change RMA status'));
                }
            }

            $is_customer_notified = $r->getParam('is_customer_notified');
            $is_visible_on_front = $r->getParam('is_visible_on_front');
            if ($is_customer_notified) {
                $is_visible_on_front = true;
            }

            $comment = $r->getParam('comment');
            $resolutionNotes = $r->getParam('resolution_notes');
            if ($resolutionNotes!==null) {
                $urma->setResolutionNotes($resolutionNotes);
                $urma->getResource()->saveAttribute($urma, 'resolution_notes');
            }
            if ($comment || $partial=='inform' && $partialQty || $is_customer_notified && $resolutionNotes) {
                if ($partialQty) {
                    $comment .= "\n\nPartial Availability:\n";
                    foreach ($urma->getAllItems() as $item) {
                        if (empty($partialQty[$item->getId()])) {
                            continue;
                        }
                        $comment .= __('%1 x [%2] %3', $partialQty[$item->getId()], $item->getName(), $item->getSku())."\n";
                    }
                }

                $this->_rmaHlp->sendVendorComment($urma, $comment, $is_customer_notified, $is_visible_on_front);
                $this->messageManager->addSuccess(__('Your comment has been sent'));

                $highlight['comment'] = true;
            }

            $deleteTrack = $r->getParam('delete_track');
            if ($deleteTrack) {
                $track = $this->_rmaTrackFactory->create()->load($deleteTrack);
                if ($track->getId()) {
                    $track->delete();
                    if ($track->getPackageCount()>1) {
                        foreach ($this->_trackCollection
                            ->addAttributeToFilter('master_tracking_id', $track->getMasterTrackingId())
                            as $_track
                        ) {
                            $_track->delete();
                        }
                    }
                    $urma->addComment(
                        __('%1 added tracking ID %2', $vendor->getVendorName(), $number),
                        false, true
                    );
                    $urma->saveComments();
                    #$save = true;
                    $highlight['tracking'] = true;
                    $this->messageManager->addSuccess(__('Track %1 was deleted', $track->getTrackNumber()));
                } else {
                    $this->messageManager->addError(__('Track %1 was not found', $track->getTrackNumber()));
                }
            }

            $session->setHighlight($highlight);
        } catch (\Exception $e) {
            $this->messageManager->addError($e->getMessage());
        }

        $this->_forward('urmaInfo');
    }
}
