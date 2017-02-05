<?php


namespace Unirgy\DropshipMulti\Block\Vendor\ProductAttribute\Renderer;

use Magento\Backend\Block\Widget;
use Magento\Framework\Data\Form\Element\AbstractElement;
use Magento\Framework\Data\Form\Element\Renderer\RendererInterface;

class GroupPrice extends Widget implements RendererInterface
{
    protected $_element = null;

    protected function _construct()
    {
        parent::_construct();
        if (!$this->getTemplate()) {
            $this->setTemplate('Unirgy_DropshipMulti::unirgy/udmulti/vendor/product/group_price.phtml');
        }
    }

    public function render(AbstractElement $element)
    {
        $this->setElement($element);
        $html = $this->toHtml();
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
}