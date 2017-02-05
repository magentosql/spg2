<?php

namespace Unirgy\DropshipMulti\Ui\DataProvider\Product\Form\Modifier {

    use Magento\Ui\Component\Container;
    use Magento\Ui\Component\Form\Fieldset;
    use Magento\Ui\Component\Form\Element\DataType\Number;
    use Magento\Ui\Component\Form\Element\DataType\Price;
    use Magento\Ui\Component\Form\Element\DataType\Text;
    use Magento\Ui\Component\Form\Element\Input;
    use Magento\Ui\Component\Form\Element\Select;
    use Magento\Ui\Component\Form\Element\DataType\Date as DataTypeDate;
    use Magento\Ui\Component\Form\Field;
    use Magento\Customer\Api\Data\GroupInterface;
    use Magento\Customer\Api\GroupManagementInterface;
    use Magento\Customer\Api\GroupRepositoryInterface;
    use Magento\Framework\Api\SearchCriteriaBuilder;
    use Magento\Framework\Module\Manager as ModuleManager;
    use Magento\Ui\Component\Form;
    use Magento\Catalog\Api\Data\ProductAttributeInterface;

    $hlp = \Magento\Framework\App\ObjectManager::getInstance()->get('\Unirgy\Dropship\Helper\Data');
    if (!$hlp->compareMageVer('2.1')) {
        class Vendors
        {
        }
    } else {

        class Vendors extends \Magento\Catalog\Ui\DataProvider\Product\Form\Modifier\AbstractModifier
        {
            protected $locator;

            protected $arrayManager;

            protected $meta = [];

            protected $dtCollection;

            protected $moduleManager;

            protected $groupManagement;

            protected $searchCriteriaBuilder;

            protected $groupRepository;

            protected $_hlp;
            protected $_multiHlp;

            protected $storeManager;
            protected $directoryHelper;

            public function __construct(
                \Magento\Catalog\Model\Locator\LocatorInterface $locator,
                \Magento\Framework\Stdlib\ArrayManager $arrayManager,
                GroupRepositoryInterface $groupRepository,
                GroupManagementInterface $groupManagement,
                SearchCriteriaBuilder $searchCriteriaBuilder,
                ModuleManager $moduleManager,
                \Magento\Directory\Helper\Data $directoryHelper,
                \Magento\Store\Model\StoreManagerInterface $storeManager,
                \Unirgy\Dropship\Helper\Data $udropshipHelper,
                \Unirgy\DropshipMulti\Helper\Data $multiHelper
            )
            {
                $this->locator = $locator;
                $this->arrayManager = $arrayManager;
                $this->groupRepository = $groupRepository;
                $this->groupManagement = $groupManagement;
                $this->searchCriteriaBuilder = $searchCriteriaBuilder;
                $this->moduleManager = $moduleManager;
                $this->_multiHlp = $multiHelper;
                $this->_hlp = $udropshipHelper;
                $this->storeManager = $storeManager;
                $this->directoryHelper = $directoryHelper;
            }

            public function modifyData(array $data)
            {
                $vendors = $this->locator->getProduct()->getAllMultiVendorData() ?: [];

                return array_replace_recursive(
                    $data,
                    [
                        $this->locator->getProduct()->getId() => [
                            static::DATA_SOURCE_DEFAULT => [
                                'udmulti_vendors' => array_values($vendors)
                            ]
                        ]
                    ]
                );
            }

            public function modifyMeta(array $meta)
            {
                $this->meta = $meta;

                $this->addDropshipVendorsTab();

                return $this->meta;
            }

            protected function addDropshipVendorsTab()
            {
                $this->meta = array_replace_recursive(
                    $this->meta,
                    [
                        'udmulti_vendors_fieldset' => [
                            'arguments' => [
                                'data' => [
                                    'config' => [
                                        'label' => __('Dropship Vendors'),
                                        'componentType' => Fieldset::NAME,
                                        'dataScope' => 'data.product',
                                        'collapsible' => true,
                                        'sortOrder' => 9999,
                                    ],
                                ],
                            ],
                            'children' => [
                                'udmulti_vendors' => $this->getUdmultiVendorsStructure()
                            ]
                        ]
                    ]
                );

                return $this;
            }

            protected function getUdmultiVendorsStructure()
            {
                $costFields = [
                    'vendor_cost' => [
                        'arguments' => [
                            'data' => [
                                'config' => [
                                    'componentType' => Field::NAME,
                                    'formElement' => Input::NAME,
                                    'dataType' => Price::NAME,
                                    'label' => __('Cost'),
                                    'labelVisible' => true,
                                    'visible' => true,
                                    'enableLabel' => true,
                                    'dataScope' => 'vendor_cost',
                                    'addbefore' => $this->locator->getStore()
                                        ->getBaseCurrency()
                                        ->getCurrencySymbol(),
                                ],
                            ],
                        ],
                    ]
                ];
                if ($this->_hlp->isModuleActive('Unirgy_DropshipMultiPrice')) {
                    $costFields = array_merge($costFields, [
                        'vendor_price' => [
                            'arguments' => [
                                'data' => [
                                    'config' => [
                                        'componentType' => Field::NAME,
                                        'formElement' => Input::NAME,
                                        'dataType' => Price::NAME,
                                        'label' => __('Vendor Price'),
                                        'enableLabel' => true,
                                        'dataScope' => 'vendor_price',
                                        'addbefore' => $this->locator->getStore()
                                            ->getBaseCurrency()
                                            ->getCurrencySymbol(),
                                    ],
                                ],
                            ],
                        ],
                        'special_price' => [
                            'arguments' => [
                                'data' => [
                                    'config' => [
                                        'componentType' => Field::NAME,
                                        'formElement' => Input::NAME,
                                        'dataType' => Price::NAME,
                                        'label' => __('Special Price'),
                                        'enableLabel' => true,
                                        'dataScope' => 'special_price',
                                        'addbefore' => $this->locator->getStore()
                                            ->getBaseCurrency()
                                            ->getCurrencySymbol(),
                                    ],
                                ],
                            ],
                        ],
                        'special_from_date' => [
                            'arguments' => [
                                'data' => [
                                    'config' => [
                                        'componentType' => DataTypeDate::NAME,
                                        'formElement' => DataTypeDate::NAME,
                                        'dataType' => DataTypeDate::NAME,
                                        'label' => __('Special From Date'),
                                        'enableLabel' => true,
                                        'dataScope' => 'special_from_date',
                                    ],
                                ],
                            ],
                        ],
                        'special_to_date' => [
                            'arguments' => [
                                'data' => [
                                    'config' => [
                                        'componentType' => DataTypeDate::NAME,
                                        'formElement' => DataTypeDate::NAME,
                                        'dataType' => DataTypeDate::NAME,
                                        'label' => __('Special To Date'),
                                        'enableLabel' => true,
                                        'dataScope' => 'special_to_date',
                                    ],
                                ],
                            ],
                        ],

                    ]);
                }
                $costFields = array_merge($costFields, [
                    'freeshipping' => [
                        'arguments' => [
                            'data' => [
                                'config' => [
                                    'dataType' => Select::NAME,
                                    'formElement' => Select::NAME,
                                    'componentType' => Field::NAME,
                                    'label' => __('Free Shipping'),
                                    'enableLabel' => true,
                                    'dataScope' => 'freeshipping',
                                    'options' => $this->_hlp->src()->setPath('yesno')->toOptionArray(),
                                ],
                            ],
                        ],
                    ]
                ]);
                if ($this->_multiHlp->isVendorProductShipping()) {
                    $costFields = array_merge($costFields, [
                        'shipping_price' => [
                            'arguments' => [
                                'data' => [
                                    'config' => [
                                        'componentType' => Field::NAME,
                                        'formElement' => Input::NAME,
                                        'dataType' => Price::NAME,
                                        'label' => __('Shipping Price'),
                                        'enableLabel' => true,
                                        'dataScope' => 'shipping_price',
                                        'addbefore' => $this->locator->getStore()
                                            ->getBaseCurrency()
                                            ->getCurrencySymbol(),
                                    ],
                                ],
                            ],
                        ],
                    ]);
                }
                $stockFields = [
                    'stock_qty' => [
                        'arguments' => [
                            'data' => [
                                'config' => [
                                    'componentType' => Field::NAME,
                                    'formElement' => Input::NAME,
                                    'dataType' => Text::NAME,
                                    'label' => __('Stock QTY'),
                                    'enableLabel' => true,
                                    'dataScope' => 'stock_qty'
                                ],
                            ],
                        ],
                    ],
                    'backorders' => [
                        'arguments' => [
                            'data' => [
                                'config' => [
                                    'dataType' => Select::NAME,
                                    'formElement' => Select::NAME,
                                    'componentType' => Field::NAME,
                                    'label' => __('Backorders'),
                                    'enableLabel' => true,
                                    'dataScope' => 'backorders',
                                    'options' => $this->getBackordersOptions(),
                                    'additionalClasses' => 'udmulti-backorders'
                                ],
                            ],
                        ],
                    ],
                    'vendor_sku' => [
                        'arguments' => [
                            'data' => [
                                'config' => [
                                    'formElement' => Input::NAME,
                                    'componentType' => Field::NAME,
                                    'dataType' => Number::NAME,
                                    'label' => __('Vendor SKU'),
                                    'dataScope' => 'vendor_sku',
                                ],
                            ],
                        ],
                    ],
                ];
                $statusFields = [
                    'status' => [
                        'arguments' => [
                            'data' => [
                                'config' => [
                                    'dataType' => Select::NAME,
                                    'formElement' => Select::NAME,
                                    'componentType' => Field::NAME,
                                    'label' => __('Status'),
                                    'enableLabel' => true,
                                    'dataScope' => 'status',
                                    'options' => $this->getStatusOptions()
                                ],
                            ],
                        ],
                    ],
                ];
                if ($this->_hlp->isModuleActive('Unirgy_DropshipMultiPrice')) {
                    $statusFields = array_merge($statusFields, [
                        'state' => [
                            'arguments' => [
                                'data' => [
                                    'config' => [
                                        'dataType' => Select::NAME,
                                        'formElement' => Select::NAME,
                                        'componentType' => Field::NAME,
                                        'label' => __('State (Condition)'),
                                        'enableLabel' => true,
                                        'dataScope' => 'state',
                                        'options' => $this->getStateOptions()
                                    ],
                                ],
                            ],
                        ]
                    ]);
                }
                $statusFields = array_merge($statusFields, [
                    'priority' => [
                        'arguments' => [
                            'data' => [
                                'config' => [
                                    'formElement' => Input::NAME,
                                    'componentType' => Field::NAME,
                                    'dataType' => Number::NAME,
                                    'label' => __('Priority'),
                                    'dataScope' => 'priority',
                                ],
                            ],
                        ],
                    ],
                ]);
                $tierPriceContainer = [
                    'arguments' => [
                        'data' => [
                            'config' => [
                                'component' => 'Magento_Ui/js/form/components/fieldset',
                                'collapsible' => true,
                                'componentType' => Container::NAME,
                                'label' => __('Tier Price'),
                                'visible' => true,
                                'showLabel' => false
                            ],
                        ],
                    ],
                    'children' => [
                        'tier_price' => [
                            'arguments' => [
                                'data' => [
                                    'config' => [
                                        'additionalClasses' => 'udmulti-vendors-tierprice',
                                        'componentType' => 'dynamicRows',
                                        'label' => __(''),
                                        'labelVisible' => true,
                                        'renderDefaultRecord' => false,
                                        'recordTemplate' => 'record',
                                        'dataScope' => '',
                                        'dndConfig' => [
                                            'enabled' => false,
                                        ],
                                        'disabled' => false,
                                        'sortOrder' => 0,
                                    ]
                                ],
                            ],
                            'children' => [
                                'record' => [
                                    'arguments' => [
                                        'data' => [
                                            'config' => [
                                                'componentType' => Container::NAME,
                                                'isTemplate' => true,
                                                'is_collection' => true,
                                                'component' => 'Magento_Ui/js/dynamic-rows/record',
                                                'dataScope' => '',
                                                'labelVisible' => true,
                                            ],
                                        ],
                                    ],
                                    'children' => [
                                        'website_customer' => [
                                            'arguments' => [
                                                'data' => [
                                                    'config' => [
                                                        'component' => 'Unirgy_DropshipMulti/js/form/components/group',
                                                        'componentType' => Container::NAME,
                                                        'label' => __('Website/Customer'),
                                                        'visible' => true,
                                                        'showLabel' => false
                                                    ],
                                                ],
                                            ],
                                            'children' => [
                                                'website_id' => [
                                                    'arguments' => [
                                                        'data' => [
                                                            'config' => [
                                                                'dataType' => Select::NAME,
                                                                'formElement' => Select::NAME,
                                                                'componentType' => Field::NAME,
                                                                'dataScope' => 'website_id',
                                                                'label' => __('Website'),
                                                                'options' => $this->getWebsites(),
                                                            ],
                                                        ],
                                                    ],
                                                ],
                                                'customer_group_id' => [
                                                    'arguments' => [
                                                        'data' => [
                                                            'config' => [
                                                                'dataType' => Select::NAME,
                                                                'formElement' => Select::NAME,
                                                                'componentType' => Field::NAME,
                                                                'dataScope' => 'customer_group_id',
                                                                'label' => __('Website'),
                                                                'options' => $this->getCustomerGroups(),
                                                            ],
                                                        ],
                                                    ],
                                                ]
                                            ]
                                        ],
                                        'price_qty' => [
                                            'arguments' => [
                                                'data' => [
                                                    'config' => [
                                                        'component' => 'Unirgy_DropshipMulti/js/form/components/group',
                                                        'componentType' => Container::NAME,
                                                        'label' => __('QTY/Price'),
                                                        'visible' => true,
                                                        'showLabel' => false
                                                    ],
                                                ],
                                            ],
                                            'children' => [
                                                'qty' => [
                                                    'arguments' => [
                                                        'data' => [
                                                            'config' => [
                                                                'formElement' => Input::NAME,
                                                                'componentType' => Field::NAME,
                                                                'dataType' => Number::NAME,
                                                                'label' => __('QTY'),
                                                                'dataScope' => 'qty',
                                                            ],
                                                        ],
                                                    ],
                                                ],
                                                'value' => [
                                                    'arguments' => [
                                                        'data' => [
                                                            'config' => [
                                                                'componentType' => Field::NAME,
                                                                'formElement' => Input::NAME,
                                                                'dataType' => Price::NAME,
                                                                'label' => __('Price'),
                                                                'enableLabel' => true,
                                                                'dataScope' => 'value',
                                                                'addbefore' => $this->locator->getStore()
                                                                    ->getBaseCurrency()
                                                                    ->getCurrencySymbol(),
                                                            ],
                                                        ],
                                                    ],
                                                ],
                                            ],
                                        ],
                                        'value_id' => [
                                            'arguments' => [
                                                'data' => [
                                                    'config' => [
                                                        'dataType' => Form\Element\DataType\Number::NAME,
                                                        'formElement' => Form\Element\Hidden::NAME,
                                                        'componentType' => Form\Field::NAME,
                                                        'dataScope' => 'value_id',
                                                    ],
                                                ],
                                            ]
                                        ],
                                        'actionDelete' => [
                                            'arguments' => [
                                                'data' => [
                                                    'config' => [
                                                        'componentType' => 'actionDelete',
                                                        'dataType' => Text::NAME,
                                                        'label' => '',
                                                    ],
                                                ],
                                            ],
                                        ],
                                    ]
                                ]
                            ],
                        ],
                    ]
                ];
                $result = [
                    'arguments' => [
                        'data' => [
                            'config' => [
                                'componentType' => 'dynamicRows',
                                'additionalClasses' => 'udmulti-vendors-fieldset',
                                'label' => __(''),
                                'labelVisible' => true,
                                'renderDefaultRecord' => false,
                                'recordTemplate' => 'record',
                                'dataScope' => '',
                                'dndConfig' => [
                                    'enabled' => false,
                                ],
                                'disabled' => false,
                                'sortOrder' => 0,
                            ],
                        ],
                    ],
                    'children' => [
                        'record' => [
                            'arguments' => [
                                'data' => [
                                    'config' => [
                                        'componentType' => Container::NAME,
                                        'isTemplate' => true,
                                        'is_collection' => true,
                                        'component' => 'Magento_Ui/js/dynamic-rows/record',
                                        'template' => 'Unirgy_DropshipMulti/dynamic-rows',
                                        'dataScope' => '',
                                        'labelVisible' => true,
                                    ],
                                ],
                            ],
                            'children' => [
                                'actionDelete' => [
                                    'arguments' => [
                                        'data' => [
                                            'config' => [
                                                'componentType' => 'actionDelete',
                                                'dataType' => Text::NAME,
                                                'label' => '',
                                            ],
                                        ],
                                    ],
                                ],
                                'vendor_id' => [
                                    'arguments' => [
                                        'data' => [
                                            'config' => [
                                                'dataType' => Select::NAME,
                                                'formElement' => Select::NAME,
                                                'componentType' => Field::NAME,
                                                'dataScope' => 'vendor_id',
                                                'label' => __('Vendor Name'),
                                                'options' => $this->getVendors(),
                                            ],
                                        ],
                                    ],
                                ],
                                'container_cost' => [
                                    'arguments' => [
                                        'data' => [
                                            'config' => [
                                                'component' => 'Unirgy_DropshipMulti/js/form/components/group',
                                                'componentType' => Container::NAME,
                                                'label' => __('Cost'),
                                                'visible' => true,
                                                'showLabel' => false
                                            ],
                                        ],
                                    ],
                                    'children' => $costFields
                                ],
                                'container_status_stock' => [
                                    'arguments' => [
                                        'data' => [
                                            'config' => [
                                                'component' => 'Unirgy_DropshipMulti/js/form/components/group',
                                                'componentType' => Container::NAME,
                                                'label' => __('Stock/Status'),
                                                'visible' => true,
                                                'showLabel' => false,
                                                'additionalClasses' => 'udmulti-container-status-stock'
                                            ],
                                        ],
                                    ],
                                    'children' => array_merge($stockFields, $statusFields)
                                ],
                            ],
                        ],
                    ],
                ];
                if ($this->_hlp->isModuleActive('Unirgy_DropshipMultiPrice')) {
                    $result['children']['record']['children']['tier_price_container'] = $tierPriceContainer;
                }
                return $result;
            }

            protected function getVendors()
            {
                return $this->_hlp->src()->setPath('allvendors')->toOptionArray();
            }

            protected function getCustomerGroups()
            {
                if (!$this->moduleManager->isEnabled('Magento_Customer')) {
                    return [];
                }
                $customerGroups = [
                    [
                        'label' => __('ALL GROUPS'),
                        'value' => GroupInterface::CUST_GROUP_ALL,
                    ]
                ];

                /** @var GroupInterface[] $groups */
                $groups = $this->groupRepository->getList($this->searchCriteriaBuilder->create());
                foreach ($groups->getItems() as $group) {
                    $customerGroups[] = [
                        'label' => $group->getCode(),
                        'value' => $group->getId(),
                    ];
                }

                return $customerGroups;
            }
            protected function getWebsites()
            {
                $websites = [
                    [
                        'label' => __('All Websites') . ' [' . $this->directoryHelper->getBaseCurrencyCode() . ']',
                        'value' => 0,
                    ]
                ];
                $product = $this->locator->getProduct();

                if (!$this->isScopeGlobal() && $product->getStoreId()) {
                    /** @var \Magento\Store\Model\Website $website */
                    $website = $this->getStore()->getWebsite();

                    $websites[] = [
                        'label' => $website->getName() . '[' . $website->getBaseCurrencyCode() . ']',
                        'value' => $website->getId(),
                    ];
                } elseif (!$this->isScopeGlobal()) {
                    $websitesList = $this->storeManager->getWebsites();
                    $productWebsiteIds = $product->getWebsiteIds();
                    foreach ($websitesList as $website) {
                        /** @var \Magento\Store\Model\Website $website */
                        if (!in_array($website->getId(), $productWebsiteIds)) {
                            continue;
                        }
                        $websites[] = [
                            'label' => $website->getName() . '[' . $website->getBaseCurrencyCode() . ']',
                            'value' => $website->getId(),
                        ];
                    }
                }

                return $websites;
            }
            protected function isScopeGlobal()
            {
                return $this->locator->getProduct()
                    ->getResource()
                    ->getAttribute(ProductAttributeInterface::CODE_TIER_PRICE)
                    ->isScopeGlobal();
            }
            protected function getStore()
            {
                return $this->locator->getStore();
            }

            protected function getBackordersOptions()
            {
                return $this->_hlp->getObj('Unirgy\DropshipMulti\Model\Source')->setPath('backorders')->toOptionArray();
            }
            protected function getStatusOptions()
            {
                return $this->_hlp->getObj('Unirgy\DropshipMulti\Model\Source')->setPath('vendor_product_status')->toOptionArray();
            }

            protected function getStateOptions()
            {
                return $this->_hlp->getObj('Unirgy\DropshipMultiPrice\Model\Source')->setPath('vendor_product_state')->toOptionArray();
            }
        }
    }
}