<?php

namespace Unirgy\DropshipSellYours\Block\Adminhtml;

use Magento\Backend\Block\Template\Context;
use Magento\Backend\Helper\Data as BackendHelperData;
use Unirgy\DropshipSellYours\Helper\Data as DropshipSellYoursHelperData;
use Unirgy\Dropship\Block\Adminhtml\Vendor\Grid;
use Unirgy\Dropship\Helper\Data as HelperData;
use Unirgy\Dropship\Model\Source;

class VendorGrid extends Grid
{
    /**
     * @var DropshipSellYoursHelperData
     */
    protected $_syHlp;

    public function __construct(
        DropshipSellYoursHelperData $sellYoursHelper,
        HelperData $helperData,
        Context $context, 
        BackendHelperData $backendHelper, 
        array $data = [])
    {
        $this->_syHlp = $sellYoursHelper;
        parent::__construct($helperData, $context, $backendHelper, $data);
    }

    protected function _prepareColumns()
    {
        $hlp = $this->_syHlp;
        $this->addColumnAfter('is_featured', [
            'header'    => __('Is Featured'),
            'index'     => 'is_featured',
            'type'      => 'options',
            'options'   => $this->_hlp->src()->setPath('yesno')->toOptionHash(),
        ], 'status');
        return parent::_prepareColumns();
    }
    protected function _prepareMassaction()
    {
        $this->getMassactionBlock()->addItem('is_featured', [
             'label'=> __('Change Is Featured'),
             'url'  => $this->getUrl('udsell/vendor/massIsFeatured', ['_current'=>true]),
             'additional' => [
                    'is_featured' => [
                         'name' => 'is_featured',
                         'type' => 'select',
                         'class' => 'required-entry',
                         'label' => __('Is Featured'),
                         'values' => $this->_hlp->src()->setPath('yesno')->toOptionArray(true),
                     ]
             ]
        ]);

        return parent::_prepareMassaction();
    }
}