<?php

namespace Unirgy\DropshipMulti\Block\Adminhtml\Product\Vendors;

use Magento\Backend\Block\AbstractBlock;
use Magento\Backend\Block\Context;
use Unirgy\Dropship\Helper\Data as HelperData;

class Condition
    extends AbstractBlock
{
    /**
     * @var HelperData
     */
    protected $_hlp;

    public function __construct(
        Context $context,
        HelperData $helperData, 
        array $data = [])
    {
        $this->_hlp = $helperData;

        parent::__construct($context, $data);
    }

    protected function _prepareLayout()
    {
        parent::_prepareLayout();

        if (!$this->_hlp->isModuleActive('Unirgy_DropshipMicrosite')
            || !$this->_hlp->getObj('Unirgy\DropshipMicrosite\Helper\Data')->getCurrentVendor())
        {
            $this->getLayout()->getBlock('product_tabs')
                ->addTab('udmulti_vendors', 'Unirgy\DropshipMulti\Block\Adminhtml\Product\Vendors');
        }
    }
}