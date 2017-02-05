<?php

namespace Unirgy\Rma\Controller\Adminhtml\Rma;

class ExportCsv extends AbstractRma
{
    public function execute()
    {
        $this->_view->loadLayout();
        $fileName = 'rma.csv';
        $content = $this->_view->getLayout()->getBlock('urma.rma.grid');

        return $this->_fileFactory->create(
            $fileName,
            $content->getCsvFile($fileName),
            \Magento\Framework\App\Filesystem\DirectoryList::VAR_DIR
        );
    }
}
