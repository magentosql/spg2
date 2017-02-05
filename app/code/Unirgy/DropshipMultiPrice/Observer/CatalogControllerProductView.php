<?php

namespace Unirgy\DropshipMultiPrice\Observer;

use Magento\Checkout\Model\Cart;
use Magento\Framework\App\RequestInterface;
use Magento\Framework\Event\Observer;
use Magento\Framework\Event\ObserverInterface;
use Unirgy\DropshipMultiPrice\Helper\Data as DropshipMultiPriceHelperData;
use Unirgy\Dropship\Helper\Data as HelperData;

class CatalogControllerProductView extends AbstractObserver implements ObserverInterface
{
    /**
     * @var RequestInterface
     */
    protected $_appRequestInterface;

    /**
     * @var Cart
     */
    protected $_modelCart;

    public function __construct(HelperData $helperData, 
        DropshipMultiPriceHelperData $dropshipMultiPriceHelperData, 
        RequestInterface $appRequestInterface, 
        Cart $modelCart)
    {
        $this->_appRequestInterface = $appRequestInterface;
        $this->_modelCart = $modelCart;

        parent::__construct($helperData, $dropshipMultiPriceHelperData);
    }

    public function execute(Observer $observer)
    {
        $product = $observer->getProduct();
        if ($product->getConfigureMode()) {
            if (($id = (int) $this->_appRequestInterface->getParam('id'))) {
                $quoteItem = $this->_modelCart->getQuote()->getItemById($id);
                if ($quoteItem && ($__br = $quoteItem->getBuyRequest()) && ($bestVendor = $__br->getUdropshipVendor())) {
                    $mvData = $product->getMultiVendorData();
                    if (is_array($mvData)) {
                        foreach ($mvData as $vp) {
                            if ($vp['vendor_id']==$bestVendor) {
                                $product->setFinalPrice(null);
                                $product->setData('price', $vp['vendor_price']);
                                $product->setData('special_price', $vp['special_price']);
                                $product->setData('special_from_date', $vp['special_from_date']);
                                $product->setData('special_to_date', $vp['special_to_date']);
                                $product->getFinalPrice();
                            }
                        }
                    }
                }
            }
        }
    }
}
