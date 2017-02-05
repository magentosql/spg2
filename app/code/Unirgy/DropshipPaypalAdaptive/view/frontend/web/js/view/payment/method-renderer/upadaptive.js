/**
 * Copyright © 2016 Magento. All rights reserved.
 * See COPYING.txt for license details.
 */
/*browser:true*/
/*global define*/
define(
    [
        'Magento_Paypal/js/view/payment/method-renderer/paypal-express-abstract',
        'mage/url'
    ],
    function (Component,url) {
        'use strict';

        return Component.extend({
            defaults: {
                template: 'Unirgy_DropshipPaypalAdaptive/payment/upadaptive'
            },
            getBillingAgreementCode: function () {
                return '';
            },
            afterPlaceOrder: function () {
                console.log('afterPlaceOrder')
                console.log('afterPlaceOrder')
                this.redirectAfterPlaceOrder = false;
                window.location.replace(url.build('upadaptive/adaptive/redirect/'));
            }
        });
    }
);
