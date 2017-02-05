<?php

namespace Unirgy\DropshipSellYours\Observer;

use Magento\Framework\App\Config\ScopeConfigInterface;
use Magento\Framework\Event\Observer;
use Magento\Framework\Event\ObserverInterface;
use Magento\Store\Model\ScopeInterface;
use Unirgy\DropshipSellYours\Model\Source as ModelSource;
use Unirgy\Dropship\Helper\Data as HelperData;
use Unirgy\Dropship\Model\Source;

class UdropshipAdminhtmlVendorEditPrepareForm extends AbstractObserver implements ObserverInterface
{
    public function execute(Observer $observer)
    {
        $id = $observer->getEvent()->getId();
        $form = $observer->getEvent()->getForm();
        $fieldset = $form->getElement('vendor_form');

        $fieldset->addField('is_featured', 'select', [
            'name'      => 'is_featured',
            'label'     => __('Is Featured'),
            'options'   => $this->_src->setPath('yesno')->toOptionHash(),
        ]);

        return $this;
        if ($this->_scopeConfig->getValue('udropship/microsite/use_basic_pro_accounts', ScopeInterface::SCOPE_STORE)) {
            $fieldset->addField('account_type', 'select', [
                'name'      => 'account_type',
                'label'     => __('Account Type'),
                'options'   => $this->_sySrc->setPath('account_type')->toOptionHash(),
            ]);
        }
    }
}
