<?php

namespace Unirgy\DropshipSellYours\Block\Adminhtml\SystemConfigField;

use Magento\Backend\Block\Template\Context;
use Magento\Config\Block\System\Config\Form\Field;
use Magento\Framework\Data\Form\Element\AbstractElement;
use Magento\Framework\View\Layout;

class SyFieldsetsConfig extends Field
{
    protected $_element = null;

    protected function _construct()
    {
        if (!$this->getTemplate()) {
            $this->setTemplate('Unirgy_DropshipSellYours::udsell/system/form_field/fieldsets_config.phtml');
        }
    }

    public function getElementHtml(AbstractElement $element)
    {
        return $this->_getElementHtml($element);
    }
    protected function _getElementHtml(AbstractElement $element)
    {
        $this->setElement($element);
        $html = $this->_toHtml();
        return $html;
    }

    public function getFieldName()
    {
        return $this->getData('field_name')
            ? $this->getData('field_name')
            : ($this->getElement() ? $this->getElement()->getName() : '');
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

    public function getFieldContainerBlock($fieldName)
    {
        return $this->getLayout()->getBlockSingleton('\Unirgy\DropshipSellYours\Block\Adminhtml\SystemConfigField\SyFieldsetsColumnConfig')
            ->setTemplate('Unirgy_DropshipSellYours::udsell/system/form_field/fieldset_column_config.phtml')
            ->setFieldName($fieldName);
    }
}