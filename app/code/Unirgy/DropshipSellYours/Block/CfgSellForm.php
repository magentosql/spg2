<?php

namespace Unirgy\DropshipSellYours\Block;

use Magento\Framework\DataObject;
use Magento\Framework\Data\Form as DataForm;
use Magento\Framework\Data\Form\AbstractForm;
use Magento\Framework\Registry;
use Magento\Store\Model\ScopeInterface;
use Magento\Store\Model\StoreManagerInterface;
use Unirgy\DropshipVendorProduct\Helper\Form;
use Unirgy\Dropship\Helper\Data as HelperData;

class CfgSellForm extends \Magento\ConfigurableProduct\Block\Product\View\Type\Configurable
{
    /**
     * @var HelperData
     */
    protected $_hlp;

    /**
     * @var Form
     */
    protected $_helperForm;

    public function __construct(
        HelperData $helperData,
        Form $helperForm,
        \Magento\Catalog\Block\Product\Context $context,
        \Magento\Framework\Stdlib\ArrayUtils $arrayUtils,
        \Magento\Framework\Json\EncoderInterface $jsonEncoder,
        \Magento\ConfigurableProduct\Helper\Data $helper,
        \Magento\Catalog\Helper\Product $catalogProduct,
        \Magento\Customer\Helper\Session\CurrentCustomer $currentCustomer,
        \Magento\Framework\Pricing\PriceCurrencyInterface $priceCurrency,
        \Magento\ConfigurableProduct\Model\ConfigurableAttributeData $configurableAttributeData,
        array $data = []
    )
    {
        $this->_hlp = $helperData;
        $this->_helperForm = $helperForm;
        parent::__construct($context, $arrayUtils, $jsonEncoder, $helper, $catalogProduct, $currentCustomer, $priceCurrency, $configurableAttributeData, $data);
    }

    protected $_qcForm;
    public function getQcForm()
    {
        if (null !== $this->_qcForm) {
            return $this->_qcForm;
        }
        $prod = $this->getProduct();
        $fsIdx = 0;
        /** @var \Magento\Framework\Data\FormFactory $formFactory */
        $formFactory = $this->_hlp->getObj('\Magento\Framework\Data\FormFactory');
        $this->_qcForm = $formFactory->create();
        $fsConfig = $this->_scopeConfig->getValue('udsell/form/quick_create', ScopeInterface::SCOPE_STORE);
        if (!is_array($fsConfig)) {
            $fsConfig = $this->_hlp->unserialize($fsConfig);
            if (is_array($fsConfig)) {
                $fields = [];
                foreach (['columns'] as $colKey) {
                if (isset($fsConfig[$colKey]) && is_array($fsConfig[$colKey])) {
                    $requiredFields = (array)@$fsConfig['required_fields'];
                    foreach ($fsConfig[$colKey] as $fieldCode) {
                        if (!$this->_isFieldApplicable($prod, $fieldCode, $fsConfig)) continue;
                        $field = [];
                        if (strpos($fieldCode, 'udmulti.') === 0) {
                            $field = $this->_getUdmultiField(substr($fieldCode, 8), []);
                        }
                        if (!empty($field)) {
                            if (in_array($fieldCode, $requiredFields)) {
                                $field['required'] = true;
                            } else {
                                $field['required'] = false;
                                if (!empty($field['class'])) {
                                    $field['class'] = str_replace('required-entry', '', $field['class']);
                                }
                            }
                            $field['value'] = $this->prepareIdSuffix('$'.strtoupper($field['name']));
                            $field['id'] = $this->prepareIdSuffix($this->_qcForm->addSuffixToName(
                                $field['name'],
                                'udsell_cfgsell[$ROW]'
                            ));
                            if (isset($field['class'])) {
                                $field['class'] = str_replace(
                                    'udmulti_special_date',
                                    $this->prepareIdSuffix($this->_qcForm->addSuffixToName(
                                        'udmulti_special_date',
                                        'udsell_cfgsell[$ROW]'
                                    )),
                                    $field['class']
                                );
                            }
                            $fields[] = $field;
                        }
                    }
                }}

                if (!empty($fields)) {
                    $fsIdx++;
                    $fieldset = $this->_qcForm->addFieldset('group_fields'.$fsIdx,
                        [
                            'legend'=>'Add Product Options',
                            'class'=>'fieldset-wide',
                    ]);
                    $this->_addElementTypes($fieldset);
                    foreach ($fields as $field) {
                        if (!empty($field['input_renderer'])) {
                            $fieldset->addType($field['type'], $field['input_renderer']);
                        }
                        $formField = $fieldset->addField($field['id'], $field['type'], $field);
                        if (!empty($field['renderer'])) {
                            $formField->setRenderer($field['renderer']);
                        }
                    }
                    $this->_prepareFieldsetColumns($fieldset);
                    $emptyForm = false;
                }
            }
        }
        $this->_qcForm->addFieldNameSuffix('udsell_cfgsell[$ROW]');
        return $this->_qcForm;
    }
    protected $_syForm;
    public function getSyForm()
    {
        if (null !== $this->_syForm) {
            return $this->_syForm;
        }
        $prod = $this->getProduct();
        $values = (array)@$this->_coreRegistry->registry('sell_yours_data_'.$prod->getId());
        $mvData = (array)@$values['udmulti'];
        $fsIdx = 0;
        /** @var \Magento\Framework\Data\FormFactory $formFactory */
        $formFactory = $this->_hlp->getObj('\Magento\Framework\Data\FormFactory');
        $this->_syForm = $formFactory->create();
        $columnsConfig = $this->_scopeConfig->getValue('udsell/form/fieldsets', ScopeInterface::SCOPE_STORE);
        if (!is_array($columnsConfig)) {
            $columnsConfig = $this->_hlp->unserialize($columnsConfig);
            if (is_array($columnsConfig)) {
            foreach ($columnsConfig as $fsConfig) {
            if (is_array($fsConfig)) {
                $fields = [];
                foreach (['top_columns','bottom_columns','left_columns','right_columns'] as $colKey) {
                if (isset($fsConfig[$colKey]) && is_array($fsConfig[$colKey])) {
                    $requiredFields = (array)@$fsConfig['required_fields'];
                    foreach ($fsConfig[$colKey] as $fieldCode) {
                        if (!$this->_isFieldApplicable($prod, $fieldCode, $fsConfig)) continue;
                        $field = [];
                        if (strpos($fieldCode, 'udmulti.') === 0) {
                            $field = $this->_getUdmultiField(substr($fieldCode, 8), $mvData);
                        }
                        if (!empty($field)) {
                            switch ($colKey) {
                                case 'top_columns':
                                    $field['is_top'] = true;
                                    break;
                                case 'bottom_columns':
                                    $field['is_bottom'] = true;
                                    break;
                                case 'right_columns':
                                    $field['is_right'] = true;
                                    break;
                                default:
                                    $field['is_left'] = true;
                                    break;
                            }
                            if (in_array($fieldCode, $requiredFields)) {
                                $field['required'] = true;
                            } else {
                                $field['required'] = false;
                                if (!empty($field['class'])) {
                                    $field['class'] = str_replace('required-entry', '', $field['class']);
                                }
                            }
                            $fields[] = $field;
                        }
                    }
                }}

                if (!empty($fields)) {
                    $fsIdx++;
                    $fieldset = $this->_syForm->addFieldset('group_fields'.$fsIdx,
                        [
                            'legend'=>$fsConfig['title'],
                            'class'=>'fieldset-wide',
                    ]);
                    $this->_addElementTypes($fieldset);
                    foreach ($fields as $field) {
                        if (!empty($field['input_renderer'])) {
                            $fieldset->addType($field['type'], $field['input_renderer']);
                        }
                        $formField = $fieldset->addField($field['id'], $field['type'], $field);
                        if (!empty($field['renderer'])) {
                            $formField->setRenderer($field['renderer']);
                        }
                        $formField->addClass('input-text');
                    }
                    $this->_prepareFieldsetColumns($fieldset);
                    $emptyForm = false;
                }
            }}}
            $this->_syForm->addValues($values);
        }
        return $this->_syForm;
    }
    public function getChildElementHtml($elem)
    {
        return $this->getSyForm()->getElement($elem)->toHtml();
    }
    public function getChildElement($elem)
    {
        return $this->getSyForm()->getElement($elem);
    }
    public function isHidden($elem)
    {
        return $this->getSyForm()->getElement($elem)->getIsHidden();
    }
    protected function _prepareFieldsetColumns($fieldset)
    {
        $elements = $fieldset->getElements()->getIterator();
        reset($elements);
        $bottomElements = $topElements = $lcElements = $rcElements = [];
        while($element=current($elements)) {
            if ($element->getIsBottom()) {
                $bottomElements[] = $element->getId();
            } elseif ($element->getIsTop()) {
                $topElements[] = $element->getId();
            } elseif ($element->getIsRight()) {
                $rcElements[] = $element->getId();
            } else {
                $lcElements[] = $element->getId();
            }
            next($elements);
        }
        $fieldset->setTopColumn($topElements);
        $fieldset->setBottomColumn($bottomElements);
        $fieldset->setLeftColumn($lcElements);
        $fieldset->setRightColumn($rcElements);
        reset($elements);
        return $this;
    }
    protected function _getUdmultiField($field, $mvData)
    {
        return $this->_helperForm->getUdmultiField($field, $mvData);
    }
    public function prepareIdSuffix($id)
    {
        return preg_replace('/[^a-zA-Z0-9\$]/', '_', $id);
    }
    protected function _isFieldApplicable($prod, $fieldCode, $fsConfig)
    {
        $result = true;
        $ult = @$fsConfig['fields_extra'][$fieldCode]['use_limit_type'];
        $lt = @$fsConfig['fields_extra'][$fieldCode]['limit_type'];
        if (!is_array($lt)) {
            $lt = explode(',', $lt);
        }
        if ($ult && !in_array($prod->getTypeId(), $lt)) {
            $result = false;
        }
        if (strpos($fieldCode, 'udmulti.') === 0
            && !$this->_hlp->isUdmultiActive()
        ) {
            $result = false;
        }
        if (strpos($fieldCode, 'stock_data.') === 0
            && $this->_hlp->isUdmultiActive()
        ) {
            $result = false;
        }
        return $result;
    }
    protected $_additionalElementTypes = null;
    protected function _initAdditionalElementTypes()
    {
        if (is_null($this->_additionalElementTypes)) {
            $result = [
                'date'    => '\Unirgy\DropshipVendorProduct\Block\Vendor\Product\Form\DateRaw',
                'price'    => 'Magento\Catalog\Block\Adminhtml\Product\Helper\Form\Price',
                'weight'   => '\Magento\Catalog\Block\Adminhtml\Product\Helper\Form\Weight',
                'gallery'  => '\Unirgy\DropshipVendorProduct\Block\Vendor\Product\Gallery',
                'image'    => '\Magento\Catalog\Block\Adminhtml\Product\Helper\Form\Image',
                'boolean'  => '\Magento\Catalog\Block\Adminhtml\Product\Helper\Form\Boolean',
            ];

            $response = new DataObject();
            $response->setTypes([]);
            $this->_eventManager->dispatch('adminhtml_catalog_product_edit_element_types', ['response'=>$response]);

            foreach ($response->getTypes() as $typeName=>$typeClass) {
                $result[$typeName] = $typeClass;
            }
            $this->_additionalElementTypes = $result;
        }
        return $this;
    }

    protected function _getAdditionalElementTypes()
    {
        $this->_initAdditionalElementTypes();
        return $this->_additionalElementTypes;
    }
    public function addAdditionalElementType($code, $class)
    {
        $this->_initAdditionalElementTypes();
        $this->_additionalElementTypes[$code] = $class;
        return $this;
    }

    protected function _addElementTypes(AbstractForm $baseElement)
    {
        $types = $this->_getAdditionalElementTypes();
        foreach ($types as $code => $className) {
            $baseElement->addType($code, $className);
        }
    }
    public function getAllowProducts()
    {
        if (!$this->hasAllowProducts()) {
            $products = [];
            $oldStoreId = $this->_storeManager->getStore()->getId();
            $this->_storeManager->setCurrentStore(0);
            $allProducts = $this->getProduct()->getTypeInstance(true)
                ->getUsedProducts($this->getProduct());
            foreach ($allProducts as $product) {
                $products[] = $product;
            }
            $this->_storeManager->getStore()->setId($oldStoreId);
            $this->_storeManager->setCurrentStore($oldStoreId);
            $this->setAllowProducts($products);
        }
        return $this->getData('allow_products');
    }
    public function getProduct()
    {
        if (!$this->hasData('product')) {
            $this->setData('product', $this->_coreRegistry->registry('product'));
        }
        return $this->getData('product');
    }
}