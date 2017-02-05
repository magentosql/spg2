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

class Comment extends AbstractModel
{
    /**
     * @var StoreManagerInterface
     */
    protected $_storeManager;

    public function __construct(Context $context, 
        Registry $registry, 
        ExtensionAttributesFactory $extensionFactory, 
        AttributeValueFactory $customAttributeFactory, 
        StoreManagerInterface $modelStoreManagerInterface, 
        AbstractResource $resource = null, 
        AbstractDb $resourceCollection = null, 
        array $data = [])
    {
        $this->_storeManager = $modelStoreManagerInterface;

        parent::__construct($context, $registry, $extensionFactory, $customAttributeFactory, $resource, $resourceCollection, $data);
    }

    protected $_eventPrefix = 'urma_rma_comment';
    protected $_eventObject = 'rma_comment';
    
    protected $_rma;

    protected function _construct()
    {
        $this->_init('Unirgy\Rma\Model\ResourceModel\Rma\Comment');
    }

    public function setRma(Rma $rma)
    {
        $this->_rma = $rma;
        $this->setRmaStatus($rma->getRmaStatus());
        return $this;
    }

    public function getRma()
    {
        return $this->_rma;
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
