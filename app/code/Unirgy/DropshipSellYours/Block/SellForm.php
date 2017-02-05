<?php

namespace Unirgy\DropshipSellYours\Block;

use Magento\Framework\App\Config\ScopeConfigInterface;
use Magento\Framework\DataObject;
use Magento\Framework\Data\Form as DataForm;
use Magento\Framework\Data\Form\AbstractForm;
use Magento\Framework\Event\ManagerInterface;
use Magento\Framework\Registry;
use Magento\Framework\View\Element\Template;
use Magento\Framework\View\Element\Template\Context;
use Magento\Store\Model\ScopeInterface;
use Unirgy\DropshipVendorProduct\Helper\Form;
use Unirgy\Dropship\Helper\Data as HelperData;

class SellForm extends Template
{
    /**
     * @var Registry
     */
    protected $_frameworkRegistry;

    /**
     * @var HelperData
     */
    protected $_hlp;

    /**
     * @var Form
     */
    protected $_helperForm;

    public function __construct(
        Context $context,
        Registry $frameworkRegistry, 
        HelperData $helperData,
        Form $helperForm, 
        array $data = []
    )
    {
        $this->_frameworkRegistry = $frameworkRegistry;
        $this->_hlp = $helperData;
        $this->_helperForm = $helperForm;

        parent::__construct($context, $data);
    }

    public function getSellPostUrl()
    {
        return $this->getUrl('udsell/index/sellPost', ['id'=>$this->getProduct()->getId()]);
    }
    public function getProduct()
    {
        return $this->getParentBlock()->getProduct();
    }
    protected $_syForm;
    public function getSyForm()
    {
        if (null !== $this->_syForm) {
            return $this->_syForm;
        }
        $prod = $this->getProduct();
        $values = (array)@$this->_frameworkRegistry->registry('sell_yours_data_'.$prod->getId());
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
                        if (!empty($field['required'])) {
                            $formField->addClass('required-entry');
                        }
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
                'price'    => 'Magento\Catalog\Block\Adminhtml\Product\Helper\Form\Price',
                'weight'   => '\Magento\Catalog\Block\Adminhtml\Product\Helper\Form\Weight',
                'gallery'  => '\Unirgy\DropshipVendorProduct\Block\Vendor\Product\Gallery',
                'image'    => '\Magento\Catalog\Block\Adminhtml\Product\Helper\Form\Image',
                'boolean'  => '\Magento\Catalog\Block\Adminhtml\Product\Helper\Form\Boolean',
            ];

            $events = ['adminhtml_catalog_product_edit_element_types', 'udsell_product_edit_element_types'];
            foreach ($events as $event) {
                $response = new DataObject();
                $response->setTypes([]);
                $this->_eventManager->dispatch($event, ['response'=>$response]);
                foreach ($response->getTypes() as $typeName=>$typeClass) {
                    $result[$typeName] = $typeClass;
                }
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
}