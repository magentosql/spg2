<?php

namespace Unirgy\DropshipSellYours\Controller\Adminhtml\Vendor;

class MassIsFeatured extends AbstractVendor
{

    public function execute()
    {
        $modelIds = (array)$this->getRequest()->getParam('vendor');
        $is_featured = (string)$this->getRequest()->getParam('is_featured');

        try {
            foreach ($modelIds as $modelId) {
                $this->_hlp->createObj('\Unirgy\Dropship\Model\Vendor')->load($modelId)->setData('is_featured', $is_featured)->save();
            }
            $this->messageManager->addSuccess(
                __('Total of %1 record(s) were successfully updated', count($modelIds))
            );
        }
        catch (\Magento\Framework\Exception\LocalizedException $e) {
            $this->messageManager->addError($e->getMessage());
        }
        catch (\Exception $e) {
            $this->messageManager->addException($e, __('There was an error while updating vendor(s) is featured'));
        }

        $this->_redirect('udropship/vendor/index');
    }
}
