<?php

namespace Triet\SimpleNews\Controller\Adminhtml\News;

use Triet\SimpleNews\Controller\Adminhtml\News;

class Grid extends News
{
    /**
     * @return void
     */
    public function execute()
    {
        return $this->_resultPageFactory->create();
    }
}