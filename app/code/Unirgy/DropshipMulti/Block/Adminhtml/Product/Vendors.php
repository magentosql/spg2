<?php

namespace Unirgy\DropshipMulti\Block\Adminhtml\Product;

use Magento\Backend\Block\Template\Context;
use Magento\Backend\Block\Widget;
use Magento\Backend\Block\Widget\Tab\TabInterface;
use Magento\Customer\Model\Group;
use Magento\Framework\Registry;
use Magento\Framework\View\Layout;
use Unirgy\DropshipMulti\Helper\Data as HelperData;
use Unirgy\Dropship\Helper\Data as DropshipHelperData;
use Unirgy\Dropship\Model\Vendor\ProductFactory;

class Vendors
    extends Widget
    implements TabInterface
{
    /**
     * @var ProductFactory
     */
    protected $_vendorProductFactory;

    /**
     * @var HelperData
     */
    protected $_multiHlp;

    /**
     * @var Registry
     */
    protected $_registry;

    /**
     * @var DropshipHelperData
     */
    protected $_hlp;

    /**
     * Initialize block
     *
     */
    public function __construct(
        Context $context,
        ProductFactory $vendorProductFactory, 
        HelperData $helperData, 
        Registry $frameworkRegistry, 
        DropshipHelperData $dropshipHelperData, 
        array $data = [])
    {
        $this->_vendorProductFactory = $vendorProductFactory;
        $this->_multiHlp = $helperData;
        $this->_registry = $frameworkRegistry;
        $this->_hlp = $dropshipHelperData;

        parent::__construct($context, $data);
        $this->setProductId($this->getRequest()->getParam('id'));
        $this->setTemplate('Unirgy_DropshipMulti::udmulti/product/vendors.phtml');
        $this->setId('udmulti_vendors');
        $this->setUseAjax(true);
    }

    public function getAssociatedVendors()
    {
        $assocVendor = $this->_vendorProductFactory->create()->getCollection()
            ->addProductFilter($this->getProduct()->getId());
        $assocVendor->getSelect()->join(['uv' => $assocVendor->getTable('udropship_vendor')], 'uv.vendor_id=main_table.vendor_id', ['vendor_name']);
        $gpData = [];//$this->_multiHlp->getMvGroupPrice([$this->getProduct()->getId()]);
        $tpData = $this->_multiHlp->getMvTierPrice([$this->getProduct()->getId()]);
        foreach ($assocVendor as $vp) {
            $udmTierPrice = $udmGroupPrice = [];
            foreach ($gpData as $__gpd) {
                if ($vp->getProductId() != $__gpd->getProductId() || $vp->getVendorId() != $__gpd->getVendorId()) continue;
                if ($__gpd->getData('all_groups')) {
                    $__gpd->setData('customer_group_id', Group::CUST_GROUP_ALL);
                }
                $udmGroupPrice[] = $__gpd->getData();
            }
            foreach ($tpData as $__tpd) {
                if ($vp->getProductId() != $__tpd->getProductId() || $vp->getVendorId() != $__tpd->getVendorId()) continue;
                if ($__tpd->getData('all_groups')) {
                    $__tpd->setData('customer_group_id', Group::CUST_GROUP_ALL);
                }
                $udmTierPrice[] = $__tpd->getData();
            }
            $vp->setData('group_price', $udmGroupPrice);
            $vp->setData('tier_price', $udmTierPrice);
        }
        return $assocVendor;
    }

    /**
     * Check block is readonly
     *
     * @return boolean
     */
    public function isReadonly()
    {
         return $this->getProduct()->getCompositeReadonly();
    }

    /**
     * Retrieve currently edited product object
     *
     * @return \Magento\Catalog\Model\Product
     */
    public function getProduct()
    {
        return $this->_registry->registry('current_product');
    }

    /**
     * Escape JavaScript string
     *
     * @param string $string
     * @return string
     */
    public function escapeJs($string)
    {
        return addcslashes($string, "'\r\n\\");
    }

    /**
     * Retrieve Tab label
     *
     * @return string
     */
    public function getTabLabel()
    {
        return __('Drop Shipping Vendors');
    }

    /**
     * Retrieve Tab title
     *
     * @return string
     */
    public function getTabTitle()
    {
        return __('Drop Shipping Vendors');
    }

    /**
     * Can show tab flag
     *
     * @return bool
     */
    public function canShowTab()
    {
        return true;
    }

    /**
     * Check is a hidden tab
     *
     * @return bool
     */
    public function isHidden()
    {
        return false;
    }
    
    public function getVendorName($vId)
    {
        $v = $this->_hlp->getVendor($vId);
        return $v && $v->getId() ? $v->getVendorName() : '';
    }

    public function getFieldName()
    {
        return $this->getData('field_name')
            ? $this->getData('field_name')
            : ($this->getElement() ? $this->getElement()->getName() : 'udmulti_vendors');
    }

    protected $_idSuffix;
    public function resetIdSuffix()
    {
        $this->_idSuffix = null;
        return $this;
    }
    public function getIdSuffix()
    {
        if (null === $this->_idSuffix) {
            $this->_idSuffix = $this->prepareIdSuffix($this->getFieldName());
        }
        return $this->_idSuffix;
    }

    public function prepareIdSuffix($id)
    {
        return preg_replace('/[^a-zA-Z0-9\$]/', '_', $id);
    }

    public function suffixId($id)
    {
        return $id.$this->getIdSuffix();
    }

    public function getAddButtonId()
    {
        return $this->suffixId('addBtn');
    }

    public function getGroupPriceBlock($fieldName)
    {
        return $this->getLayout()->getBlockSingleton('\Unirgy\DropshipMulti\Block\Adminhtml\Product\GroupPrice')
            ->setTemplate('Unirgy_DropshipMulti::udmulti/product/group_price.phtml')
            ->setFieldName($fieldName)
            ->setParentBlock($this);
    }
    public function getTierPriceBlock($fieldName)
    {
        return $this->getLayout()->getBlockSingleton('\Unirgy\DropshipMulti\Block\Adminhtml\Product\GroupPrice')
            ->setTemplate('Unirgy_DropshipMulti::udmulti/product/tier_price.phtml')
            ->setFieldName($fieldName)
            ->setParentBlock($this);
    }
}
