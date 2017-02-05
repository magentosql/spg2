/**
 * Copyright � 2015 Magento. All rights reserved.
 * See COPYING.txt for license details.
 */
define([
    'jquery',
    'mage/translate',
    'jquery/ui'
], function($, $t) {
    "use strict";

    $.widget('mage.catalogAddToCart', {

        options: {
            processStart: null,
            processStop: null,
            bindSubmit: true,
            minicartSelector: '[data-block="minicart"]',
            messagesSelector: '[data-placeholder="messages"]',
            productStatusSelector: '.stock.available',
            addToCartButtonSelector: '.action.tocart',
            addToCartButtonDisabledClass: 'disabled',
            addToCartButtonTextWhileAdding: $t('Adding...'),
            addToCartButtonTextAdded: $t('Added'),
            addToCartButtonTextDefault: $t('Add to Cart'),
            udmpAddtocartSelectedClass: 'udmp-addtocart-selected',
            udmpAddtocartSelectedSelector: '.udmp-addtocart-selected',
        },

        _create: function() {
            if (this.options.bindSubmit) {
                this._bindSubmit();
            }
        },

        _bindSubmit: function() {
            var self = this;
            this.element.on('submit', function(e) {
                e.preventDefault();
                self.submitForm($(this));
            });
        },

        isLoaderEnabled: function() {
            return this.options.processStart && this.options.processStop;
        },

        submitForm: function(form) {
            var self = this;
            if (form.has('input[type="file"]').length && form.find('input[type="file"]').val() !== '') {
                self.element.off('submit');
                form.submit();
            } else {
                self.ajaxSubmit(form);
            }
        },

        ajaxSubmit: function(form) {
            var self = this;
            $(self.options.minicartSelector).trigger('contentLoading');
            self.disableAddToCartButton(form);

            $.ajax({
                url: form.attr('action'),
                data: form.serialize(),
                type: 'post',
                dataType: 'json',
                beforeSend: function() {
                    if (self.isLoaderEnabled()) {
                        $('body').trigger(self.options.processStart);
                    }
                },
                success: function(res) {
                    if (self.isLoaderEnabled()) {
                        $('body').trigger(self.options.processStop);
                    }

                    if (res.backUrl) {
                        window.location = res.backUrl;
                        return;
                    }
                    if (res.messages) {
                        $(self.options.messagesSelector).html(res.messages);
                    }
                    if (res.minicart) {
                        $(self.options.minicartSelector).replaceWith(res.minicart);
                        $(self.options.minicartSelector).trigger('contentUpdated');
                    }
                    if (res.product && res.product.statusText) {
                        $(self.options.productStatusSelector)
                            .removeClass('available')
                            .addClass('unavailable')
                            .find('span')
                            .html(res.product.statusText);
                    }
                    self.enableAddToCartButton(form);
                }
            });
        },

        disableAddToCartButton: function(form) {
            var self = this;
            var addToCartButton = $(form).find(this.options.addToCartButtonSelector),
                addToCartButtonSel = $('#product-vendors-table').find(this.options.udmpAddtocartSelectedSelector);

            addToCartButton.addClass(this.options.addToCartButtonDisabledClass);

            if (addToCartButtonSel.length==0 && form != '#product-vendors-table') {
                addToCartButton.attr('title', this.options.addToCartButtonTextWhileAdding);
                addToCartButton.find('span').text(this.options.addToCartButtonTextWhileAdding);
            } else if (addToCartButtonSel.length>0 && form == '#product-vendors-table') {
                addToCartButtonSel.attr('title', this.options.addToCartButtonTextWhileAdding);
                addToCartButtonSel.find('span').text(this.options.addToCartButtonTextWhileAdding);
            }

            if (form != '#product-vendors-table' && $('#product-vendors-table')) {
                self.disableAddToCartButton('#product-vendors-table')
            }
        },

        enableAddToCartButton: function(form) {
            var self = this,
                addToCartButton = $(form).find(this.options.addToCartButtonSelector),
                addToCartButtonSel = $('#product-vendors-table').find(this.options.udmpAddtocartSelectedSelector);

            if (addToCartButtonSel.length==0 && form != '#product-vendors-table') {
                addToCartButton.find('span').text(this.options.addToCartButtonTextAdded);
                addToCartButton.attr('title', this.options.addToCartButtonTextAdded);
            } else if (addToCartButtonSel.length>0 && form == '#product-vendors-table') {
                addToCartButtonSel.find('span').text(this.options.addToCartButtonTextAdded);
                addToCartButtonSel.attr('title', this.options.addToCartButtonTextAdded);
            }

            setTimeout(function() {
                addToCartButton.removeClass(self.options.addToCartButtonDisabledClass);
                addToCartButton.find('span').text(self.options.addToCartButtonTextDefault);
                addToCartButton.attr('title', self.options.addToCartButtonTextDefault);
                addToCartButtonSel.removeClass(self.options.udmpAddtocartSelectedClass);
            }, 1000);

            if (form != '#product-vendors-table' && $('#product-vendors-table')) {
                self.enableAddToCartButton('#product-vendors-table')
            }
        }
    });

    return $.mage.catalogAddToCart;
});