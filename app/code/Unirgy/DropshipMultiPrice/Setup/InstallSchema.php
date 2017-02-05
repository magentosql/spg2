<?php

namespace Unirgy\DropshipMultiPrice\Setup;

use Magento\Framework\DB\Ddl\Table;
use Magento\Framework\DB\Adapter\AdapterInterface;
use Magento\Framework\Setup\InstallSchemaInterface;
use Magento\Framework\Setup\ModuleContextInterface;
use Magento\Framework\Setup\SchemaSetupInterface;
use Magento\Framework\App\ObjectManager;

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
        $connection->addColumn($vendorProductTable, 'vendor_title', ['TYPE'=>Table::TYPE_TEXT,'LENGTH'=>255,'nullable' => true,'COMMENT'=>'vendor_title']);
        $connection->addColumn($vendorProductTable, 'state', ['TYPE'=>Table::TYPE_TEXT,'LENGTH'=>32,'nullable' => true,'COMMENT'=>'state']);
        $connection->addColumn($vendorProductTable, 'state_descr', ['TYPE'=>Table::TYPE_TEXT,'LENGTH'=>255,'nullable' => true,'COMMENT'=>'state_descr']);
        $connection->addColumn($vendorProductTable, 'freeshipping', ['TYPE'=>Table::TYPE_SMALLINT,'nullable' => true,'COMMENT'=>'freeshipping']);
        $connection->addColumn($vendorProductTable, 'vendor_price', ['TYPE'=>Table::TYPE_DECIMAL,'LENGTH'=>'12,4','nullable' => true,'COMMENT'=>'vendor_price']);
        $connection->addColumn($vendorProductTable, 'special_price', ['TYPE'=>Table::TYPE_DECIMAL,'LENGTH'=>'12,4','nullable' => true,'COMMENT'=>'special_price']);
        $connection->addColumn($vendorProductTable, 'special_from_date', ['TYPE'=>Table::TYPE_DATETIME,'nullable' => true,'COMMENT'=>'special_from_date']);
        $connection->addColumn($vendorProductTable, 'special_to_date', ['TYPE'=>Table::TYPE_DATETIME,'nullable' => true,'COMMENT'=>'special_from_date']);

        $canStates = ObjectManager::getInstance()->get('\Unirgy\DropshipMultiPrice\Model\Source')
            ->setPath('vendor_product_state_canonic')
            ->toOptionHash();
        foreach ($canStates as $csKey=>$csLbl) {
            foreach (array(
                 $installer->getTable('catalog_product_index_price'),
                 $installer->getTable('catalog_product_index_price').'_idx',
                 $installer->getTable('catalog_product_index_price').'_tmp',
                 $installer->getTable('catalog_product_index_price_cfg_opt_agr').'_idx',
                 $installer->getTable('catalog_product_index_price_cfg_opt_agr').'_tmp',
                 $installer->getTable('catalog_product_index_price_cfg_opt').'_idx',
                 $installer->getTable('catalog_product_index_price_cfg_opt').'_tmp',
                 $installer->getTable('catalog_product_index_price_final_idx'),
                 $installer->getTable('catalog_product_index_price_final_tmp'),
             ) as $tbl) {
                $connection->addColumn($tbl, 'udmp_'.$csKey.'_min_price', 'decimal(12,4)');
                $connection->addColumn($tbl, 'udmp_'.$csKey.'_max_price', 'decimal(12,4)');
                $connection->addColumn($tbl, 'udmp_'.$csKey.'_cnt', 'int(10)');
            }
        }

        $installer->endSetup();
    }
}