<?php

namespace Unirgy\DropshipMulti\Observer;

use Magento\Framework\App\Config\ScopeConfigInterface;
use Magento\Framework\Event\Observer;
use Magento\Framework\Event\ObserverInterface;
use Magento\Store\Model\ScopeInterface;
use Unirgy\DropshipMulti\Helper\Data as HelperData;
use Unirgy\Dropship\Helper\Data as DropshipHelperData;
use Unirgy\Dropship\Model\Source;

class UdropshipAdminhtmlVendorEditPrepareForm extends AbstractObserver implements ObserverInterface
{
    /**
     * @var ScopeConfigInterface
     */
    protected $_configScopeConfigInterface;

    /**
     * @var Source
     */
    protected $_modelSource;

    public function __construct(HelperData $helperData, 
        DropshipHelperData $dropshipHelperData, 
        ScopeConfigInterface $configScopeConfigInterface, 
        Source $modelSource)
    {
        $this->_configScopeConfigInterface = $configScopeConfigInterface;
        $this->_modelSource = $modelSource;

        parent::__construct($helperData, $dropshipHelperData);
    }

    public function execute(Observer $observer)
    {
        $id = $observer->getEvent()->getId();
        $form = $observer->getEvent()->getForm();
        $fieldset = $form->getElement('vendor_form');
    }
}
