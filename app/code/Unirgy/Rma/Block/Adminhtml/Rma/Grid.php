<?php

namespace Unirgy\Rma\Block\Adminhtml\Rma;

use Magento\Backend\Block\Template\Context;
use Magento\Backend\Block\Widget\Grid as WidgetGrid;
use Magento\Backend\Helper\Data as HelperData;
use Magento\Framework\App\Config\ScopeConfigInterface;
use Magento\Framework\App\ObjectManager;
use Magento\Store\Model\ScopeInterface;
use Unirgy\Dropship\Model\Source;
use Unirgy\Rma\Helper\Data as RmaHelperData;

class Grid extends \Magento\Backend\Block\Widget\Grid\Extended
{
    /**
     * @var RmaHelperData
     */
    protected $_rmaHlp;

    /**
     * @var Source
     */
    protected $_hlp;

    public function __construct(Context $context,
        HelperData $backendHelper, 
        RmaHelperData $helperData,
        \Unirgy\Dropship\Helper\Data $udropshipHelper,
        array $data = [])
    {
        $this->_rmaHlp = $helperData;
        $this->_hlp = $udropshipHelper;

        parent::__construct($context, $backendHelper, $data);
        $this->setId('urma_rma_grid');
        $this->setDefaultSort('created_at');
        $this->setDefaultDir('DESC');
    }

    protected function _getCollectionClass()
    {
        return 'Unirgy\Rma\Model\ResourceModel\Rma\GridCollection';
    }

    public function t($table)
    {
        return $this->_hlp->rHlp()->getTableName($table);
    }

    protected function _getFlatExpressionColumn($key, $bypass=true)
    {
        $result = $bypass ? $key : null;
        switch ($key) {
            case 'tracking_price':
                $result = new \Zend_Db_Expr("(select sum(IFNULL(st.final_price,0)) from {$this->t('urma_rma_track')} st where st.parent_id=main_table.entity_id)");
                break;
        }
        return $result;
    }

    protected function _prepareCollection()
    {
        $res = $this->_hlp->rHlp();
        $collection = $this->_hlp->createObj($this->_getCollectionClass());
        $collection->getSelect()->join(
            ['t'=>$res->getTableName('urma_rma')],
            't.entity_id=main_table.entity_id',
            ['udropship_vendor', 'rma_status', 'udropship_method',
                'udropship_method_description', 'udropship_status', 'shipping_amount',
                'tracking_price'=>$this->_getFlatExpressionColumn('tracking_price')

            ]
        );
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
            'type' => 'options',
            'options' => $this->_rmaHlp->getVendorRmaStatuses(),
        ]);

        $this->addColumn('udropship_vendor', [
            'header' => __('Vendor'),
            'index' => 'udropship_vendor',
            'type' => 'options',
            'options' => $this->_hlp->src()->setPath('vendors')->toOptionHash(),
            'filter' => '\Unirgy\Dropship\Block\Vendor\GridColumnFilter'
        ]);

        $this->addColumn('udropship_method_description', [
            'header' => __('Method'),
            'index' => 'udropship_method_description',
        ]);

        $this->addColumn('tracking_price', [
            'header' => __('Tracking Price'),
            'index' => 'tracking_price',
            'filter_index' => $this->_getFlatExpressionColumn('tracking_price'),
            'type'  => 'price',
            'currency_code' => $this->_scopeConfig->getValue('currency/options/base', ScopeInterface::SCOPE_STORE),
        ]);

        $this->addColumn('action',
            [
                'header'    => __('Action'),
                'width'     => '50px',
                'type'      => 'action',
                'getter'     => 'getId',
                'actions'   => [
                    [
                        'caption' => __('View'),
                        'url'     => ['base'=>'urma/rma/view'],
                        'field'   => 'rma_id'
                    ]
                ],
                'filter'    => false,
                'sortable'  => false,
                'is_system' => true
        ]);

        $this->addExportType('*/*/exportCsv', __('CSV'));
        $this->addExportType('*/*/exportXml', __('XML'));

        return parent::_prepareColumns();
    }

    public function getRowUrl($row)
    {
        if ($this->_authorization->isAllowed('Unirgy_Rma::urma')) {
            return false;
        }

        return $this->getUrl('urma/rma/view',
            [
                'rma_id'=> $row->getId(),
            ]
        );
    }

    public function getGridUrl()
    {
        return $this->getUrl('*/*/*', ['_current' => true]);
    }

}
