<?php

namespace Unirgy\DropshipSellYours\Controller\Index;



class MysellSearch extends AbstractIndex
{
    public function execute()
    {
        $this->_getVendorSession()->setData('udsell_search_type', 1);
        $this->_getVendorSession()->setData('udsell_active_page', 'udsell');
        $this->_sellSearch();
    }
}
