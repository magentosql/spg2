<?php

namespace Unirgy\Rma\Controller\Adminhtml\Rma;

use Magento\Backend\App\Action\Context;
use Magento\Framework\View\LayoutFactory;
use Unirgy\Rma\Helper\Data as HelperData;

class ExportXml extends AbstractRma
{
    public function execute()
    {
        $this->_view->loadLayout();
        $fileName = 'rma.xml';
        $content = $this->_view->getLayout()->getBlock('urma.rma.grid');

        return $this->_fileFactory->create(
            $fileName,
            $content->getExcelFile($fileName),
            \Magento\Framework\App\Filesystem\DirectoryList::VAR_DIR
        );
    }
}
