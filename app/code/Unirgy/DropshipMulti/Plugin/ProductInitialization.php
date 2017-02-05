<?php

namespace Unirgy\DropshipMulti\Plugin;

use Magento\Catalog\Controller\Adminhtml\Product\Initialization\Helper as InitializationHelper;

class ProductInitialization
{
    protected $_request;
    protected $_multiHlpPr;
    public function __construct(
        \Magento\Framework\App\RequestInterface $request,
        \Unirgy\DropshipMulti\Helper\ProtectedCode $multiHelperPr
    ) {
        $this->_request = $request;
        $this->_multiHlpPr = $multiHelperPr;
    }
    public function aroundInitialize(InitializationHelper $subject, \Closure $proceed, \Magento\Catalog\Model\Product $product)
    {
        $this->_multiHlpPr->catalog_product_prepare_save($this->_request, $product);
        return $proceed($product);
    }
}