<?php

namespace Unirgy\Rma\Model\Rma;

use Magento\Framework\Api\AttributeValueFactory;
use Magento\Framework\Api\ExtensionAttributesFactory;
use Magento\Framework\Data\Collection\AbstractDb;
use Magento\Framework\Model\Context;
use Magento\Framework\Model\ResourceModel\AbstractResource;
use Magento\Framework\Registry;
use Magento\Sales\Model\AbstractModel;
use Magento\Store\Model\StoreManagerInterface;
use Unirgy\Rma\Model\Rma;
use Unirgy\Rma\Model\RmaFactory;

class Track extends AbstractModel
{
    /**
     * @var RmaFactory
     */
    protected $_rmaFactory;

    /**
     * @var StoreManagerInterface
     */
    protected $_storeManager;

    protected $_carrierFactory;

    public function __construct(Context $context, 
        Registry $registry, 
        ExtensionAttributesFactory $extensionFactory, 
        AttributeValueFactory $customAttributeFactory, 
        RmaFactory $modelRmaFactory,
        \Magento\Shipping\Model\CarrierFactory $carrierFactory,
        StoreManagerInterface $storeManager,
        AbstractResource $resource = null, 
        AbstractDb $resourceCollection = null, 
        array $data = [])
    {
        $this->_carrierFactory = $carrierFactory;
        $this->_rmaFactory = $modelRmaFactory;
        $this->_storeManager = $storeManager;

        parent::__construct($context, $registry, $extensionFactory, $customAttributeFactory, $resource, $resourceCollection, $data);
    }

    const CUSTOM_CARRIER_CODE   = 'custom';
    protected $_rma = null;

    protected $_eventPrefix = 'urma_rma_track';
    protected $_eventObject = 'track';

    function _construct()
    {
        $this->_init('Unirgy\Rma\Model\ResourceModel\Rma\Track');
    }
    public function setRma(Rma $rma)
    {
        $this->_rma = $rma;
        return $this;
    }

    public function getShipment()
    {
        return $this->getRma();
    }

    public function getRma()
    {
        if (!($this->_rma instanceof Rma)) {
            $this->_rma = $this->_rmaFactory->create()->load($this->getParentId());
        }

        return $this->_rma;
    }

    public function isCustom()
    {
        return $this->getCarrierCode() == self::CUSTOM_CARRIER_CODE;
    }

    protected function _initOldFieldsMap()
    {
        $this->_oldFieldsMap = [
            'number' => 'track_number'
        ];
    }

    public function getNumber()
    {
        return $this->getData('track_number') ? $this->getData('track_number') : $this->getData('number');
    }

    public function getProtectCode()
    {
        return (string)$this->getRma()->getProtectCode();
    }
    
    public function getNumberDetail()
    {
        $carrierInstance = $this->_carrierFactory->create($this->getCarrierCode());
        if (!$carrierInstance) {
            $custom['title'] = $this->getTitle();
            $custom['number'] = $this->getNumber();
            return $custom;
        } else {
            $carrierInstance->setStore($this->getStore());
        }

        if (!$trackingInfo = $carrierInstance->getTrackingInfo($this->getNumber())) {
            return __('No detail for number "%1"', $this->getNumber());
        }

        return $trackingInfo;
    }
    
    public function getStore()
    {
        if ($this->getRma()) {
            return $this->getRma()->getStore();
        }
        return $this->_storeManager->getStore();
    }

    public function beforeSave()
    {
        parent::beforeSave();

        if (!$this->getParentId() && $this->getRma()) {
            $this->setParentId($this->getRma()->getId());
        }

        return $this;
    }
}
