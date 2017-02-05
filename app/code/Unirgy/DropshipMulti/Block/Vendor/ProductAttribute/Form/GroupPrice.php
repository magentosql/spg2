<?php


namespace Unirgy\DropshipMulti\Block\Vendor\ProductAttribute\Form;

use Magento\Framework\Data\Form\Element\AbstractElement;
use Magento\Framework\Data\Form\Element\CollectionFactory;
use Magento\Framework\Data\Form\Element\Factory;
use Magento\Framework\Escaper;

class GroupPrice extends AbstractElement
{
    /**
     * @var \Magento\Framework\View\LayoutInterface
     */
    protected $_modelLayout;

    public function __construct(Factory $factoryElement, 
        CollectionFactory $factoryCollection, 
        Escaper $escaper,
        \Magento\Framework\View\LayoutInterface $modelLayout
    )
    {
        $this->_modelLayout = $modelLayout;

        parent::__construct($factoryElement, $factoryCollection, $escaper);
    }

    public function getElementHtml()
    {
        $this->setData('__hide_label',1);
        $html = $this->getHtml();
        $this->setData('__hide_label',0);
        return $html;
    }
    public function getHtml()
    {
        $this->_renderer = $this->_modelLayout->createBlock('Unirgy\DropshipMulti\Block\Vendor\Productattribute\Renderer\Groupprice');
        return parent::getHtml();
    }
}