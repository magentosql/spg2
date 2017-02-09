<?php

namespace Triet\SimpleNews\Controller\Adminhtml\News;


class Index extends \Triet\SimpleNews\Controller\Adminhtml\News
{
    /**
     * @return void
     */
    public function execute()
    {
        if ($this->getRequest()->getQuery('ajax')) {
            $this->_forward('grid');
            return;
        }

        /** @var \Magento\Backend\Model\View\Result\Page $resultPage */

        $resultPage = $this->_resultPageFactory->create();
        $resultPage->setActiveMenu('Triet_SimpleNews::main_menu');
        //var_dump($resultPage);

        $resultPage->getConfig()->getTitle()->prepend(__('Simple News'));

        return $resultPage;
    }
}