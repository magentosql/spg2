<?php

namespace Unirgy\DropshipSellYours\Controller\Index;



class SellSearch extends AbstractIndex
{
    public function execute()
    {
        $this->_getVendorSession()->setData('udsell_search_type', 0);
        $this->_getVendorSession()->setData('udsell_active_page', 'udsell');
        $this->_sellSearch();
    }
}
