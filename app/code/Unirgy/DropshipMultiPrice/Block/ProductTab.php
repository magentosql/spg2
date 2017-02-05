<?php

namespace Unirgy\DropshipMultiPrice\Block;

use Magento\Catalog\Block\Product\View\Description;
use Magento\Framework\Registry;
use Magento\Framework\View\Element\Template\Context;
use Magento\Framework\View\LayoutFactory;

class ProductTab extends Description
{
    /**
     * @var LayoutFactory
     */
    protected $_viewLayoutFactory;

    public function __construct(Context $context, 
        Registry $registry, 
        LayoutFactory $viewLayoutFactory, 
        array $data = [])
    {
        $this->_viewLayoutFactory = $viewLayoutFactory;

        parent::__construct($context, $registry, $data);
    }

    protected function _prepareLayout()
    {
        parent::_prepareLayout();
        $this->setChild('product.vendors',
            $this->_viewLayoutFactory->create()->createBlock('udmultiprice/productVendors', 'product.vendors')->setTemplate('Unirgy_DropshipMultiPrice::udmultiprice/product/vendors.phtml')
        );
        return $this;
    }
}
