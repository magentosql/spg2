<?php

namespace Unirgy\Rma\Model;

use Magento\Framework\Api\AttributeValueFactory;
use Magento\Framework\Api\ExtensionAttributesFactory;
use Magento\Framework\App\Config\ScopeConfigInterface;
use Magento\Framework\Data\Collection\AbstractDb;
use Magento\Framework\Model\Context;
use Magento\Framework\Model\ResourceModel\AbstractResource;
use Magento\Framework\Registry;
use Magento\Payment\Helper\Data as PaymentHelperData;
use Magento\Sales\Model\AbstractModel;
use Magento\Sales\Model\Order;
use Magento\Sales\Model\OrderFactory;
use Magento\Store\Model\ScopeInterface;
use Unirgy\Dropship\Helper\Data as HelperData;
use Unirgy\Dropship\Model\Label\BatchFactory;
use Unirgy\Rma\Helper\Data as RmaHelperData;
use Unirgy\Rma\Model\ResourceModel\Rma\Comment\Collection as CommentCollection;
use Unirgy\Rma\Model\ResourceModel\Rma\Item\Collection;
use Unirgy\Rma\Model\ResourceModel\Rma\Track\Collection as TrackCollection;
use Unirgy\Rma\Model\Rma\Comment;
use Unirgy\Rma\Model\Rma\CommentFactory;
use Unirgy\Rma\Model\Rma\Item;
use Unirgy\Rma\Model\Rma\Track;
use Magento\Sales\Model\EntityInterface;

class Rma extends AbstractModel implements EntityInterface
{
    protected $entityType = 'urma_rma';
    /**
     * @var OrderFactory
     */
    protected $_orderFactory;

    /**
     * @var Collection
     */
    protected $_itemCollection;

    /**
     * @var CommentFactory
     */
    protected $_rmaCommentFactory;

    /**
     * @var CommentCollection
     */
    protected $_commentCollection;

    /**
     * @var TrackCollection
     */
    protected $_trackCollection;

    /**
     * @var ScopeConfigInterface
     */
    protected $_scopeConfig;

    /**
     * @var HelperData
     */
    protected $_hlp;

    /**
     * @var PaymentHelperData
     */
    protected $_paymentHelperData;

    /**
     * @var BatchFactory
     */
    protected $_labelBatchFactory;

    /**
     * @var RmaHelperData
     */
    protected $_rmaHelperData;

    protected $inlineTranslation;
    protected $_transportBuilder;

    const ITEMS = 'items';
    const TRACKS = 'tracks';
    const COMMENTS = 'comments';

    public function __construct(
        \Unirgy\Dropship\Model\EmailTransportBuilder $transportBuilder,
        \Magento\Framework\Translate\Inline\StateInterface $inlineTranslation,
        Context $context,
        Registry $registry, 
        ExtensionAttributesFactory $extensionFactory, 
        AttributeValueFactory $customAttributeFactory, 
        OrderFactory $modelOrderFactory, 
        Collection $itemCollection, 
        CommentFactory $rmaCommentFactory, 
        CommentCollection $commentCollection, 
        TrackCollection $trackCollection, 
        ScopeConfigInterface $configScopeConfigInterface, 
        HelperData $helperData, 
        PaymentHelperData $paymentHelperData, 
        BatchFactory $labelBatchFactory,
        RmaHelperData $rmaHelperData,
        AbstractResource $resource = null, 
        AbstractDb $resourceCollection = null, 
        array $data = [])
    {
        $this->_transportBuilder = $transportBuilder;
        $this->inlineTranslation = $inlineTranslation;
        $this->_orderFactory = $modelOrderFactory;
        $this->_itemCollection = $itemCollection;
        $this->_rmaCommentFactory = $rmaCommentFactory;
        $this->_commentCollection = $commentCollection;
        $this->_trackCollection = $trackCollection;
        $this->_scopeConfig = $configScopeConfigInterface;
        $this->_hlp = $helperData;
        $this->_paymentHelperData = $paymentHelperData;
        $this->_labelBatchFactory = $labelBatchFactory;
        $this->_rmaHelperData = $rmaHelperData;

        parent::__construct($context, $registry, $extensionFactory, $customAttributeFactory, $resource, $resourceCollection, $data);
    }

    const XML_PATH_EMAIL_TEMPLATE               = 'sales_email/rma/template';
    const XML_PATH_EMAIL_IDENTITY               = 'sales_email/rma/identity';
    const XML_PATH_EMAIL_COPY_TO                = 'sales_email/rma/copy_to';
    const XML_PATH_EMAIL_COPY_METHOD            = 'sales_email/rma/copy_method';
    const XML_PATH_EMAIL_ENABLED                = 'sales_email/rma/enabled';

    const XML_PATH_UPDATE_EMAIL_TEMPLATE        = 'sales_email/rma_comment/template';
    const XML_PATH_UPDATE_EMAIL_IDENTITY        = 'sales_email/rma_comment/identity';
    const XML_PATH_UPDATE_EMAIL_COPY_TO         = 'sales_email/rma_comment/copy_to';
    const XML_PATH_UPDATE_EMAIL_COPY_METHOD     = 'sales_email/rma_comment/copy_method';
    const XML_PATH_UPDATE_EMAIL_ENABLED         = 'sales_email/rma_comment/enabled';

    protected $_items;
    protected $_order;
    protected $_comments;
    
    protected $_eventPrefix = 'urma_rma';
    protected $_eventObject = 'rma';
    
    protected $_commentsChanged = false;

    protected function _construct()
    {
        $this->_init('Unirgy\Rma\Model\ResourceModel\Rma');
    }

    public function loadByIncrementId($incrementId)
    {
        $ids = $this->getCollection()
            ->addAttributeToFilter('increment_id', $incrementId)
            ->getAllIds();

        if (!empty($ids)) {
            reset($ids);
            $this->load(current($ids));
        }
        return $this;
    }

    public function setOrder(Order $order)
    {
        $this->_order = $order;
        $this->setOrderId($order->getId())
            ->setStoreId($order->getStoreId());
        return $this;
    }

    public function getProtectCode()
    {
        return (string)$this->getOrder()->getProtectCode();
    }

    public function getOrder()
    {
        if (!$this->_order instanceof Order) {
            $this->_order = $this->_orderFactory->create()->load($this->getOrderId());
        }
        return $this->_order;
    }

    public function getEntityType()
    {
        return $this->entityType;
    }
    public function getIncrementId()
    {
        return $this->getData('increment_id');
    }

    public function getBillingAddress()
    {
        return $this->getOrder()->getBillingAddress();
    }

    public function getShippingAddress()
    {
        return $this->getOrder()->getShippingAddress();
    }

    public function register()
    {
        if ($this->getId()) {
            throw new \Exception(
                __('Cannot register existing rma')
            );
        }

        $totalQty = 0;
        foreach ($this->getAllItems() as $item) {
            if ($item->getQty()>0) {
                $item->register();
                if (!$item->getOrderItem()->isDummy(true)) {
                    $totalQty+= $item->getQty();
                }
            }
            else {
                $item->isDeleted(true);
            }
        }
        $this->setTotalQty($totalQty);

        return $this;
    }
    
    public function getItemsCollection()
    {
        if (empty($this->_items)) {
            $this->_items = $this->_itemCollection
                ->setRmaFilter($this->getId());

            if ($this->getId()) {
                foreach ($this->_items as $item) {
                    $item->setRma($this);
                }
            }
        }
        return $this->_items;
    }

    public function getAllItems()
    {
        $items = [];
        foreach ($this->getItemsCollection() as $item) {
            if (!$item->isDeleted()) {
                $items[] =  $item;
            }
        }
        return $items;
    }

    public function getItemById($itemId)
    {
        foreach ($this->getItemsCollection() as $item) {
            if ($item->getId()==$itemId) {
                return $item;
            }
        }
        return false;
    }

    public function addItem(Item $item)
    {
        $item->setRma($this)
            ->setParentId($this->getId())
            ->setStoreId($this->getStoreId());
        if (!$item->getId()) {
            $this->getItemsCollection()->addItem($item);
        }
        $this->_hasDataChanges = true;
        return $this;
    }
    
    public function addComment($comment, $notify=false, $visibleOnFront=false, $notifyVendor=false, $visibleToVendor=true)
    {
        $this->_commentsChanged = true;
        if (!($comment instanceof Comment)) {
            $comment = $this->_rmaCommentFactory->create()
                ->setComment($comment)
                ->setIsCustomerNotified($notify)
                ->setIsVisibleOnFront($visibleOnFront)
                ->setIsVendorNotified($notifyVendor)
                ->setIsVisibleToVendor($visibleToVendor);
        }
        $comment->setRma($this)
            ->setParentId($this->getId())
            ->setStoreId($this->getStoreId());
        if (!$comment->getId()) {
            $this->getCommentsCollection()->addItem($comment);
        }
        $this->_hasDataChanges = true;
        return $this;
    }

    public function saveComments()
    {
        if ($this->_commentsChanged) {
            foreach($this->getCommentsCollection() as $comment) {
                if (!$comment->getRmaStatus()) {
                    $comment->setRmaStatus($this->getRmaStatus());
                }
                $comment->save();
            }
        }
        return $this;
    }

    protected $_vendorComments;
    public function getVendorCommentsCollection($reload=false)
    {
        if (is_null($this->_vendorComments) || $reload) {
            $this->_vendorComments = $this->_commentCollection
                ->setRmaFilter($this->getId())
                ->addFieldToFilter('is_visible_to_vendor',1)
                ->setCreatedAtOrder();

            $this->_vendorComments->load();

            if ($this->getId()) {
                foreach ($this->_vendorComments as $comment) {
                    $comment->setRma($this);
                }
            }
        }
        return $this->_vendorComments;
    }

    public function getCommentsCollection($reload=false)
    {
        if (is_null($this->_comments) || $reload) {
            $this->_comments = $this->_commentCollection
                ->setRmaFilter($this->getId())
                ->setCreatedAtOrder();

            $this->_comments->load();

            if ($this->getId()) {
                foreach ($this->_comments as $comment) {
                    $comment->setRma($this);
                }
            }
        }
        return $this->_comments;
    }
    
    public function beforeSave()
    {
        if ((!$this->getId() || null !== $this->_items) && !count($this->getAllItems())) {
            throw new \Exception(
                __('Cannot create an empty rma.')
            );
        }

        if (!$this->getOrderId() && $this->getOrder()) {
            $this->setOrderId($this->getOrder()->getId());
            $this->setShippingAddressId($this->getOrder()->getShippingAddress()->getId());
        }
        if ($this->getData('rma_status') === null) {
            $this->setData('rma_status', 'pending');
        }

        return parent::beforeSave();
    }

    protected $_tracks;
    public function getTracksCollection()
    {
        if (empty($this->_tracks)) {
            $this->_tracks = $this->_trackCollection
                ->setRmaFilter($this->getId());

            if ($this->getId()) {
                foreach ($this->_tracks as $track) {
                    $track->setRma($this);
                }
            }
        }
        return $this->_tracks;
    }
    public function getTracks()
    {
        return $this->getTracksCollection()->getItems();
    }
    public function getItems()
    {
        return $this->getItemsCollection()->getItems();
    }
    public function getComments()
    {
        return $this->getCommentsCollection()->getItems();
    }

    public function getAllTracks()
    {
        $tracks = [];
        foreach ($this->getTracksCollection() as $track) {
            if (!$track->isDeleted()) {
                $tracks[] =  $track;
            }
        }
        return $tracks;
    }

    public function getTrackById($trackId)
    {
        foreach ($this->getTracksCollection() as $track) {
            if ($track->getId()==$trackId) {
                return $track;
            }
        }
        return false;
    }

    public function addTrack(Track $track)
    {
        $track->setRma($this)
            ->setParentId($this->getId())
            ->setStoreId($this->getStoreId());
        if (!$track->getId()) {
            $this->getTracksCollection()->addItem($track);
        }
        $this->_hasDataChanges = true;
        return $this;
    }
    
    public function getStore()
    {
        return $this->getOrder()->getStore();
    }

    public function sendUpdateEmail($notifyCustomer = true, $comment='')
    {
        $order = $this->getOrder();
        $store = $order->getStore();
        $storeId = $order->getStore()->getId();
        if (!$this->_scopeConfig->isSetFlag(self::XML_PATH_UPDATE_EMAIL_ENABLED, ScopeInterface::SCOPE_STORE, $storeId)) {
            return $this;
        }

        $this->inlineTranslation->suspend();

        $hlp = $this->_hlp;

        $order  = $this->getOrder();

        $copyTo = $this->_getEmails(self::XML_PATH_UPDATE_EMAIL_COPY_TO);
        $copyMethod = $this->_scopeConfig->getValue(self::XML_PATH_UPDATE_EMAIL_COPY_METHOD, ScopeInterface::SCOPE_STORE, $this->getStoreId());

        if (!$notifyCustomer && !$copyTo) {
            return $this;
        }

        $paymentBlock   = $this->_paymentHelperData->getInfoBlock($order->getPayment())
            ->setIsSecureMode(true);
        $paymentBlock->getMethod()->setStore($order->getStore()->getId());

        $template = $this->_scopeConfig->getValue(self::XML_PATH_UPDATE_EMAIL_TEMPLATE, ScopeInterface::SCOPE_STORE, $order->getStoreId());
        if ($order->getCustomerIsGuest()) {
            $customerName = $order->getBillingAddress()->getName();
        } else {
            $customerName = $order->getCustomerName();
        }

        $data = [];
        if ($notifyCustomer) {
            $sendTo[] = [
                'name'  => $customerName,
                'email' => $order->getCustomerEmail()
            ];
            if ($copyTo && $copyMethod == 'bcc') {
                foreach ($copyTo as $email) {
                    $data['_BCC'][] = $email;
                }
            }

        }

        if ($copyTo && ($copyMethod == 'copy' || !$notifyCustomer)) {
            foreach ($copyTo as $email) {
                $sendTo[] = [
                    'name'  => null,
                    'email' => $email
                ];
            }
        }

        if ($this->hasPrintableTracks()) {
            try {
                $lblBatch = $this->_labelBatchFactory->create()
                    ->setForcedFilename('rma_label_'.$this->getIncrementId())
                    ->setVendor($this->getVendor())
                    ->renderRmas([$this]);
                $labelModel = $this->_hlp->getLabelTypeInstance($lblBatch->getLabelType());
                $labelModel->setBatch($lblBatch);
                $data['_ATTACHMENTS'][] = $labelModel->renderBatchContent($lblBatch);
            } catch (\Exception $e) {}
        }

        $data = array_merge($data, [
            'order'       => $order,
            'rma'         => $this,
            'comment'     => $comment,
            'billing'     => $order->getBillingAddress(),
            'payment_html'=> $paymentBlock->toHtml(),
            'show_order_info'=>!$this->_scopeConfig->isSetFlag('urma/general/customer_hide_order_info', ScopeInterface::SCOPE_STORE),
            'show_receiver' => $this->isReceiverVisible(),
            'show_notes'=>$this->getStatusCustomerNotes()||($this->isAllowedResolutionNotes()&&$this->getResolutionNotes()),
            'show_both_notes'=>$this->getStatusCustomerNotes()&&($this->isAllowedResolutionNotes()&&$this->getResolutionNotes()),
            'customer_notes'=>$this->getStatusCustomerNotes(),
            'show_resolution_notes'=>$this->isAllowedResolutionNotes()&&$this->getResolutionNotes(),
            'resolution_notes'=>$this->getResolutionNotes()
        ]);

        foreach ($sendTo as $recipient) {
            $this->_transportBuilder->setTemplateIdentifier(
                $template
            )->setTemplateOptions(
                [
                    'area' => \Magento\Framework\App\Area::AREA_FRONTEND,
                    'store' => $store->getId(),
                ]
            )->setTemplateVars(
                $data
            )->setFrom(
                $this->_scopeConfig->getValue(self::XML_PATH_UPDATE_EMAIL_IDENTITY, ScopeInterface::SCOPE_STORE, $order->getStoreId())
            )->addTo(
                $recipient['email'],
                $recipient['name']
            );

            $transport = $this->_transportBuilder->getTransport();
            $transport->sendMessage();
        }

        $this->inlineTranslation->resume();

        return $this;
    }

    public function sendEmail($notifyCustomer=true, $comment='')
    {
        $order = $this->getOrder();
        $store = $order->getStore();
        $storeId = $order->getStore()->getId();
        if (!$this->_scopeConfig->isSetFlag(self::XML_PATH_EMAIL_ENABLED, ScopeInterface::SCOPE_STORE, $storeId)) {
            return $this;
        }

        $this->inlineTranslation->suspend();

        $order  = $this->getOrder();
        $copyTo = $this->_getEmails(self::XML_PATH_EMAIL_COPY_TO);
        $copyMethod = $this->_scopeConfig->getValue(self::XML_PATH_EMAIL_COPY_METHOD, ScopeInterface::SCOPE_STORE, $this->getStoreId());

        if (!$notifyCustomer && !$copyTo) {
            return $this;
        }

        $paymentBlock   = $this->_paymentHelperData->getInfoBlock($order->getPayment())
            ->setIsSecureMode(true);
        $paymentBlock->getMethod()->setStore($order->getStore()->getId());

        $template = $this->_scopeConfig->getValue(self::XML_PATH_EMAIL_TEMPLATE, ScopeInterface::SCOPE_STORE, $order->getStoreId());
        if ($order->getCustomerIsGuest()) {
            $customerName = $order->getBillingAddress()->getName();
        } else {
            $customerName = $order->getCustomerName();
        }

        $data = [];
        if ($notifyCustomer) {
            $sendTo[] = [
                'name'  => $customerName,
                'email' => $order->getCustomerEmail()
            ];
            if ($copyTo && $copyMethod == 'bcc') {
                foreach ($copyTo as $email) {
                    $data['_BCC'][] = $email;
                }
            }

        }

        if ($copyTo && ($copyMethod == 'copy' || !$notifyCustomer)) {
            foreach ($copyTo as $email) {
                $sendTo[] = [
                    'name'  => null,
                    'email' => $email
                ];
            }
        }

        if ($this->hasPrintableTracks()) {
            try {
                $lblBatch = $this->_labelBatchFactory->create()
                    ->setForcedFilename('rma_label_'.$this->getIncrementId())
                    ->setVendor($this->getVendor())
                    ->renderRmas([$this]);
                $labelModel = $this->_hlp->getLabelTypeInstance($lblBatch->getLabelType());
                $labelModel->setBatch($lblBatch);
                $data['_ATTACHMENTS'][] = $labelModel->renderBatchContent($lblBatch);
            } catch (\Exception $e) {}
        }

        $data = array_merge($data, [
            'order'       => $order,
            'rma'         => $this,
            'comment'     => $comment,
            'billing'     => $order->getBillingAddress(),
            'payment_html'=> $paymentBlock->toHtml(),
            'show_order_info'=>!$this->_scopeConfig->isSetFlag('urma/general/customer_new_hide_order_info', ScopeInterface::SCOPE_STORE),
            'show_receiver' => $this->isReceiverVisible(),
            'show_notes'=>$this->getStatusCustomerNotes()||($this->isAllowedResolutionNotes()&&$this->getResolutionNotes()),
            'show_both_notes'=>$this->getStatusCustomerNotes()&&($this->isAllowedResolutionNotes()&&$this->getResolutionNotes()),
            'customer_notes'=>$this->getStatusCustomerNotes(),
            'show_resolution_notes'=>$this->isAllowedResolutionNotes()&&$this->getResolutionNotes(),
            'resolution_notes'=>$this->getResolutionNotes()
        ]);

        foreach ($sendTo as $recipient) {
            $this->_transportBuilder->setTemplateIdentifier(
                $template
            )->setTemplateOptions(
                [
                    'area' => \Magento\Framework\App\Area::AREA_FRONTEND,
                    'store' => $store->getId(),
                ]
            )->setTemplateVars(
                $data
            )->setFrom(
                $this->_scopeConfig->getValue(self::XML_PATH_EMAIL_IDENTITY, ScopeInterface::SCOPE_STORE, $order->getStoreId())
            )->addTo(
                $recipient['email'],
                $recipient['name']
            );

            $transport = $this->_transportBuilder->getTransport();
            $transport->sendMessage();
        }

        $this->inlineTranslation->resume();

        return $this;
    }

    protected function _getEmails($configPath)
    {
        $data = $this->_scopeConfig->getValue($configPath, ScopeInterface::SCOPE_STORE, $this->getStoreId());
        if (!empty($data)) {
            return explode(',', $data);
        }
        return false;
    }

    public function getRmaStatus()
    {
        $rmaStatus = $this->getData('rma_status');
        if ($rmaStatus === null) {
            $rmaStatus = 'pending';
        }
        return $rmaStatus;
    }
    public function getRmaStatusName()
    {
        return $this->_rmaHelperData->getRmaStatusName($this->getRmaStatus());
    }
    public function getRmaReasonName()
    {
        return $this->_rmaHelperData->getReasonTitle($this->getRmaReason());
    }
    public function getStatusLabel()
    {
        return __($this->getRmaStatus());
    }
    public function getStatusCustomerNotes()
    {
        return $this->_rmaHelperData->getStatusCustomerNotes($this->getRmaStatus());
    }
    public function isAllowedResolutionNotes()
    {
        $allowed = $this->_rmaHelperData->getAllowedResolutionNotesStatuses();
        return array_key_exists($this->getRmaStatus(), $allowed);
    }
    public function isReceiverVisible()
    {
        $allowed = $this->_rmaHelperData->getReceiverVisibleStatuses();
        return array_key_exists($this->getRmaStatus(), $allowed);
    }

    public function getVendorName()
    {
        return $this->getVendor()->getVendorName();
    }

    public function getVendor()
    {
        return $this->_hlp->getVendor($this->getUdropshipVendor());
    }

    public function getRemainingWeight()
    {
        $weight = 0;
        foreach ($this->getAllItems() as $item) {
            if ($item->getOrderItem()->isDummy(true)) continue;
            $weight += $item->getWeight()*$item->getQty();
        }
        return $weight;
    }

    public function getRemainingValue()
    {
        $value = 0;
        foreach ($this->getAllItems() as $item) {
            if ($item->getOrderItem()->isDummy(true)) continue;
            $value += $item->getPrice()*$item->getQty();
        }
        return $value;
    }

    public function hasPrintableTracks()
    {
        $has = false;
        foreach ($this->getAllTracks() as $track) {
            if ($track->getLabelImage()) {
                $has = true;
                break;
            }
        }
        return $has;
    }

}
