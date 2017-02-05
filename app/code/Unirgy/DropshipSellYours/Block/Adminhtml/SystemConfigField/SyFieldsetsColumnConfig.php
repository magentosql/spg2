<?php

namespace Unirgy\DropshipSellYours\Block\Adminhtml\SystemConfigField;

use Magento\Backend\Block\Context;
use Unirgy\DropshipSellYours\Helper\Data as DropshipSellYoursHelperData;
use Unirgy\Dropship\Block\Adminhtml\SystemConfigFormField\FieldContainer;
use Unirgy\Dropship\Helper\Data as HelperData;

class SyFieldsetsColumnConfig extends FieldContainer
{
    /**
     * @var DropshipSellYoursHelperData
     */
    protected $_syHlp;

    public function __construct(HelperData $udropshipHelper,
        \Magento\Backend\Block\Template\Context $context,
        DropshipSellYoursHelperData $helperData, 
        array $data = [])
    {
        $this->_syHlp = $helperData;

        parent::__construct($udropshipHelper, $context, $data);
    }

    public function getEditFieldsConfig()
    {
        return $this->_syHlp->getSellYoursFieldsConfig();
    }
}