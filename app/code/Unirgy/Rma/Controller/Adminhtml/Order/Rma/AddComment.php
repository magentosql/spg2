<?php

namespace Unirgy\Rma\Controller\Adminhtml\Order\Rma;

use Magento\Backend\App\Action\Context;
use Magento\Framework\Exception;
use Magento\Framework\Registry;
use Magento\Sales\Model\OrderFactory;
use Unirgy\Dropship\Helper\Data as DropshipHelperData;
use Unirgy\Rma\Helper\Data as HelperData;
use Unirgy\Rma\Model\RmaFactory;
use Unirgy\Rma\Model\Rma\CommentFactory;
use Zend\Json\Json;

class AddComment extends AbstractRma
{
    /**
     * @var CommentFactory
     */
    protected $_rmaCommentFactory;

    public function __construct(
        CommentFactory $rmaCommentFactory,
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
        $this->_rmaCommentFactory = $rmaCommentFactory;

        parent::__construct($context, $modelRmaFactory, $modelOrderFactory, $frameworkRegistry, $helperData, $dropshipHelperData, $resultForwardFactory, $resultPageFactory, $resultRedirectFactory, $resultRawFactory);
    }

    public function execute()
    {
        try {
            $data = $this->getRequest()->getPost('comment');
            $rma = $this->_initRma(false);
            if (empty($data['comment']) && $data['status']==$rma->getRmaStatus()) {
                throw new \Exception(__('Comment text field cannot be empty.'));
            }
            /** @var \Magento\Backend\Model\Auth $auth */
            $auth = $this->_hlp->getObj('\Magento\Backend\Model\Auth');
            $adminUser = $auth->getUser();

            $lhlp = $this->_rmaHlp;
            $status = $data['status'];

            if (isset($data['is_customer_notified'])) {
                $data['is_visible_on_front'] = true;
            }
            if (isset($data['is_vendor_notified'])) {
                $data['is_visible_to_vendor'] = true;
            }

            $statusSaveRes = true;
            if ($status!=$rma->getRmaStatus()) {
                $oldStatus = $rma->getRmaStatus();
                $changedComment = __("%1\n\n[%2 has changed the shipment status to %3]", $data['comment'], 'Administrator', $status);

                if (isset($data['resolution_notes'])) {
                    $rma->setResolutionNotes($data['resolution_notes']);
                }
                $rma->setRmaStatus($status)->save();
                $commentText = $changedComment;

                $comment = $this->_rmaCommentFactory->create()
                    ->setComment($commentText)
                    ->setIsCustomerNotified(isset($data['is_customer_notified']))
                    ->setIsVisibleOnFront(isset($data['is_visible_on_front']))
                    ->setIsVendorNotified(isset($data['is_vendor_notified']))
                    ->setIsVisibleToVendor(isset($data['is_visible_to_vendor']))
                    ->setUsername($adminUser->getUsername())
                    ->setRmaStatus($status);
                $rma->addComment($comment);
                $rma->sendUpdateEmail(!empty($data['is_customer_notified']), $data['comment']);
                $rma->getCommentsCollection()->save();
                if (isset($data['is_vendor_notified'])) {
                    $this->_rmaHlp->sendRmaCommentNotificationEmail($rma, $data['comment']);
                }
            } else {
                $comment = $this->_rmaCommentFactory->create()
                    ->setComment($data['comment'])
                    ->setIsCustomerNotified(isset($data['is_customer_notified']))
                    ->setIsVisibleOnFront(isset($data['is_visible_on_front']))
                    ->setIsVendorNotified(isset($data['is_vendor_notified']))
                    ->setIsVisibleToVendor(isset($data['is_visible_to_vendor']))
                    ->setUsername($adminUser->getUsername())
                    ->setRmaStatus($status);
                $rma->addComment($comment);
                if (isset($data['resolution_notes'])) {
                    $rma->setResolutionNotes($data['resolution_notes']);
                }
                $rma->sendUpdateEmail(!empty($data['is_customer_notified']), $data['comment']);
                $rma->getCommentsCollection()->save();
                if (isset($data['is_vendor_notified'])) {
                    $this->_rmaHlp->sendRmaCommentNotificationEmail($rma, $data['comment']);
                }
            }

            $this->_view->loadLayout();
            $response = $this->_view->getLayout()->getBlock('order_comments')->toHtml();
        } catch (\Magento\Framework\Exception\LocalizedException $e) {
            $response = [
                'error'     => true,
                'message'   => $e->getMessage()
            ];
        } catch (\Exception $e) {
            $response = [
                'error'     => true,
                'message'   => __('Cannot add new comment.')
            ];
        }
        if (is_array($response)) {
            $response = $this->_hlp->jsonEncode($response);
        }
        return $this->_resultRawFactory->create()->setContents($response);
    }
}
