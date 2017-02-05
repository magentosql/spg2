<?php

namespace Unirgy\DropshipMulti\Controller\Vendor\Product;



class Index extends AbstractProduct
{
    public function execute()
    {
        $this->_renderPage(null, 'stockprice');
    }
}
