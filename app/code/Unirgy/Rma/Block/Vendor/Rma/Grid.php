<?php
/**
 * Unirgy LLC
 *
 * NOTICE OF LICENSE
 *
 * This source file is subject to the EULA
 * that is bundled with this package in the file LICENSE.txt.
 * It is also available through the world-wide-web at this URL:
 * http://www.unirgy.com/LICENSE-M1.txt
 *
 * @category   Unirgy
 * @package    Unirgy_DropshipStockPo
 * @copyright  Copyright (c) 2008-2009 Unirgy LLC (http://www.unirgy.com)
 * @license    http:///www.unirgy.com/LICENSE-M1.txt
 */
 
namespace Unirgy\Rma\Block\Vendor\Rma;

use Magento\Framework\View\Element\Template;
use Magento\Framework\View\Element\Template\Context;
use Magento\Framework\View\LayoutFactory;
use Unirgy\Rma\Helper\Data as HelperData;

class Grid extends Template
{
    /**
     * @var LayoutFactory
     */
    protected $_viewLayoutFactory;

    /**
     * @var HelperData
     */
    protected $_helperData;

    public function __construct(Context $context, 
        LayoutFactory $viewLayoutFactory, 
        HelperData $helperData, 
        array $data = [])
    {
        $this->_viewLayoutFactory = $viewLayoutFactory;
        $this->_helperData = $helperData;

        parent::__construct($context, $data);
    }

    protected $_collection;

    protected function _prepareLayout()
    {
        parent::_prepareLayout();

        if ($toolbar = $this->_viewLayoutFactory->create()->getBlock('urma.grid.toolbar')) {
            $toolbar->setCollection($this->_helperData->getVendorRmaCollection());
            $this->setChild('toolbar', $toolbar);
        }

        return $this;
    }
}