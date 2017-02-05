<?php
/**
 * Unirgy LLC
 *
 * NOTICE OF LICENSE
 *
 * This source file is subject to the EULA
 * that is bundled with this package in the file LICENSE.txt.
 * It is also available through the world-wide-web at this URL:
 * http://www.unirgy.com/LICENSE-M1.txt
 *
 * @category   Unirgy
 * @package    Unirgy_DropshipBatch
 * @copyright  Copyright (c) 2008-2009 Unirgy LLC (http://www.unirgy.com)
 * @license    http:///www.unirgy.com/LICENSE-M1.txt
 */
 
namespace Unirgy\DropshipBatch\Block\Adminhtml\SystemConfigFormField;

use Magento\Config\Block\System\Config\Form\Field;
use Magento\Framework\Data\Form\Element\AbstractElement;

class Nl2customchar extends Field
{
    public function render(AbstractElement $element)
    {
        $html = parent::render($element);
        $html .=<<<EOT
<script type="text/javascript">
require(["jquery", "prototype","domReady!"], function(jQuery) {

$('{$element->getHtmlId()}').observe('change', function(e){
    var el = e.element()
    sync_nl2customchar_fields(el)
})
sync_nl2customchar_fields($('{$element->getHtmlId()}'))
function sync_nl2customchar_fields(el) {
    var stEl = $(el.id+'_value')
    if (el.value==0) {
        stEl.disable()
    } else {
        stEl.enable()
    }
}

});
</script>
EOT;
        return $html;
    }
}