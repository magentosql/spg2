<?php


namespace Unirgy\DropshipMulti\Block\Vendor\ProductAttribute\Form;

use Magento\Framework\Data\Form\Element\AbstractElement;
use Magento\Framework\Data\Form\Element\CollectionFactory;
use Magento\Framework\Data\Form\Element\Factory;
use Magento\Framework\Escaper;

class TierPrice extends AbstractElement
{
    /**
     * @var \Magento\Framework\View\LayoutInterface
     */
    protected $_layout;

    public function __construct(Factory $factoryElement, 
        CollectionFactory $factoryCollection, 
        Escaper $escaper,
        \Magento\Framework\View\LayoutInterface $modelLayout,
        $data = []
    )
    {
        $this->_layout = $modelLayout;
        parent::__construct($factoryElement, $factoryCollection, $escaper, $data);
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
        $this->_renderer = $this->_layout->createBlock('Unirgy\DropshipMulti\Block\Vendor\ProductAttribute\Renderer\TierPrice');
        return parent::getHtml();
    }
}