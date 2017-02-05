/**
 * Copyright © 2016 Magento. All rights reserved.
 * See COPYING.txt for license details.
 */

define([
    'jquery',
    'Magento_Ui/js/form/components/group'
], function ($, Group) {
    'use strict';

    return Group.extend({

        _setClasses: function () {
            var addtional = this.additionalClasses,
                classes;

            if (_.isString(addtional)) {
                addtional = this.additionalClasses.split(' ');
                classes = this.additionalClasses = {};

                addtional.forEach(function (name) {
                    classes[name] = true;
                }, this);
            }

            _.extend(this.additionalClasses, {
                'admin__control-grouped': !this.breakLine,
                required:   this.required,
                _error:     this.error,
                _disabled:  this.disabled
            });

            return this;
        },
    });
});
