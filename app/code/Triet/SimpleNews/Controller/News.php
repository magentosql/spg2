<?php

namespace Triet\SimpleNews\Controller;

use Magento\Framework\App\Action\Context;
use Magento\Framework\App\RequestInterface;
use Magento\Framework\View\Result\PageFactory;
use Triet\SimpleNews\Helper\Data;
use Triet\SimpleNews\Model\NewsFactory;

abstract class News extends \Magento\Framework\App\Action\Action
{
    /**
     * @var \Magento\Framework\View\Result\PageFactory
     */
    protected $_pageFactory;

    /**
     * @var \VM\SimpleNews\Helper\Data
     */
    protected $_dataHelper;

    /**
     * @var \VM\SimpleNews\Model\NewsFactory
     */
    protected $_newsFactory;

    /**
     * @param Context $context
     * @param PageFactory $pageFactory
     * @param Data $dataHelper
     * @param NewsFactory $newsFactory
     */
    public function __construct(
        Context $context,
        PageFactory $pageFactory,
        Data $dataHelper,
        NewsFactory $newsFactory
    ) {
        parent::__construct($context);
        $this->_pageFactory = $pageFactory;
        $this->_dataHelper = $dataHelper;
        $this->_newsFactory = $newsFactory;
    }

    /**
     * Dispatch request
     *
     * @param RequestInterface $request
     * @return \Magento\Framework\App\ResponseInterface
     */
    public function dispatch(RequestInterface $request)
    {
        // Check this module is enabled in frontend
        if ($this->_dataHelper->isEnabledInFrontend()) {
            $result = parent::dispatch($request);
            return $result;
        } else {
            $this->_forward('noroute');
        }
    }
}