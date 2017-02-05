<?php
/**
 * Unirgy LLC
 *
 * NOTICE OF LICENSE
 *
 * This source file is subject to the EULA
 * that is bundled with this package in the file LICENSE.txt.
 * It is also available through the world-wide-web at this URL:
 * http://www.unirgy.com/LICENSE-M1.txt
 *
 * @category   Unirgy
 * @package    Unirgy_DropshipSellYours
 * @copyright  Copyright (c) 2008-2009 Unirgy LLC (http://www.unirgy.com)
 * @license    http:///www.unirgy.com/LICENSE-M1.txt
 */

namespace Unirgy\DropshipSellYours\Helper;

use Magento\Framework\App\Helper\AbstractHelper;
use Magento\Framework\App\Helper\Context;
use Magento\Framework\App\ObjectManager;
use Magento\Framework\Registry;
use Magento\Store\Model\ScopeInterface;
use Unirgy\DropshipVendorProduct\Helper\Data as DropshipVendorProductHelperData;
use Unirgy\Dropship\Helper\Data as HelperData;

class Data extends AbstractHelper
{
    /**
     * @var ProtectedCode
     */
    protected $_syHlpPr;

    /**
     * @var HelperData
     */
    protected $_hlp;

    /**
     * @var DropshipVendorProductHelperData
     */
    protected $_prodHlp;

    /**
     * @var Registry
     */
    protected $_registry;

    public function __construct(
        Context $context,
        ProtectedCode $helperProtectedCode,
        HelperData $udropshipHelper,
        DropshipVendorProductHelperData $udprodHelper,
        Registry $frameworkRegistry
    )
    {
        $this->_syHlpPr = $helperProtectedCode;
        $this->_hlp = $udropshipHelper;
        $this->_prodHlp = $udprodHelper;
        $this->_registry = $frameworkRegistry;

        parent::__construct($context);
    }

    public function processFormVar($var, $decimal=false)
    {
        return ''===$var || null === $var ? '' : ($decimal ? 1*$var : $var);
    }

    public function hookVendorCustomer($vendor, $customer)
    {
        if ($vendor && $vendor->getId() && $customer && $customer->getId()) {
            if ($customer->getVendorId() != $vendor->getId()) {
                $customer->setVendorId($vendor->getId());
                $this->_hlp->rHlp()->updateModelFields($customer, ['vendor_id']);
            }
            if ($vendor->getCustomerId() != $customer->getId()) {
                $vendor->setCustomerId($customer->getId());
                $this->_hlp->rHlp()->updateModelFields($vendor, ['customer_id']);
            }
        }
        return $this;
    }
    public function saveSellYoursFormData($data=null, $id=null)
    {
        $formData = ObjectManager::getInstance()->get('Unirgy\DropshipSellYours\Model\Session')->getSellYoursFormData();
        if (!is_array($formData)) {
            $formData = [];
        }
        $data = !is_null($data) ? $data : $this->_request->getPost();
        $id = !is_null($id) ? $id : $this->_request->getParam('id');
        $formData[$id] = $data;
        ObjectManager::getInstance()->get('Unirgy\DropshipSellYours\Model\Session')->setSellYoursFormData($formData);
    }

    public function fetchSellYoursFormData($id=null)
    {
        $formData = ObjectManager::getInstance()->get('Unirgy\DropshipSellYours\Model\Session')->getSellYoursFormData();
        if (!is_array($formData)) {
            $formData = [];
        }
        $id = !is_null($id) ? $id : $this->_request->getParam('id');
        $result = false;
        if (isset($formData[$id]) && is_array($formData[$id])) {
            $result = $formData[$id];
            unset($formData[$id]);
            if (empty($formData)) {
                ObjectManager::getInstance()->get('Unirgy\DropshipSellYours\Model\Session')->getSellYoursFormData(true);
            } else {
                ObjectManager::getInstance()->get('Unirgy\DropshipSellYours\Model\Session')->setSellYoursFormData($formData);
            }
        }
        return $result;
    }

    public function processSellRequest($vendor, $product, $data)
    {
        $this->_syHlpPr->processSellRequest($vendor, $product, $data);
        return $this;
    }

    public function getSRAllowedFields()
    {
        return ['vendor_price', 'vendor_title', 'stock_qty', 'shipping_price', 'state', 'freeshipping', 'state_descr', 'vendor_sku'];
    }

    public function getCustomerVendorPortalUrl()
    {
        return $this->scopeConfig->isSetFlag('udropship/customer/sync_customer_vendor', ScopeInterface::SCOPE_STORE)
            ? 'udsell/index/vendor'
            : 'udropship';
    }

    public function getSellYoursFieldsConfig()
    {
        $editFields = [];
        if ($this->_hlp->isUdmultiActive()) {
            $editFields['udmulti']['label'] = __('Vendor Specific Fields');
            $editFields['udmulti']['values']  = $this->_prodHlp->getVendorEditFieldsConfig();
        }
        return $editFields;
    }

    public function getSellUrl($_product)
    {
        $params = ['id'=>$_product->getId()];
        if ($curCat = $this->_registry->registry('current_category')) {
            $params['c'] = $curCat->getId();
        }
        return $this->_urlBuilder->getUrl('udsell/index/sell', $params);
    }

}