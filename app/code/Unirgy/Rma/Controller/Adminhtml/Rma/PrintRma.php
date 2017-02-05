<?php

namespace Unirgy\Rma\Controller\Adminhtml\Rma;

use Magento\Backend\App\Action\Context;
use Magento\Store\Model\StoreManagerInterface;
use Unirgy\Rma\Model\RmaFactory;
use Unirgy\Rma\Helper\Data as HelperData;

class PrintRma extends AbstractRma
{
    /**
     * @var RmaFactory
     */
    protected $_rmaFactory;

    /**
     * @var StoreManagerInterface
     */
    protected $_storeManager;

    public function __construct(
        HelperData $helperData,
        RmaFactory $rmaFactory, 
        StoreManagerInterface $modelStoreManagerInterface, 
        \Unirgy\Rma\Helper\Data $urmaHelper,
        \Unirgy\Dropship\Helper\Data $udropshipHelper,
        \Magento\Backend\Model\View\Result\ForwardFactory $resultForwardFactory,
        \Magento\Framework\View\Result\PageFactory $resultPageFactory,
        \Magento\Framework\Controller\Result\RedirectFactory $resultRedirectFactory,
        \Magento\Framework\App\Response\Http\FileFactory $fileFactory,
        \Magento\Backend\App\Action\Context $context
    )
    {
        $this->_rmaFactory = $rmaFactory;
        $this->_storeManager = $modelStoreManagerInterface;

        parent::__construct($urmaHelper, $udropshipHelper, $resultForwardFactory, $resultPageFactory, $resultRedirectFactory, $fileFactory, $context);
    }

    public function execute()
    {
        if ($udoId = $this->getRequest()->getParam('udpo_id')) { 
            if (($urma = $this->_rmaFactory->create()->load($udoId)) && $urma->getId()) {
                if ($urma->getStoreId()) {
                    $this->_storeManager->setCurrentStore($urma->getStoreId());
                }
                $pdf = $this->_prepareRmaPdf([$urma]);
                $this->_hlp->sendDownload('purchase_order_'.$this->_hlp->now().'.pdf', $pdf->render(), 'application/pdf');
            }
        }
        else {
            $this->_forward('noRoute');
        }
    }
}
