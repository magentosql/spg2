<?php

namespace Unirgy\Rma\Block\Adminhtml\Rma\View;

use Magento\Backend\Block\Template;
use Magento\Backend\Block\Template\Context;
use Magento\Framework\Registry;
use Magento\Framework\View\LayoutFactory;
use Magento\Shipping\Model\Config;

class Tracking extends Template
{
    /**
     * @var Registry
     */
    protected $_coreRegistry;

    /**
     * @var Config
     */
    protected $_shippingConfig;
    protected $_carrierFactory;

    public function __construct(Context $context, 
        LayoutFactory $viewLayoutFactory, 
        Registry $frameworkRegistry, 
        Config $modelConfig,
        \Magento\Shipping\Model\CarrierFactory $carrierFactory,
        array $data = [])
    {
        $this->_coreRegistry = $frameworkRegistry;
        $this->_shippingConfig = $modelConfig;
        $this->_carrierFactory = $carrierFactory;

        parent::__construct($context, $data);
    }

    protected function _prepareLayout()
    {
        $onclick = "rmaSubmitAndReloadArea($('rma_tracking_info').parentNode, $('rma_tracking_info'), '".$this->getSubmitUrl()."')";
        $this->setChild('save_button',
            $this->getLayout()->createBlock('Magento\Backend\Block\Widget\Button')
                ->setData([
                    'label'   => __('Add'),
                    'class'   => 'save',
                    'onclick' => $onclick
                ])
        );
        $onclick = "rmaSubmitAndReloadArea($('rma_label_form').parentNode, $('rma_label_form'), '".$this->getGenerateUrl()."')";
        $this->setChild('generate_button',
            $this->getLayout()->createBlock('Magento\Backend\Block\Widget\Button')
                ->setData([
                    'label'   => __('Generate'),
                    'class'   => 'save',
                    'onclick' => $onclick
                ])
        );
    }

    public function getRma()
    {
        return $this->_coreRegistry->registry('current_rma');
    }

    /**
     * Retrieve save url
     *
     * @return string
     */
    public function getSubmitUrl()
    {
        return $this->getUrl('urma/order_rma/addTrack/', ['rma_id'=>$this->getRma()->getId()]);
    }

    public function getGenerateUrl()
    {
        return $this->getUrl('urma/order_rma/createLabel/', ['rma_id'=>$this->getRma()->getId()]);
    }

    /**
     * Retrive save button html
     *
     * @return string
     */
    public function getSaveButtonHtml()
    {
        return $this->getChildHtml('save_button');
    }
    public function getGenerateButtonHtml()
    {
        return $this->getChildHtml('generate_button');
    }

    /**
     * Retrieve remove url
     *
     * @return string
     */
    public function getRemoveUrl($track)
    {
        return $this->getUrl('urma/order_rma/removeTrack/', [
            'rma_id' => $this->getRma()->getId(),
            'track_id' => $track->getId()
        ]);
    }

    /**
     * Retrieve remove url
     *
     * @return string
     */
    public function getTrackInfoUrl($track)
    {
        return $this->getUrl('urma/order_rma/viewTrack/', [
            'rma_id' => $this->getRma()->getId(),
            'track_id' => $track->getId()
        ]);
    }

    /**
     * Retrieve
     *
     * @return unknown
     */
    public function getCarriers()
    {
        $carriers = [];
        $carrierInstances = $this->_shippingConfig->getAllCarriers(
            $this->getRma()->getStoreId()
        );
        $carriers['custom'] = __('Custom Value');
        foreach ($carrierInstances as $code => $carrier) {
            if ($carrier->isTrackingAvailable()) {
                $carriers[$code] = $carrier->getConfigData('title');
            }
        }
        return $carriers;
    }

    public function getCarrierTitle($code)
    {
        if ($carrier = $this->_carrierFactory->create($code)) {
            return $carrier->getConfigData('title');
        }
        else {
            return __('Custom Value');
        }
    }
}
