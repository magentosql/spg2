<?php

namespace Unirgy\Rma\Controller\Vendor;

class UrmaInfo extends AbstractVendor
{
    public function execute()
    {
        $this->_setTheme();
        $this->_view->addActionLayoutHandles();

        /** @var \Unirgy\Dropship\Block\Vendor\Shipment\Info $infoBlock */
        $infoBlock = $this->_view->getLayout()->getBlock('info');
        if (($url = $this->_registry->registry('udropship_download_url'))) {
            $infoBlock->setDownloadUrl($url);
        }
        $this->_view->getLayout()->initMessages();

        return $this->_resultRawFactory->create()->setContents($infoBlock->toHtml());
    }
}
