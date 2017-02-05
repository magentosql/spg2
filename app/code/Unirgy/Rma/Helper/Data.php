<?php

namespace Unirgy\Rma\Helper;

use Magento\Backend\Model\UrlFactory;
use Magento\Framework\App\Helper\AbstractHelper;
use Magento\Framework\App\Helper\Context;
use Magento\Framework\App\ObjectManager;
use Magento\Store\Model\ScopeInterface;
use Unirgy\Dropship\Helper\Data as HelperData;
use Unirgy\Rma\Model\RmaFactory;

class Data extends AbstractHelper
{
    /**
     * @var HelperData
     */
    protected $_hlp;

    /**
     * @var ProtectedCode
     */
    protected $_rmaHlpPr;

    /**
     * @var RmaFactory
     */
    protected $_rmaFactory;

    /**
     * @var UrlFactory
     */
    protected $_modelUrlFactory;

    protected $inlineTranslation;
    protected $_transportBuilder;

    public function __construct(
        \Unirgy\Dropship\Model\EmailTransportBuilder $transportBuilder,
        \Magento\Framework\Translate\Inline\StateInterface $inlineTranslation,
        Context $context,
        HelperData $helperData,
        ProtectedCode $helperProtectedCode,
        RmaFactory $modelRmaFactory, 
        UrlFactory $modelUrlFactory
    )
    {
        $this->_transportBuilder = $transportBuilder;
        $this->inlineTranslation = $inlineTranslation;
        $this->_hlp = $helperData;
        $this->_rmaHlpPr = $helperProtectedCode;
        $this->_rmaFactory = $modelRmaFactory;
        $this->_modelUrlFactory = $modelUrlFactory;

        parent::__construct($context);
    }

    public function src()
    {
        return $this->_hlp->getObj('\Unirgy\Rma\Model\Source');
    }

    public function addVendorSkus($rma)
    {
        $orderItemIds = [];
        foreach ($rma->getAllItems() as $rItem) {
            $orderItemIds[] = $rItem->getOrderItemId();
        }
        $res = $this->_hlp->rHlp();
        $read = $res->getConnection();
        if ($this->_hlp->isUdpoActive()) {
            $table = $res->getTableName('udropship_po_item');
        } else {
            $table = $res->getTableName('sales_shipment_item');
        }
        $select = $read->select()
            ->from(['item'=>$table], ['order_item_id', 'vendor_sku', 'vendor_simple_sku'])
            ->where('order_item_id in (?)', $orderItemIds);
        $rows = $read->fetchAll($select);
        foreach ($rows as $row) {
            foreach ($rma->getAllItems() as $rItem) {
                if ($rItem->getOrderItemId()==$row['order_item_id']) {
                    $rItem->setVendorSku($row['vendor_sku']);
                    $rItem->setVendorSimpleSku($row['vendor_simple_sku']);
                    break;
                }
            }
        }
        return $this;
    }
    public function getOrderItemQtyToUrma($item, $skipDummy=false)
    {
        if ($item->isDummy(true) && !$skipDummy) {
            return 0;
        }
        $qty = $item->getQtyShipped()
            - $item->getQtyUrma();
        return max($qty, 0);
    }
    public function getRmaStatusName($status)
    {
        $statuses = $this->src()->setPath('rma_status')->toOptionHash();
        return isset($statuses[$status]) ? $statuses[$status] : (in_array($status, $statuses) ? $status : 'Unknown');
    }
    public function getVendorRmaStatuses()
    {
        return $this->src()->setPath('rma_status')->toOptionHash();
    }
    public function processRmaStatusSave($rma, $status, $save, $vendor=false, $comment='', $isVendorNotified=null, $isVisibleToVendor=null)
    {
        $isVendorNotified  = is_null($isVendorNotified) ? false : $isVendorNotified;
        $isVisibleToVendor = is_null($isVisibleToVendor) ? true : $isVisibleToVendor;
        if ($rma->getRmaStatus() != $status) {
            $oldStatus = $rma->getRmaStatus();
            $this->_eventManager->dispatch(
                'udropship_rma_status_save_before',
                ['rma'=>$rma, 'old_status'=>$oldStatus, 'new_status'=>$status]
            );
            $rma->setRmaStatus($status);
            $_comment = '';
            if ($vendor) {
                $_comment = sprintf("[%s changed RMA status from '%s' to '%s']",
                    $vendor->getVendorName(),
                    $this->getRmaStatusName($oldStatus),
                    $this->getRmaStatusName($status)
                );
            } else {
                $_comment = sprintf("[RMA status changed from '%s' to '%s']",
                    $this->getRmaStatusName($oldStatus),
                    $this->getRmaStatusName($status)
                );
            }
            if (!empty($comment)) {
                $_comment = $comment."\n\n".$_comment;
            }
            $rma->addComment($_comment, false, false, $isVendorNotified, $isVisibleToVendor);
            $rma->getResource()->saveAttribute($rma, 'rma_status');
            $rma->saveComments();
            $this->_eventManager->dispatch(
                'udropship_rma_status_save_after',
                ['rma'=>$rma, 'old_status'=>$oldStatus, 'new_status'=>$status]
            );
        }
        return $this;
    }
    public function initOrderRmasCollection($order, $forceReload=false)
    {
        if (!$order->hasRmasCollection() || $forceReload) {
            $rmasCollection = $this->_rmaFactory->create()->getCollection()
                ->setOrderFilter($order);
            $order->setRmasCollection($rmasCollection);

            if ($order->getId()) {
                foreach ($rmasCollection as $rma) {
                    $rma->setOrder($order);
                }
            }
            $order->setHasUrmas(count($rmasCollection));
        }
        return $this;
    }

    public function hasRMA($order)
    {
        $rHlp = $this->_hlp->rHlp();
        $conn = $rHlp->getConnection();
        $checkSql = $conn->select()->from($rHlp->getTable('urma_rma'))->columns(['count(*)'])->where('order_id=?', $order->getId());
        $res = $conn->fetchOne($checkSql);
        return $res;
    }
    public function canRMA($order)
    {
        $hasShipments = $order->hasShipments();
        $hasItemToRma = false;
        foreach ($order->getAllItems() as $orderItem) {
            if ($this->getOrderItemQtyToUrma($orderItem)) {
                $hasItemToRma = true;
                break;
            }
        }
        return $hasShipments && $hasItemToRma;
    }

    public function getRMAViewUrl($order)
    {
        return $this->_urlBuilder->getUrl('sales/order/rma', ['order_id' => $order->getId()]);
    }

    public function getRMAUrl($order)
    {
        return $this->_urlBuilder->getUrl('sales/order/newRma', ['order_id' => $order->getId()]);
    }

    public function beforeRmaLabel($vendor, $rma)
    {
        $this->_rmaHlpPr->beforeRmaLabel($vendor, $rma);
        return $this;
    }

    public function afterRmaLabel($vendor, $rma)
    {
        $this->_rmaHlpPr->afterRmaLabel($vendor, $rma);
        return $this;
    }

    protected $_vendorRmaCollection;

    public function getVendorRmaCollection()
    {
        if (!$this->_vendorRmaCollection) {
            /** @var \Magento\Framework\Stdlib\DateTime\TimezoneInterface $localeDate */
            $localeDate = $this->_hlp->getObj('\Magento\Framework\Stdlib\DateTime\TimezoneInterface');
            $datetimeFormatInt = \Magento\Framework\Stdlib\DateTime::DATETIME_INTERNAL_FORMAT;
            $dateFormat = $localeDate->getDateFormat(\IntlDateFormatter::SHORT);
            $vendorId = $this->_hlp->session()->getVendorId();
            $vendor = $this->_hlp->getVendor($vendorId);
            $collection = $this->_rmaFactory->create()->getCollection();
            $collection->join('sales_order', "sales_order.entity_id=main_table.order_id", [
                'order_increment_id' => 'increment_id',
                'order_created_at' => 'created_at',
                'shipping_method',
            ]);

            $collection->addAttributeToFilter('main_table.udropship_vendor', $vendorId);

            $r = $this->_request;

            if (($v = $r->getParam('filter_order_id_from'))) {
                $collection->addAttributeToFilter("sales_order.increment_id", ['gteq'=>$v]);
            }
            if (($v = $r->getParam('filter_order_id_to'))) {
                $collection->addAttributeToFilter("sales_order.increment_id", ['lteq'=>$v]);
            }

            if (($v = $r->getParam('filter_order_date_from'))) {
                $_filterDate = $this->_hlp->dateLocaleToInternal($v, $dateFormat, true);
                $_filterDate = $localeDate->date($_filterDate, null, false);
                $_filterDate = datefmt_format_object($_filterDate, $datetimeFormatInt);
                $collection->addAttributeToFilter("sales_order.created_at", ['gteq'=>$_filterDate]);
            }
            if (($v = $r->getParam('filter_order_date_to'))) {
                $_filterDate = $this->_hlp->dateLocaleToInternal($v, $dateFormat, true);
                $_filterDate = $localeDate->date($_filterDate, null, false);
                $_filterDate->add(new \DateInterval('P1D'));
                $_filterDate->sub(new \DateInterval('PT1S'));
                $_filterDate = datefmt_format_object($_filterDate, $datetimeFormatInt);
                $collection->addAttributeToFilter("sales_order.created_at", ['lteq'=>$_filterDate]);
            }

            if (($v = $r->getParam('filter_rma_id_from'))) {
                $collection->addAttributeToFilter('main_table.increment_id', ['gteq'=>$v]);
            }
            if (($v = $r->getParam('filter_rma_id_to'))) {
                $collection->addAttributeToFilter('main_table.increment_id', ['lteq'=>$v]);
            }

            if (($v = $r->getParam('filter_rma_date_from'))) {
                $_filterDate = $this->_hlp->dateLocaleToInternal($v, $dateFormat, true);
                $_filterDate = $localeDate->date($_filterDate, null, false);
                $_filterDate = datefmt_format_object($_filterDate, $datetimeFormatInt);
                $collection->addAttributeToFilter('main_table.created_at', ['gteq'=>$_filterDate]);
            }
            if (($v = $r->getParam('filter_rma_date_to'))) {
                $_filterDate = $this->_hlp->dateLocaleToInternal($v, $dateFormat, true);
                $_filterDate = $localeDate->date($_filterDate, null, false);
                $_filterDate->add(new \DateInterval('P1D'));
                $_filterDate->sub(new \DateInterval('PT1S'));
                $_filterDate = datefmt_format_object($_filterDate, $datetimeFormatInt);
                $collection->addAttributeToFilter('main_table.created_at', ['lteq'=>$_filterDate]);
            }

            if (!$r->getParam('apply_filter') && $vendor->getData('vendor_rma_grid_status_filter')) {
                $filterStatuses = $vendor->getData('vendor_rma_grid_status_filter');
                $filterStatuses = array_combine($filterStatuses, array_fill(0, count($filterStatuses), 1));
                $r->setParam('filter_status', $filterStatuses);
            }

            if (($v = $r->getParam('filter_status'))) {
                $collection->addAttributeToFilter('main_table.rma_status', ['in'=>array_keys($v)]);
            }
            if (($v = $r->getParam('filter_reason'))) {
                $collection->addAttributeToFilter('main_table.rma_reason', ['in'=>array_keys($v)]);
            }

            if (!$r->getParam('sort_by') && $vendor->getData('vendor_rma_grid_sortby')) {
                $r->setParam('sort_by', $vendor->getData('vendor_rma_grid_sortby'));
                $r->setParam('sort_dir', $vendor->getData('vendor_rma_grid_sortdir'));
            }
            if (($v = $r->getParam('sort_by'))) {
                $map = ['order_date'=>'order_created_at', 'rma_date'=>'created_at'];
                if (isset($map[$v])) {
                    $v = $map[$v];
                }
                $collection->setOrder($v, $r->getParam('sort_dir'));
            }
            $this->_vendorRmaCollection = $collection;
        }
        return $this->_vendorRmaCollection;
    }

    public function sendVendorComment($urma, $comment, $notify=false, $visibleOnFront=false)
    {
        $store = $urma->getStore();
        $to = $this->_hlp->getScopeConfig('urma/general/vendor_comments_receiver', $store);
        $subject = $this->_hlp->getScopeConfig('urma/general/vendor_comments_subject', $store);
        $template = $this->_hlp->getScopeConfig('urma/general/vendor_comments_template', $store);
        $vendor = $urma->getVendor();
        $ahlp = $this->_modelUrlFactory->create();

        if ($subject && $template && $vendor->getId()) {
            $toEmail = $this->_hlp->getScopeConfig('trans_email/ident_'.$to.'/email', $store);
            $toName = $this->_hlp->getScopeConfig('trans_email/ident_'.$to.'/name', $store);
            $data = [
                'vendor_name'   => $vendor->getVendorName(),
                'order_id'         => $urma->getOrder()->getIncrementId(),
                'rma_id'         => $urma->getIncrementId(),
                'vendor_url'    => $ahlp->getUrl('udropship/vendor/edit', [
                    'id'        => $vendor->getId(),
                    '_store'    => 0
                ]),
                'order_url'     => $ahlp->getUrl('sales/order/view', [
                    'order_id'  => $urma->getOrder()->getId(),
                    '_store'    => 0
                ]),
                'rma_url'  => $ahlp->getUrl('urma/order_rma/view', [
                    'rma_id'  => $urma->getId(),
                    '_store'    => 0
                ]),
                'comment'      => $comment,
            ];
            foreach ($data as $k=>$v) {
                $subject = str_replace('{{'.$k.'}}', $v, $subject);
                $template = str_replace('{{'.$k.'}}', $v, $template);
            }

            /** @var \Magento\Framework\Mail\Message $message */
            $message = $this->_hlp->createObj('Magento\Framework\Mail\Message');
            $message->setMessageType(\Magento\Framework\Mail\MessageInterface::TYPE_TEXT)
                ->setFrom($vendor->getEmail(), $vendor->getVendorName())
                ->addTo($toEmail, $toName)
                ->setSubject($subject)
                ->setBodyText($template);
            $transport = $this->_hlp->createObj('Magento\Framework\Mail\TransportInterface', ['message' => $message]);
            $transport->sendMessage();
        }

        $urma->addComment(__($vendor->getVendorName().': '.$comment), $notify, $visibleOnFront, true, true)->saveComments();

        if ($notify) {
            $urma->sendUpdateEmail($notify, __($vendor->getVendorName().': '.$comment));
        }

        return $this;
    }

    public function sendNewRmaNotificationEmail($rma, $comment='')
    {
        $order = $rma->getOrder();
        $store = $order->getStore();

        $vendor = $rma->getVendor();

        $hlp = $this->_hlp;
        $data = [];

        $this->inlineTranslation->suspend();

        $hlp->assignVendorSkus($rma);

        $shippingAddress = $order->getShippingAddress();
        if (!$shippingAddress) {
            $shippingAddress = $order->getBillingAddress();
        }
        $data += [
            'rma'              => $rma,
            'order'           => $order,
            'vendor'          => $vendor,
            'comment'         => $comment,
            'is_admin_comment'=> $comment&&$rma->getIsAdmin(),
            'is_customer_comment'=> $comment&&$rma->getIsCustomer(),
            'store_name'      => $store->getName(),
            'vendor_name'     => $vendor->getVendorName(),
            'rma_id'           => $rma->getIncrementId(),
            'order_id'        => $order->getIncrementId(),
            'customer_info'   => $this->_hlp->formatCustomerAddress($shippingAddress, 'html', $vendor),
            'rma_url'          => $this->_urlBuilder->getUrl('urma/vendor/', ['_query'=>'filter_rma_id_from='.$rma->getIncrementId().'&filter_rma_id_to='.$rma->getIncrementId()]),
        ];

        $template = $this->_hlp->getScopeConfig('urma/general/new_rma_vendor_email_template', $store);
        $identity = $this->_hlp->getScopeConfig('udropship/vendor/vendor_email_identity', $store);

        $data['_BCC'] = $vendor->getNewOrderCcEmails();
        if (($emailField = $this->_hlp->getScopeConfig('udropship/vendor/vendor_notification_field', $store))) {
            $email = $vendor->getData($emailField) ? $vendor->getData($emailField) : $vendor->getEmail();
        } else {
            $email = $vendor->getEmail();
        }

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
            $identity
        )->addTo(
            $email,
            $vendor->getVendorName()
        );

        $transport = $this->_transportBuilder->getTransport();
        $transport->sendMessage();

        $hlp->unassignVendorSkus($rma);

        $this->inlineTranslation->resume();
    }


    public function sendRmaCommentNotificationEmail($rma, $comment)
    {
        $order = $rma->getOrder();
        $store = $order->getStore();

        $vendor = $rma->getVendor();

        $hlp = $this->_hlp;
        $data = [];

        $this->inlineTranslation->suspend();

        $data += [
            'rma'              => $rma,
            'order'           => $order,
            'vendor'          => $vendor,
            'comment'         => $comment,
            'store_name'      => $store->getName(),
            'vendor_name'     => $vendor->getVendorName(),
            'rma_id'           => $rma->getIncrementId(),
            'rma_status'       => $rma->getRmaStatusName(),
            'order_id'        => $order->getIncrementId(),
            'rma_url'          => $this->_urlBuilder->getUrl('urma/vendor/', ['_query'=>'filter_rma_id_from='.$rma->getIncrementId().'&filter_rma_id_to='.$rma->getIncrementId()]),
        ];

        $template = $this->_hlp->getScopeConfig('urma/general/rma_comment_vendor_email_template', $store);
        $identity = $this->_hlp->getScopeConfig('udropship/vendor/vendor_email_identity', $store);

        $data['_BCC'] = $vendor->getNewOrderCcEmails();
        if (($emailField = $this->_hlp->getScopeConfig('udropship/vendor/vendor_notification_field', $store))) {
            $email = $vendor->getData($emailField) ? $vendor->getData($emailField) : $vendor->getEmail();
        } else {
            $email = $vendor->getEmail();
        }

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
            $identity
        )->addTo(
            $email,
            $vendor->getVendorName()
        );

        $transport = $this->_transportBuilder->getTransport();
        $transport->sendMessage();

        $this->inlineTranslation->resume();
    }

    public function getOptionsDefinition($cfgField, $store=null)
    {
        $optDef = $this->scopeConfig->getValue('urma/general/'.$cfgField, ScopeInterface::SCOPE_STORE, $store);
        $optDef = $this->_hlp->unserialize($optDef);
        return $optDef;
    }

    public function getOptionsDefinitionTitles($cfgField, $filterFlag=null, $filterValue=null, $store=null)
    {
        $optDef = $this->getOptionsDefinition($cfgField, $store);
        $_optDef = [];
        if (is_array($optDef)) {
            foreach ($optDef as $optd) {
                if (!$filterFlag || @$optd[$filterFlag]==$filterValue) {
                    $_optDef[@$optd['code']] = __(@$optd['title']);
                }
            }
        }
        return array_unique(array_filter($_optDef));
    }

    public function getOptionsDefinitionTitle($cfgField, $code, $store=null)
    {
        $title = $code;
        $optDef = $this->getOptionsDefinition($cfgField, $store);
        if (is_array($optDef)) {
            foreach ($optDef as $optd) {
                if ($code == @$optd['code']) {
                    $title = __($optd['title']);
                    break;
                }
            }
        }
        return $title;
    }

    public function getOptionsDefinitionExtra($cfgField, $subField, $code, $store=null)
    {
        $title = $code;
        $optDef = $this->getOptionsDefinition($cfgField, $store);
        if (is_array($optDef)) {
            foreach ($optDef as $optd) {
                if ($code == @$optd['code']) {
                    $title = __(@$optd[$subField]);
                    break;
                }
            }
        }
        return $title;
    }

    public function getReasonTitles()
    {
        return $this->getOptionsDefinitionTitles('reasons');
    }
    public function getReasonTitle($code)
    {
        return $this->getOptionsDefinitionTitle('reasons', $code);
    }
    public function getStatusTitles()
    {
        return $this->getOptionsDefinitionTitles('statuses');
    }
    public function getStatusTitle($code)
    {
        return $this->getOptionsDefinitionTitle('statuses', $code);
    }
    public function getStatusCustomerNotes($code)
    {
        return $this->getOptionsDefinitionExtra('statuses', 'customer_notes', $code);
    }
    public function getAllowedResolutionNotesStatuses()
    {
        return $this->getOptionsDefinitionTitles('statuses', 'allow_resolution_notes', 1);
    }
    public function getAllowedResolutionNotesStatusesIdsJson()
    {
        $allowed = $this->getOptionsDefinitionTitles('statuses', 'allow_resolution_notes', 1);
        return $this->_hlp->jsonEncode(array_keys($allowed));
    }
    public function getReceiverVisibleStatuses()
    {
        return $this->getOptionsDefinitionTitles('statuses', 'show_receiver', 1);
    }
    public function getItemConditionTitles()
    {
        return $this->getOptionsDefinitionTitles('item_conditions');
    }
    public function getItemConditionTitle($code)
    {
        return $this->getOptionsDefinitionTitle('item_conditions', $code);
    }

}
