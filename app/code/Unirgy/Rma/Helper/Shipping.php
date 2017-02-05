<?php

namespace Unirgy\Rma\Helper;

use Magento\Shipping\Helper\Data as HelperData;
use Magento\Store\Model\StoreManagerInterface;
use Unirgy\Rma\Model\Rma;
use Unirgy\Rma\Model\Rma\Track;

class Shipping extends HelperData
{
    protected $_allowedHashKeys = ['ship_id', 'order_id', 'track_id', 'ustockpo_track_id', 'ustockpo_id', 'rma_track_id', 'rma_id'];
    public function getTrackingPopupUrlBySalesModel($model)
    {
        if ($model instanceof Track) {
            return $this->_getMyTrackingUrl('rma_track_id', $model);
        } elseif ($model instanceof Rma) {
            return $this->_getMyTrackingUrl('rma_id', $model);
        } elseif ($model instanceof \Unirgy\DropshipStockPo\Model\Po\Track) {
            return $this->_getMyTrackingUrl('ustockpo_track_id', $model);
        } elseif ($model instanceof \Unirgy\DropshipStockPo\Model\Po) {
            return $this->_getMyTrackingUrl('ustockpo_id', $model);
        } else {
            return parent::getTrackingPopupUrlBySalesModel($model);
        }
    }
    protected function _getMyTrackingUrl($key, $model, $method = 'getId')
    {
        $urlPart = "{$key}:{$model->{$method}()}:{$model->getProtectCode()}";
        $params = [
            '_direct' => 'urma/tracking/popup',
            '_query' => ['hash' => $this->urlEncoder->encode($urlPart)]
        ];
        $storeId = is_object($model) ? $model->getStoreId() : null;
        $storeModel = $this->_storeManager->getStore($storeId);
        return $storeModel->getUrl('', $params);
    }
}
