/**
 * Copyright © 2016 Magento. All rights reserved.
 * See COPYING.txt for license details.
 */
define(
    [
        'uiComponent',
        'Magento_Checkout/js/model/payment/renderer-list'
    ],
    function (
        Component,
        rendererList
    ) {
        'use strict';

        rendererList.push(
            {
                type: 'upadaptive',
                component: 'Unirgy_DropshipPaypalAdaptive/js/view/payment/method-renderer/upadaptive'
            }
        );

        /**
         * Add view logic here if needed
         **/
        return Component.extend({});
    }
);
