<?php

namespace Unirgy\Rma\Controller\Adminhtml\Order\Rma;

use Magento\Backend\App\Action\Context;
use Magento\Framework\App\Config\ScopeConfigInterface;
use Magento\Framework\Exception;
use Magento\Framework\Registry;
use Magento\Sales\Model\OrderFactory;
use Magento\Store\Model\ScopeInterface;
use Unirgy\Dropship\Helper\Data as DropshipHelperData;
use Unirgy\Dropship\Model\Label\BatchFactory;
use Unirgy\Rma\Helper\Data as HelperData;
use Unirgy\Rma\Model\RmaFactory;
use Unirgy\Rma\Model\Rma\CommentFactory;

class CreateLabel extends AbstractRma
{
    /**
     * @var ScopeConfigInterface
     */
    protected $_scopeConfig;

    /**
     * @var BatchFactory
     */
    protected $_labelBatchFactory;

    /**
     * @var CommentFactory
     */
    protected $_rmaCommentFactory;

    public function __construct(
        ScopeConfigInterface $configScopeConfigInterface,
        BatchFactory $labelBatchFactory,
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
        $this->_scopeConfig = $configScopeConfigInterface;
        $this->_labelBatchFactory = $labelBatchFactory;
        $this->_rmaCommentFactory = $rmaCommentFactory;

        parent::__construct($context, $modelRmaFactory, $modelOrderFactory, $frameworkRegistry, $helperData, $dropshipHelperData, $resultForwardFactory, $resultPageFactory, $resultRedirectFactory, $resultRawFactory);
    }

    public function execute()
    {
        try {
            $hlp = $this->_rmaHlp;
            $data = $this->getRequest()->getPost('rma');
            if (empty($data['generate_label'])) {
                throw new \Exception(__('Wrong generate label request.'));
            }
            if ($rma = $this->_initRma(false)) {
                /** @var \Magento\Backend\Model\Auth $auth */
                $auth = $this->_hlp->getObj('\Magento\Backend\Model\Auth');
                $adminUser = $auth->getUser();
                $labelData = [];
                foreach (['weight','value','length','width','height','reference','package_count'] as $_glKey) {
                    if (isset($data['label_info'][$_glKey])) {
                        $labelData[$_glKey] = $data['label_info'][$_glKey];
                    }
                }
                $extraLblInfo = @$data['extra_label_info'];
                $extraLblInfo = is_array($extraLblInfo) ? $extraLblInfo : [];
                $data = array_merge($data, $extraLblInfo);

                $oldUdropshipMethod = $rma->getUdropshipMethod();
                $oldUdropshipMethodDesc = $rma->getUdropshipMethodDescription();
                if (!empty($data['label_info']['use_method_code'])) {
                    list($useCarrier, $useMethod) = explode('_', $data['label_info']['use_method_code'], 2);
                    if (!empty($useCarrier) && !empty($useMethod)) {
                        $rma->setUdropshipMethod($data['label_info']['use_method_code']);
                        $carrierMethods = $this->_rmaHlp->getCarrierMethods($useCarrier);
                        $rma->setUdropshipMethodDescription(
                            $this->_scopeConfig->getValue('carriers/'.$useCarrier.'/title', ScopeInterface::SCOPE_STORE, $rma->getOrder()->getStoreId())
                            .' - '.$carrierMethods[$useMethod]
                        );
                    }
                }

                // generate label
                $batch = $this->_labelBatchFactory->create()
                    ->setVendor($rma->getVendor())
                    ->processRmas([$rma], $labelData);

                if (!empty($data['label_info']['use_method_code'])) {
                    $rma->setUdropshipMethod($oldUdropshipMethod);
                    $rma->setUdropshipMethodDescription($oldUdropshipMethodDesc);
                    $rma->getResource()->saveAttribute($rma, 'udropship_method');
                    $rma->getResource()->saveAttribute($rma, 'udropship_method_description');
                }

                // if batch of 1 label is successfull
                if ($batch->getShipmentCnt() && $batch->getLastTrack()) {
                    if (!empty($data['comment'])) {
                        $comment = $this->_rmaCommentFactory->create()
                            ->setComment($data['comment'])
                            ->setIsCustomerNotified(isset($data['is_customer_notified']))
                            ->setIsVisibleOnFront(isset($data['is_visible_on_front']))
                            ->setUsername($adminUser->getUsername())
                            ->setRmaStatus($rma->getRmaStatus());
                        $rma->addComment($comment);
                    }
                    $rma->setData('__dummy',1)->save();
                    $rma->sendUpdateEmail(!empty($data['is_customer_notified']), @$data['comment']);
                    $this->messageManager->addSuccess('Label was succesfully created');
                } else {
                    if ($batch->getErrors()) {
                        $errs = [];
                        foreach ($batch->getErrors() as $error=>$cnt) {
                            $errs[] = __($error, $cnt);
                        }
                        throw new \Exception(implode("\n", $errs));
                    }
                }

                $response = [
                    'ajaxExpired'  => true,
                    'ajaxRedirect' => $this->getUrl('*/*/view', ['rma_id' => $this->getRequest()->getParam('rma_id')])
                ];
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
