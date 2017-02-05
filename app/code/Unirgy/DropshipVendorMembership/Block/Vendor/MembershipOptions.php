<?php

namespace Unirgy\DropshipVendorMembership\Block\Vendor;

use Magento\Framework\Data\Form\Element\AbstractElement;
use Magento\Framework\Data\Form\Element\CollectionFactory;
use Magento\Framework\Data\Form\Element\Factory;
use Magento\Framework\Escaper;

class MembershipOptions extends AbstractElement
{
    /**
     * @var \Magento\Framework\View\LayoutInterface
     */
    protected $_modelLayout;

    public function __construct(Factory $factoryElement, 
        CollectionFactory $factoryCollection, 
        Escaper $escaper,
        \Magento\Framework\View\LayoutInterface $modelLayout,
        $data = []
    )
    {
        $this->_modelLayout = $modelLayout;

        parent::__construct($factoryElement, $factoryCollection, $escaper, $data);
    }

    public function getHtml()
    {
        $this->_renderer = $this->_modelLayout->createBlock('\Unirgy\DropshipVendorMembership\Block\Vendor\MembershipOptionsRenderer', 'membership.options');
        return parent::getHtml();
    }
}