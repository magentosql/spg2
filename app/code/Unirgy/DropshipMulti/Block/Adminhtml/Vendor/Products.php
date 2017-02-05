<?php

namespace Unirgy\DropshipMulti\Block\Adminhtml\Vendor;

use Magento\Backend\Block\Widget\Grid;
use Magento\Backend\Helper\Data as BackendHelperData;
use Magento\Directory\Model\Currency;
use Magento\Store\Model\ScopeInterface;
use Unirgy\Dropship\Block\Adminhtml\Vendor\Edit\Tab\Products as TabProducts;

class Products
    extends TabProducts
{
    protected function _prepareCollection()
    {
        if ($this->getVendor()->getId()) {
            $this->setDefaultFilter(['in_vendor'=>1]);
        }
        $collection = $this->_hlp->createObj('\Magento\Catalog\Model\Product')->getCollection()
            ->addAttributeToSelect('name')
            ->addAttributeToSelect('sku')
            ->addAttributeToSelect('price')
            ->addStoreFilter($this->getRequest()->getParam('store'))
            ->joinTable('udropship_vendor_product', 'product_id=entity_id', ['vendor_sku', 'vendor_cost', 'stock_qty'], '{{table}}.vendor_id='.$this->getVendorId(), 'left');
        ;
        $this->setCollection($collection);

        return Grid::_prepareCollection();
    }

    protected function _addColumnFilterToCollection($column)
    {
        $id = $column->getId();
        $value = $column->getFilter()->getValue();
        $select = $this->getCollection()->getSelect();
        switch ($id) {
        case 'vendor_sku':
            if (!is_null($value) && $value!=='') {
                $select->where('vendor_sku like ?', $column->getFilter()->getValue().'%');
            }
            break;

        case 'vendor_cost': case 'stock_qty':
            if (!is_null($value['from']) && $value['from']!=='') {
                $select->where($id.'>=?', $value['from']);
            }
            if (!is_null($value['to']) && $value['to']!=='') {
                $select->where($id.'<=?', $value['to']);
            }
            break;

        default:
            parent::_addColumnFilterToCollection($column);
        }
        return $this;
    }

    protected function _prepareColumns()
    {
        $this->addColumn('in_vendor', [
            'header_css_class' => 'a-center',
            'type'      => 'checkbox',
            'name'      => 'in_vendor',
            'values'    => $this->_getSelectedProducts(),
            'align'     => 'center',
            'index'     => 'entity_id'
        ]);
        $this->addColumn('entity_id', [
            'header'    => __('ID'),
            'sortable'  => true,
            'width'     => '60',
            'index'     => 'entity_id'
        ]);
        $this->addColumn('name', [
            'header'    => __('Name'),
            'index'     => 'name'
        ]);
        $this->addColumn('sku', [
            'header'    => __('Magento SKU'),
            'width'     => '80',
            'index'     => 'sku'
        ]);
        $this->addColumn('_vendor_sku', [
            'header'    => __('Vendor SKU'),
            'index'     => 'vendor_sku',
            'editable'  => true,
            'sortable'  => false,
            'filter'    => false,
            'width'     => '100',
        ]);
        $this->addColumn('price', [
            'header'    => __('Magento Price'),
            'type'      => 'currency',
            'currency_code' => (string) $this->_scopeConfig->getValue(Currency::XML_PATH_CURRENCY_BASE, ScopeInterface::SCOPE_STORE),
            'index'     => 'price'
        ]);
        $this->addColumn('_vendor_cost', [
            'header'    => __('Vendor Cost'),
            'type'      => 'number',
            'index'     => 'vendor_cost',
            'editable'  => true,
            'sortable'  => false,
            'filter'    => false,
        ]);
        $this->addColumn('_stock_qty', [
            'header'    => __('Vendor Stock Qty'),
            'type'      => 'number',
            'index'     => 'stock_qty',
            'editable'  => true,
            'sortable'  => false,
            'filter'    => false,
        ]);
        return Grid::_prepareColumns();
    }
}
