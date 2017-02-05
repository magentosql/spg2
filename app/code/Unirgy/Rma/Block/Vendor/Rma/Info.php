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
use Magento\Sales\Block\Items\AbstractItems;
use Magento\Shipping\Model\Config;
use Unirgy\Dropship\Helper\Data as HelperData;
use Unirgy\Rma\Model\RmaFactory;

class Info extends AbstractItems
{
    /**
     * @var RmaFactory
     */
    protected $_modelRmaFactory;

    /**
     * @var HelperData
     */
    protected $_helperData;

    /**
     * @var Config
     */
    protected $_modelConfig;

    public function __construct(Context $context, 
        RmaFactory $modelRmaFactory, 
        HelperData $helperData, 
        Config $modelConfig, 
        array $data = [])
    {
        $this->_modelRmaFactory = $modelRmaFactory;
        $this->_helperData = $helperData;
        $this->_modelConfig = $modelConfig;

        parent::__construct($context, $data);
    }

    public function getRma()
    {
        if (!$this->hasData('rma')) {
            $id = (int)$this->getRequest()->getParam('id');
            $rma = $this->_modelRmaFactory->create()->load($id);
            $rma->setGroupItemsFlag(true);
            $this->setData('rma', $rma);
            $this->_helperData->assignVendorSkus($rma);
        }
        return $this->getData('rma');
    }

    public function getCarriers()
    {
        $carriers = [];
        $carrierInstances = $this->_modelConfig->getAllCarriers(
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
        if ($carrier = $this->_modelConfig->getCarrierInstance($code)) {
            return $carrier->getConfigData('title');
        }
        else {
            return __('Custom Value');
        }
        return false;
    }

}
