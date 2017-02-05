<?php

namespace Unirgy\Rma\Controller\Adminhtml\Rma;

use Magento\Backend\App\Action\Context;
use Unirgy\Rma\Helper\Data as HelperData;
use Unirgy\Rma\Model\ResourceModel\Rma\Collection;

class PdfRmas extends AbstractRma
{
    /**
     * @var Collection
     */
    protected $_rmaCollection;

    public function __construct(
        Collection $rmaCollection,
        HelperData $urmaHelper,
        \Unirgy\Dropship\Helper\Data $udropshipHelper,
        \Magento\Backend\Model\View\Result\ForwardFactory $resultForwardFactory,
        \Magento\Framework\View\Result\PageFactory $resultPageFactory,
        \Magento\Framework\Controller\Result\RedirectFactory $resultRedirectFactory,
        \Magento\Framework\App\Response\Http\FileFactory $fileFactory,
        Context $context
    )
    {
        $this->_rmaCollection = $rmaCollection;

        parent::__construct($urmaHelper, $udropshipHelper, $resultForwardFactory, $resultPageFactory, $resultRedirectFactory, $fileFactory, $context);
    }

    public function execute(){
        $rmaIds = $this->getRequest()->getPost('rma_ids');
        if (!empty($rmaIds)) {
            $rmas = $this->_rmaCollection
                ->addAttributeToSelect('*')
                ->addAttributeToFilter('entity_id', ['in' => $rmaIds])
                ->load();
            $pdf = $this->_prepareRmaPdf($rmas);

            $this->_hlp->sendDownload('rma_'.$this->_hlp->now().'.pdf', $pdf->render(), 'application/pdf');
        }
        $this->_redirect('*/*/');
    }
}
