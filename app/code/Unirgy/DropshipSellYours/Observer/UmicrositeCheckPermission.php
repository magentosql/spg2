<?php

namespace Unirgy\DropshipSellYours\Observer;

use Magento\Framework\App\Config\ScopeConfigInterface;
use Magento\Framework\Event\Observer;
use Magento\Framework\Event\ObserverInterface;
use Magento\Store\Model\ScopeInterface;
use Magento\Store\Model\StoreManagerInterface;
use Unirgy\Dropship\Helper\Data as HelperData;

class UmicrositeCheckPermission extends AbstractObserver implements ObserverInterface
{
    public function execute(Observer $observer)
    {
        return $this;
        if (!$this->_scopeConfig->getValue('udropship/microsite/use_basic_pro_accounts', ScopeInterface::SCOPE_STORE)
            || !$observer->getVendor() || !$observer->getVendor()->getId()
        ) {
            return $this;
        }
        switch ($observer->getAction()) {
            case 'microsite':
            case 'adminhtml':
            case 'new_product':
                if ($observer->getVendor()->getAccountType()!='pro') {
                    $observer->getTransport()->setRedirect(
                        $this->_storeManager->getStore()->getUrl('udsell/index/becomePro')
                    );
                    $observer->getTransport()->setAllowed(false);
                }
                break;
        }
        return $this;
    }
}
