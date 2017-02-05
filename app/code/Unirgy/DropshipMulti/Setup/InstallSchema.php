<?php

namespace Unirgy\DropshipMulti\Setup;

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

        $vendorProductTable = $installer->getTable('udropship_vendor_product');
        $connection->addColumn($vendorProductTable, 'backorders', ['TYPE'=>Table::TYPE_SMALLINT,'nullable' => true,'COMMENT'=>'backorders']);
        $connection->addColumn($vendorProductTable, 'status', ['TYPE'=>Table::TYPE_SMALLINT,'nullable' => true,'COMMENT'=>'status']);
        $connection->addColumn($vendorProductTable, 'shipping_price', ['TYPE'=>Table::TYPE_DECIMAL,'LENGTH'=>'12,4','nullable' => true,'COMMENT'=>'shipping_price']);

        $installer->endSetup();
    }
}