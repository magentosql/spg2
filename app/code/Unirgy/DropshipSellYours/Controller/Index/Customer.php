<?php

namespace Unirgy\DropshipSellYours\Controller\Index;

use Magento\Store\Model\StoreManagerInterface;

class Customer extends AbstractIndex
{
    public function execute()
    {
        $uSess = $this->_getVendorSession();
        $cSess = $this->_getCustomerSession();
        $sess  = $this->_getC2CSession();
        $vendor = $uSess->getVendor();
        $customer = $cSess->getCustomer();
        if (!$cSess->isLoggedIn() && $uSess->isLoggedIn() && $vendor->getCustomerId()) {
            $cSess->loginById($vendor->getCustomerId());
        }
        if ($cSess->authenticate($this)) {
            $this->_helperData->hookVendorCustomer($vendor, $customer);
            $redirectUrl = $this->_url->getUrl('customer/account/edit', ['_secure' => true]);
;
            if ($sess->getCustomerRedirectUrl()) {
                $redirectUrl = $sess->getCustomerRedirectUrl(true);
            }
            $this->_redirectUrl($redirectUrl);
        }
    }
}
