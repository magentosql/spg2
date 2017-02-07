<?php
namespace SPG\DropshipMultiPrice\Block;


class ProductMultiPrice extends \Magento\Framework\View\Element\Template
{

    /**
     * @var Product
     */
    protected $_product = null;

    /**
     * Core registry
     *
     * @var \Magento\Framework\Registry
     */
    protected $_coreRegistry = null;

    /**
     * @param \Magento\Framework\View\Element\Template\Context $context
     * @param \Magento\Framework\Registry $registry
     * @param array $data
     */
    public function __construct(
        \Magento\Framework\View\Element\Template\Context $context,
        \Magento\Framework\Registry $registry,
        array $data = []
    )
    {
        $this->_coreRegistry = $registry;
        parent::__construct($context, $data);
    }

    /**
     * @return Product
     */
    public function getProduct()
    {
        if (!$this->_product) {
            $this->_product = $this->_coreRegistry->registry('product');
        }
        return $this->_product;
    }

    public function getMinimalQty($product)
    {
        /** @var \Magento\CatalogInventory\Api\StockRegistryInterface $stockRegistry */
        $stockRegistry = \Magento\Framework\App\ObjectManager::getInstance()->get('\Magento\CatalogInventory\Api\StockRegistryInterface');
        $stockItem = $stockRegistry->getStockItem($product->getId());
        if ($stockItem) {
            return ($stockItem->getMinSaleQty()
            && $stockItem->getMinSaleQty() > 0 ? $stockItem->getMinSaleQty() * 1 : null);
        }
        return null;
    }

    /**
     * Return the default product quantity in catalog product
     * @return int
     */
    public function getProductDefaultQty($product = null)
    {
        if (!$product) {
            $product = $this->getProduct();
        }

        $qty = $this->getMinimalQty($product);
        $config = $product->getPreconfiguredValues();
        $configQty = $config->getQty();
        if ($configQty > $qty) {
            $qty = $configQty;
        }

        return $qty;
    }

}