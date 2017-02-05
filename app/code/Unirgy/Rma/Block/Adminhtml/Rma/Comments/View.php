<?php

namespace Unirgy\Rma\Block\Adminhtml\Rma\Comments;

use Magento\Sales\Block\Adminhtml\Order\Comments\View as CommentsView;

class View extends CommentsView
{
    public function canSendCommentEmail()
    {
        return true;
    }
}