<?php

namespace Unirgy\Rma\Block\Adminhtml\Rma\Create;

use Magento\CatalogInventory\Api\StockRegistryInterface;
use Magento\Sales\Block\Adminhtml\Items\AbstractItems;

class Items extends AbstractItems
{
    public function getOrder()
    {
        return $this->getRma()->getOrder();
    }

    public function getSource()
    {
        return $this->getRma();
    }

    public function getRma()
    {
        return $this->_coreRegistry->registry('current_rma');
    }

    protected function _beforeToHtml()
    {
        $this->setChild(
            'submit_button',
            $this->getLayout()->createBlock('Magento\Backend\Block\Widget\Button')->setData([
                'label'     => __('Submit Return'),
                'class'     => 'save submit-button',
                'onclick'   => 'editForm.submit()',
            ])
        );

        return parent::_beforeToHtml();
    }

}
