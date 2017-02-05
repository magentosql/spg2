<?php

namespace Unirgy\Rma\Model\Label;

use Magento\Framework\App\Config\ScopeConfigInterface;
use Magento\Framework\App\Helper\AbstractHelper;
use Magento\Framework\Data\Collection\AbstractDb;
use Magento\Framework\Event\ManagerInterface;
use Magento\Framework\Model\Context;
use Magento\Framework\Model\ResourceModel\AbstractResource;
use Magento\Framework\Registry;
use Magento\Store\Model\StoreManagerInterface;
use Unirgy\Dropship\Helper\Data as HelperData;
use Unirgy\Dropship\Helper\Label;
use Unirgy\Dropship\Model\Label\Batch as LabelBatch;
use Unirgy\Rma\Helper\Data as RmaHelperData;
use Unirgy\Rma\Model\Rma\TrackFactory;

class Batch extends LabelBatch
{
    /**
     * @var RmaHelperData
     */
    protected $_rmaHlp;

    /**
     * @var TrackFactory
     */
    protected $_rmaTrackFactory;

    /**
     * @var ManagerInterface
     */
    protected $_eventManager;

    public function __construct(ScopeConfigInterface $scopeConfig, 
        HelperData $helper, 
        StoreManagerInterface $modelStoreManagerInterface, 
        Label $helperLabel, 
        Context $context, 
        Registry $registry, 
        RmaHelperData $helperData, 
        TrackFactory $rmaTrackFactory,
        AbstractResource $resource = null,
        AbstractDb $resourceCollection = null, 
        array $data = [])
    {
        $this->_rmaHlp = $helperData;
        $this->_rmaTrackFactory = $rmaTrackFactory;

        parent::__construct($scopeConfig, $helper, $modelStoreManagerInterface, $helperLabel, $context, $registry, $resource, $resourceCollection, $data);
    }

    public function processRmas($rmas, $trackData = [], $flags = [])
    {
        if (!$this->getBatchId()) {
            $this->setCreatedAt($this->_hlp->now());
            $this->setVendorId($this->getVendor()->getId());
            $this->setLabelType($this->getVendor()->getLabelType());
            $this->save();
        }

        $labelModels = [];

        $success = 0;
        $fromOrderId = null;
        $toOrderId = null;

        if (isset($trackData['weight']) && is_array($trackData['weight'])) {
            unset($trackData['weight']['$ROW']);
            $pkgLength = $pkgHeight = $pkgWidth = $pkgValue = $pkgWeight = [];
            $pcIdx=1; foreach ($trackData['weight'] as $wIdx=>$w) {
                $pkgLength[$pcIdx] = @$trackData['length'][$wIdx];
                $pkgHeight[$pcIdx] = @$trackData['height'][$wIdx];
                $pkgWidth[$pcIdx]  = @$trackData['width'][$wIdx];
                $pkgValue[$pcIdx]  = @$trackData['value'][$wIdx];
                $pkgWeight[$pcIdx] = @$trackData['weight'][$wIdx];
                $pcIdx++;
            }
            $totalWeight = array_sum($pkgWeight);
            $trackData['package_count'] = count($pkgWeight);
        }

        $transactionSave = true;
        foreach ($rmas as $rma) {
            $storeId = $rma->getOrder()->getStoreId();

            $this->_rmaHlp->beforeRmaLabel($this->getVendor(), $rma);

            $sItemIds = [];
            foreach ($rma->getAllItems() as $sItem) {
                $sItemIds[$sItem->getId()] = ['item' => $sItem];
            }

            try {
                $method = explode('_', $rma->getUdropshipMethod(), 2);
                $carrierCode = !empty($method[0]) ? $method[0] : $this->getVendor()->getCarrierCode();

                $packageCount = $carrierCode == 'fedex' && isset($trackData['package_count']) && is_numeric($trackData['package_count'])
                    ? $trackData['package_count']
                    : 1;

                if (empty($labelModels[$carrierCode])) {
                    $labelModels[$carrierCode] = $this->_hlp->getLabelCarrierInstance($carrierCode)
                        ->setBatch($this)
                        ->setVendor($this->getVendor());
                }
                $labelModels[$carrierCode]->setUdropshipPackageCount($packageCount);

                $mpsRequests = [];
                if ($this->_hlp->isUdpoMpsAvailable($carrierCode)) {
                    unset($trackData['weight']);
                    unset($trackData['value']);
                    unset($trackData['package_count']);
                    foreach ($rma->getAllItems() as $sItem) {
                        if ($sItem->getOrderItem()->getUdpompsShiptype() == Unirgy\DropshipPoMps\Model\Source::SHIPTYPE_ROW_SEPARATE) {
                            $mpsRequests[] = [
                                'items' => [$sItem->getId() => ['item' => $sItem]]
                            ];
                            unset($sItemIds[$sItem->getId()]);
                        } elseif ($sItem->getOrderItem()->getUdpompsShiptype() == Unirgy\DropshipPoMps\Model\Source::SHIPTYPE_ITEM_SEPARATE) {
                            for ($i=1; $i<=$sItem->getQty(); $i++) {
                                $splitWeight = $sItem->getOrderItem()->getUdpompsSplitWeight();
                                if (!is_array($splitWeight)) {
                                    $splitWeight = $this->_hlp->jsonDecode($splitWeight);
                                }
                                if (!empty($splitWeight) && is_array($splitWeight)) {
                                    foreach ($splitWeight as $_sWeight) {
                                        $mpsRequests[] = [
                                            'items' => [$sItem->getId() => [
                                                'item' => $sItem,
                                                'qty' => 1,
                                                'weight' => !empty($_sWeight['weight']) ? $_sWeight['weight'] : $sItem->getWeight()
                                            ]],
                                        ];
                                    }
                                } else {
                                    $mpsRequests[] = [
                                        'items' => [$sItem->getId() => ['item' => $sItem]],
                                    ];
                                }
                            }
                            unset($sItemIds[$sItem->getId()]);
                        }
                    }
                    if (!empty($sItemIds)) {
                        $mpsRequests[] = [
                            'items' => $sItemIds
                        ];
                    }
                }
                if (empty($mpsRequests)) {
                    $sItemIds = [];
                    foreach ($rma->getAllItems() as $sItem) {
                        $sItemIds[$sItem->getId()] = ['item' => $sItem];
                    }
                    for ($pcIdx=1; $pcIdx<=$packageCount; $pcIdx++) {
                        $mpsRequests[] = [
                            'items' => $sItemIds
                        ];
                    }
                }

                $labelModels[$carrierCode]->setUdropshipPackageCount(count($mpsRequests));

                $newTracks = [];

                for ($pcIdx=1; $pcIdx<=count($mpsRequests); $pcIdx++) {

                    $labelModels[$carrierCode]->setMpsRequest($mpsRequests[$pcIdx-1]);

                    $track = $this->_rmaTrackFactory->create()
                        ->setBatchId($this->getBatchId());
                    if (!empty($trackData)) {
                        if (isset($pkgWeight)) {
                            $trackData['total_weight'] = $totalWeight;
                            $trackData['length'] = $pkgLength[$pcIdx];
                            $trackData['height'] = $pkgHeight[$pcIdx];
                            $trackData['width']  = $pkgWidth[$pcIdx];
                            $trackData['value']  = $pkgValue[$pcIdx];
                            $trackData['weight'] = $pkgWeight[$pcIdx];
                        }
                        $track->addData($trackData);
                    }
                    $rma->addTrack($track);

                    $labelModels[$carrierCode]->setUdropshipPackageIdx($pcIdx);
                    $labelModels[$carrierCode]->requestRma($track);

                    $newTracks[] = $track;

                    $success++;

                }
                $labelModels[$carrierCode]->unsUdropshipPackageIdx();
                $labelModels[$carrierCode]->unsUdropshipPackageCount();
                $labelModels[$carrierCode]->unsUdropshipMasterTrackingId();
            } catch (\Exception $e) {
                $this->_eventManager->dispatch('udropship_rma_label_request_failed', ['rma'=>$rma, 'error'=>$e->getMessage()]);
                $this->addError($e->getMessage().' - %s order(s)');
                continue;
            }

            $orderId = $rma->getOrder() ? $rma->getOrder()->getIncrementId() : $rma->getOrderIncrementId();
            if (is_null($fromOrderId)) {
                $fromOrderId = $orderId;
                $toOrderId = $orderId;
            } else {
                $fromOrderId = min($fromOrderId, $orderId);
                $toOrderId = max($toOrderId, $orderId);
            }

            $this->_rmaHlp->afterRmaLabel($this->getVendor(), $rma);

        }
#exit;
        $this->setTitle('Orders IDs: '.$fromOrderId.' - '.$toOrderId);
        $this->setShipmentCnt($this->getShipmentCnt()+$success);

        if (!empty($track)) {
            $this->setLastTrack($track);
        }

        if (!$this->getShipmentCnt()) {
            $this->delete();
        } else {
            $this->save();
        }

        return $this;
    }

    public function renderRmas($rmas)
    {
        $tracks = [];
        foreach ($rmas as $rma) {
            foreach ($rma->getAllTracks() as $track) {
                $tracks[] = $track;
            }
        }
        $this->setTracks($tracks);
        $this->setVendorId($this->getVendor()->getId());
        $this->setLabelType($this->getVendor()->getLabelType());
        return $this;
    }

}
