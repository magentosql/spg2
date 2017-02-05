<?php

namespace Unirgy\DropshipMulti\Setup;

use Magento\Framework\Setup\UpgradeSchemaInterface;
use Magento\Framework\Setup\ModuleContextInterface;
use Magento\Framework\Setup\SchemaSetupInterface;
use Magento\Framework\DB\Ddl\Table;
use Magento\Framework\DB\Adapter\AdapterInterface;

class UpgradeSchema implements UpgradeSchemaInterface
{
    /**
     * {@inheritdoc}
     */
    public function upgrade(SchemaSetupInterface $setup, ModuleContextInterface $context)
    {
        $setup->startSetup();
        $connection = $setup->getConnection();
        if (version_compare($context->getVersion(), '3.1.10', '<')) {

            $tpTable = $setup->getTable('udmulti_tier_price');
            $table = $connection->newTable($tpTable)
                ->addColumn('value_id', Table::TYPE_INTEGER, 10, [
                    'identity' => true,
                    'unsigned' => true,
                    'nullable' => false,
                    'primary'  => true
                ])
                ->addColumn('vendor_product_id', Table::TYPE_INTEGER, null, ['unsigned' => true,'nullable' => false])
                ->addColumn('product_id', Table::TYPE_INTEGER, null, ['unsigned' => true,'nullable' => false])
                ->addColumn('vendor_id', Table::TYPE_INTEGER, null, ['unsigned' => true,'nullable' => false])
                ->addColumn('all_groups', Table::TYPE_SMALLINT, null, ['unsigned' => true,'nullable' => false])
                ->addColumn('customer_group_id', Table::TYPE_SMALLINT, null, ['unsigned' => true,'nullable' => false])
                ->addColumn('qty', Table::TYPE_DECIMAL, [12,4], ['nullable' => false,'default'=>1])
                ->addColumn('value', Table::TYPE_DECIMAL, [12,4], ['nullable' => false,'default'=>1])
                ->addColumn('website_id', Table::TYPE_SMALLINT, null, ['unsigned' => true,'nullable' => false])
                ->addIndex(
                    $setup->getIdxName(
                        $tpTable,
                        ['product_id','vendor_id','all_groups','customer_group_id','qty','website_id'],
                        AdapterInterface::INDEX_TYPE_UNIQUE
                    ),
                    ['product_id','vendor_id','all_groups','customer_group_id','qty','website_id'],
                    ['type' => AdapterInterface::INDEX_TYPE_UNIQUE]
                )
                ->addIndex(
                    $setup->getIdxName($tpTable, ['product_id']),
                    ['product_id']
                )
                ->addIndex(
                    $setup->getIdxName($tpTable, ['vendor_id']),
                    ['vendor_id']
                )
                ->addIndex(
                    $setup->getIdxName($tpTable, ['customer_group_id']),
                    ['customer_group_id']
                )
                ->addIndex(
                    $setup->getIdxName($tpTable, ['website_id']),
                    ['website_id']
                )
                ->addForeignKey(
                    $setup->getFkName($tpTable, 'vendor_id', 'udropship_vendor', 'vendor_id'),
                    'vendor_id',
                    $setup->getTable('udropship_vendor'),
                    'vendor_id',
                    Table::ACTION_CASCADE
                )
                ->addForeignKey(
                    $setup->getFkName($tpTable, 'product_id', 'catalog_product_entity', 'entity_id'),
                    'product_id',
                    $setup->getTable('catalog_product_entity'),
                    'entity_id',
                    Table::ACTION_CASCADE
                )
                ->addForeignKey(
                    $setup->getFkName($tpTable, 'website_id', 'store_website', 'website_id'),
                    'website_id',
                    $setup->getTable('store_website'),
                    'website_id',
                    Table::ACTION_CASCADE
                )
                ->addForeignKey(
                    $setup->getFkName($tpTable, 'customer_group_id', 'customer_group', 'customer_group_id'),
                    'customer_group_id',
                    $setup->getTable('customer_group'),
                    'customer_group_id',
                    Table::ACTION_CASCADE
                )
                ->setComment('Multivendor Tier Price Table')
                ->setOption('type', 'InnoDB')
                ->setOption('charset', 'utf8');
            $connection->createTable($table);
        }

        $setup->endSetup();
    }
}
