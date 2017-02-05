<?php

namespace Unirgy\DropshipSellYours\Setup;

use Magento\Framework\DB\Ddl\Table;
use Magento\Framework\DB\Adapter\AdapterInterface;
use Magento\Framework\Setup\InstallSchemaInterface;
use Magento\Framework\Setup\ModuleContextInterface;
use Magento\Framework\Setup\SchemaSetupInterface;

class InstallSchema  implements InstallSchemaInterface
{
    const MEDIUMTEXT_SIZE = 16777216;
    const TEXT_SIZE = 65536;

    public function install(SchemaSetupInterface $setup, ModuleContextInterface $context)
    {
        $installer = $setup;
        $installer->startSetup();
        $connection = $installer->getConnection();

        $vendorTable = $installer->getTable('udropship_vendor');
        $connection->addColumn($vendorTable, 'username', ['TYPE'=>Table::TYPE_TEXT,'LENGTH'=>64,'nullable' => true,'COMMENT'=>'username']);
        $connection->addColumn($vendorTable, 'customer_id', ['TYPE'=>Table::TYPE_INTEGER,'unsigned' => true,'nullable' => true,'COMMENT'=>'customer_id']);
        $connection->addColumn($vendorTable, 'account_type', ['TYPE'=>Table::TYPE_TEXT,'LENGTH'=>20,'nullable' => true,'COMMENT'=>'account_type']);
        $connection->addColumn($vendorTable, 'is_featured', ['TYPE'=>Table::TYPE_SMALLINT,'nullable' => true,'COMMENT'=>'is_featured']);
        $customerTable = $installer->getTable('customer_entity');
        $connection->addColumn($customerTable, 'username', ['TYPE'=>Table::TYPE_TEXT,'LENGTH'=>64,'nullable' => true,'COMMENT'=>'username']);
        $connection->addColumn($customerTable, 'vendor_id', ['TYPE'=>Table::TYPE_INTEGER,'unsigned' => true,'nullable' => true,'COMMENT'=>'vendor_id']);

        $installer->endSetup();
    }
}