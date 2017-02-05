<?php

namespace Unirgy\DropshipPo\Controller\Vendor;

use Magento\Framework\App\ObjectManager;
use Magento\Store\Model\StoreManagerInterface;
use Unirgy\Dropship\Model\Source;

class UdpoLabelBatch extends AbstractVendor
{
    public function execute()
    {
    	$result = [];
        try {
            $udpoHlp = $this->_poHlp;
            $udpos = $this->getVendorPoCollection();
            if (!$udpos->getSize()) {
                throw new \Exception('No purchase orders found for these criteria');
            }
            $shipments = [];
            foreach ($udpos as $udpo) {
                $udpoHlp->createReturnAllShipments=true;
                if (($_shipments = $udpoHlp->createShipmentFromPo($udpo, [], true, true, true))) {
                    foreach ($_shipments as $_shipment) {
                        $_shipment->setNewShipmentFlag(true);
                        $_shipment->setDeleteOnFailedLabelRequestFlag(true);
                        $_shipment->setCreatedByVendorFlag(true);
                        $shipments[] = $_shipment;
                    }
                } else {
                    foreach ($udpo->getShipmentsCollection() as $_s) {
                        if ($_s->getUdropshipStatus()==Source::SHIPMENT_STATUS_CANCELED) {
                            continue;
                        }
                        $shipments[] = $_s;
                        break;
                    }
                }
                $udpoHlp->createReturnAllShipments=false;
            }
            if (empty($shipments)) {
                throw new \Exception('Cannot create shipments (maybe nothing to create)');
            }

            $labelBatch = $this->_labelBatchFactory->create()
                ->setVendor(ObjectManager::getInstance()->get('Unirgy\Dropship\Model\Session')->getVendor())
                ->processShipments($shipments, [], ['mark_shipped'=>true]);

            if (!empty($shipments)) {
            	foreach ($shipments as $shipment) {
            		if (!$shipment->isDeleted()) {
            			$shipment->setNoInvoiceFlag(false);
            			$udpoHlp->invoiceShipment($shipment);
            		}
            	}
            }
            $labelBatch->prepareLabelsDownloadResponse();

        } catch (\Exception $e) {
            $this->_hlp->createObj('\Psr\Log\LoggerInterface')->error($e);
        	if ($this->getRequest()->getParam('use_json_response')) {
        		$result = [
        			'error'=>true,
        			'message'=>$e->getMessage()
        		];
        	} else {
                $this->messageManager->addError(__($e->getMessage()));
        	}
        }
    	if ($this->getRequest()->getParam('use_json_response')) {
        	$this->_resultRawFactory->create()->setContents(
        		$this->_hlp->jsonEncode($result)
        	);
        } else {
        	$this->_redirect('udpo/vendor/', ['_current'=>true, '_query'=>['submit_action'=>'']]);
        }
    }
}
