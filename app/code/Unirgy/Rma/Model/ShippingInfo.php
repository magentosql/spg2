<?php

namespace Unirgy\Rma\Model;

use Magento\Sales\Api\ShipmentRepositoryInterface;
use Magento\Sales\Model\OrderFactory;
use Magento\Shipping\Helper\Data as HelperData;
use Magento\Shipping\Model\Info;
use Magento\Shipping\Model\Order\TrackFactory;
use Magento\Shipping\Model\ResourceModel\Order\Track\CollectionFactory;
use Unirgy\Rma\Helper\Shipping;
use Unirgy\Rma\Model\Rma\TrackFactory as RmaTrackFactory;

class ShippingInfo extends Info
{
    /**
     * @var Shipping
     */
    protected $_helperShipping;

    /**
     * @var RmaTrackFactory
     */
    protected $_rmaTrackFactory;

    /**
     * @var RmaFactory
     */
    protected $_modelRmaFactory;

    protected $_hlp;

    public function __construct(
        \Unirgy\Dropship\Helper\Data $udropshipHelper,
        HelperData $shippingData,
        OrderFactory $orderFactory, 
        ShipmentRepositoryInterface $shipmentRepository, 
        TrackFactory $trackFactory, 
        CollectionFactory $trackCollectionFactory, 
        Shipping $helperShipping, 
        RmaTrackFactory $rmaTrackFactory, 
        RmaFactory $modelRmaFactory, 
        array $data = [])
    {
        $this->_hlp = $udropshipHelper;
        $this->_helperShipping = $helperShipping;
        $this->_rmaTrackFactory = $rmaTrackFactory;
        $this->_modelRmaFactory = $modelRmaFactory;

        parent::__construct($shippingData, $orderFactory, $shipmentRepository, $trackFactory, $trackCollectionFactory, $data);
    }

    public function loadByHash($hash)
    {
        $data = $this->_helperShipping->decodeTrackingHash($hash);
        if (!empty($data)) {
            $this->setData($data['key'], $data['id']);
            $this->setProtectCode($data['hash']);

            if ($this->getRmaId()>0) {
                $this->getTrackingInfoByRma();
            } elseif ($this->getRmaTrackId()>0) {
                $this->getTrackingInfoByRmaTrackId();
            } elseif ($this->getUstockpoId()>0) {
                $this->getTrackingInfoByUstockpo();
            } elseif ($this->getUstockpoTrackId()>0) {
                $this->getTrackingInfoByUstockpoTrackId();
            } elseif ($this->getOrderId()>0) {
                $this->getTrackingInfoByOrder();
            } elseif($this->getShipId()>0) {
                $this->getTrackingInfoByShip();
            } else {
                $this->getTrackingInfoByTrackId();
            }
        }
        return $this;
    }

    public function getTrackingInfoByRmaTrackId()
    {
        $track = $this->_rmaTrackFactory->create()->load($this->getRmaTrackId());
        if ($track->getId() && $this->getProtectCode() == $track->getProtectCode()) {
            $this->_trackingInfo = [[$track->getNumberDetail()]];
        }
        return $this->_trackingInfo;
    }
    public function getTrackingInfoByRma()
    {
        $shipTrack = [];
        $po = $this->_initRma();
        if ($po) {
            $increment_id = $po->getIncrementId();
            $tracks = $po->getTracksCollection();

            $trackingInfos=[];
            foreach ($tracks as $track){
                $trackingInfos[] = $track->getNumberDetail();
            }
            $shipTrack[$increment_id] = $trackingInfos;

        }
        $this->_trackingInfo = $shipTrack;
        return $this->_trackingInfo;
    }
    protected function _initRma()
    {
        $model = $this->_modelRmaFactory->create();
        $po = $model->load($this->getRmaId());
        if (!$po->getEntityId() || $this->getProtectCode() != $po->getProtectCode()) {
            return false;
        }
        return $po;
    }

    public function getTrackingInfoByUstockpoTrackId()
    {
        $track = $this->_hlp->createObj('Unirgy\DropshipStockPo\Model\Po\Track')->load($this->getUstockpoTrackId());
        if ($track->getId() && $this->getProtectCode() == $track->getProtectCode()) {
            $this->_trackingInfo = [[$track->getNumberDetail()]];
        }
        return $this->_trackingInfo;
    }
    public function getTrackingInfoByUstockpo()
    {
        $shipTrack = [];
        $po = $this->_initUstockpo();
        if ($po) {
            $increment_id = $po->getIncrementId();
            $tracks = $po->getTracksCollection();

            $trackingInfos=[];
            foreach ($tracks as $track){
                $trackingInfos[] = $track->getNumberDetail();
            }
            $shipTrack[$increment_id] = $trackingInfos;

        }
        $this->_trackingInfo = $shipTrack;
        return $this->_trackingInfo;
    }
    protected function _initUstockpo()
    {
        $model = $this->_hlp->createObj('Unirgy\DropshipStockPo\Model\Po');
        $po = $model->load($this->getUstockpoId());
        if (!$po->getEntityId() || $this->getProtectCode() != $po->getProtectCode()) {
            return false;
        }
        return $po;
    }
}
