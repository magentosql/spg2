<?php

namespace SPG\CatalogProduct\Helper;

use Magento\Framework\Registry;


/**
 * Class Product Helper for quickly getting information for product
 * Class Product
 * @package SPG\CatalogProduct\Helper
 */
class Product extends \Magento\Framework\App\Helper\AbstractHelper
{

    protected $_productFactory;

    protected $_productRepository;

    protected $_dataObjectHelper;

    protected $_registry;


    public function __construct(\Magento\Framework\App\Helper\Context $context,
                                \Magento\Catalog\Api\Data\ProductInterfaceFactory $productFactory,
                                \Magento\Catalog\Api\ProductRepositoryInterface $productRepository,
                                \Magento\Framework\Api\DataObjectHelper $dataObjectHelper,
                                Registry $registry,
                                array $data = []
    )
    {

        $this->_dataObjectHelper = $dataObjectHelper;
        $this->_productFactory = $productFactory;
        $this->_productRepository = $productRepository;
        $this->_registry = $registry;
        parent::__construct($context);

    }

    /**
     * Get all children product for the configuration product
     * @param $product_id
     */

    public function getChildrenProduct($product_id = '')
    {
        $product = [];

        if (empty($product_id)) {
            $product = !$product ? $this->_registry->registry('current_product') : $product;
            $product = !$product ? $this->_registry->registry('product') : $product;
        } else {
            if (!is_numeric($product_id))
                return;
            $product = $this->_productRepository->getById($product_id);
        }

        switch ($product->getType()) {
            case 'simple':
                break;
            case 'configurable':
                $productTypeInstance = $product->getTypeInstance();

                var_dump($productTypeInstance);die;
                break;

        }


    }

}