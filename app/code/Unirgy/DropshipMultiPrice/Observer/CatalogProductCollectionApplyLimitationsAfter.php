<?php

namespace Unirgy\DropshipMultiPrice\Observer;

use Magento\Framework\DB\Select;
use Magento\Framework\Event\Observer;
use Magento\Framework\Event\ObserverInterface;
use Magento\Framework\Registry;
use Unirgy\DropshipMultiPrice\Helper\Data as DropshipMultiPriceHelperData;
use Unirgy\DropshipMultiPrice\Model\Source;
use Unirgy\Dropship\Helper\Data as HelperData;

class CatalogProductCollectionApplyLimitationsAfter extends AbstractObserver implements ObserverInterface
{
    /**
     * @var Source
     */
    protected $_modelSource;

    /**
     * @var Registry
     */
    protected $_frameworkRegistry;

    public function __construct(HelperData $helperData, 
        DropshipMultiPriceHelperData $dropshipMultiPriceHelperData, 
        Source $modelSource, 
        Registry $frameworkRegistry)
    {
        $this->_modelSource = $modelSource;
        $this->_frameworkRegistry = $frameworkRegistry;

        parent::__construct($helperData, $dropshipMultiPriceHelperData);
    }

    public function execute(Observer $observer)
    {
        if (!$this->_hlp->isUdmultiActive()) return;
        $select = $observer->getCollection()->getSelect();
        $fromPart = $select->getPart(Select::FROM);
        if (isset($fromPart['price_index'])) {
            $columnsPart = $select->getPart(Select::COLUMNS);
            $alreadyAdded = false;
            foreach ($columnsPart as $columnEntry) {
                list($correlationName, $column, $alias) = $columnEntry;
                if ('udmp_new_min_price' == $alias) {
                    $alreadyAdded = true;
                    break;
                }
            }
            if (!$alreadyAdded) {
                $canStates = $this->_modelSource
                    ->setPath('vendor_product_state_canonic')
                    ->toOptionHash();
                $columns = [];
                foreach ($canStates as $csKey=>$csLbl) {
                    foreach (['_min_price','_max_price','_cnt'] as $csSuf) {
                        $columns['udmp_'.$csKey.$csSuf] = 'price_index.udmp_'.$csKey.$csSuf;
                    }
                }
                $select->columns($columns);
            }
            if ($this->_frameworkRegistry->registry('udsell_status_all')) {
                $fromPart['price_index']['joinType'] = 'left join';
                $select->setPart(Select::FROM, $fromPart);
            }
        }
    }
}
