<?php

namespace Unirgy\Rma\Block\Adminhtml\SalesOrderViewTab;

use Magento\Backend\Block\Template\Context;
use Magento\Backend\Block\Widget\Grid;
use Magento\Backend\Block\Widget\Tab\TabInterface;
use Magento\Backend\Helper\Data as HelperData;
use Magento\Framework\Registry;
use Unirgy\Dropship\Model\Source;

class Rmas
    extends \Magento\Backend\Block\Widget\Grid\Extended
    implements TabInterface
{
    /**
     * @var Source
     */
    protected $_hlp;

    /**
     * @var Registry
     */
    protected $_coreRegistry;

    protected $_rmaHlp;

    public function __construct(
        Context $context,
        HelperData $backendHelper,
        \Unirgy\Rma\Helper\Data $urmaHelper,
        \Unirgy\Dropship\Helper\Data $udropshipHelper,
        Registry $frameworkRegistry, 
        array $data = [])
    {
        $this->_hlp = $udropshipHelper;
        $this->_rmaHlp = $urmaHelper;
        $this->_coreRegistry = $frameworkRegistry;

        parent::__construct($context, $backendHelper, $data);
        $this->setId('order_urmas');
        $this->setUseAjax(true);
    }

    protected function _getCollectionClass()
    {
        return 'Unirgy\Rma\Model\ResourceModel\Rma\GridCollection';
    }

    protected function _prepareCollection()
    {
        $res = $this->_hlp->rHlp();
        $collection = $this->_hlp->createObj($this->_getCollectionClass());
        $collection->getSelect()->join(
            ['t'=>$res->getTableName('urma_rma')],
            't.entity_id=main_table.entity_id',
            ['udropship_vendor', 'rma_status', 'udropship_method',
                'udropship_method_description', 'udropship_status', 'shipping_amount'
            ]
        );
        $collection->setOrderFilter($this->getOrder());
        $this->setCollection($collection);
        return parent::_prepareCollection();
    }

    protected function _prepareColumns()
    {
        $this->addColumn('increment_id', [
            'header'    => __('Return #'),
            'index'     => 'increment_id',
            'filter_index' => 'main_table.increment_id',
            'type'      => 'text',
        ]);

        $this->addColumn('created_at', [
            'header'    => __('Return Created'),
            'index'     => 'created_at',
            'filter_index' => 'main_table.created_at',
            'type'      => 'datetime',
        ]);

        $this->addColumn('order_increment_id', [
            'header'    => __('Order #'),
            'index'     => 'order_increment_id',
            'type'      => 'number',
        ]);

        $this->addColumn('order_created_at', [
            'header'    => __('Order Date'),
            'index'     => 'order_created_at',
            'type'      => 'datetime',
        ]);

        $this->addColumn('shipping_name', [
            'header' => __('Shipper Name'),
            'index' => 'shipping_name',
        ]);

        $this->addColumn('rma_status', [
            'header' => __('Status'),
            'index' => 'rma_status',
            'filter_index' => 't.rma_status',
            'type' => 'options',
            'options' => $this->_rmaHlp->getVendorRmaStatuses(),
        ]);

        $this->addColumn('udropship_vendor', [
            'header' => __('Vendor'),
            'index' => 'udropship_vendor',
            'filter_index' => 't.udropship_vendor',
            'type' => 'options',
            'options' => $this->_hlp->src()->setPath('vendors')->toOptionHash(),
            'filter' => '\Unirgy\Dropship\Block\Vendor\GridColumnFilter'
        ]);

        $this->addColumn('udropship_method_description', [
            'header' => __('Method'),
            'index' => 'udropship_method_description',
            'filter_index' => 't.udropship_method_description',
        ]);

        return parent::_prepareColumns();
    }

    public function getOrder()
    {
        return $this->_coreRegistry->registry('current_order');
    }

    public function getRowUrl($row)
    {
        return $this->getUrl(
            'urma/order_rma/view',
            [
                'rma_id'=> $row->getId(),
                'order_id'  => $row->getOrderId()
             ]);
    }

    public function getGridUrl()
    {
        return $this->getUrl('urma/order_rma/rmasTab', ['_current' => true]);
    }

    public function getTabLabel()
    {
        return __('uReturns');
    }

    public function getTabTitle()
    {
        return __('uReturns');
    }

    public function canShowTab()
    {
        return true;
    }

    public function isHidden()
    {
        return false;
    }
}
