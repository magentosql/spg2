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
 * @package    \Unirgy\Dropship
 * @copyright  Copyright (c) 2015-2016 Unirgy LLC (http://www.unirgy.com)
 * @license    http:///www.unirgy.com/LICENSE-M1.txt
 */

namespace Unirgy\Rma\Setup;

use Magento\Framework\DB\Ddl\Table;
use Magento\Framework\DB\Adapter\AdapterInterface;
use Magento\Framework\Setup\InstallSchemaInterface;
use Magento\Framework\Setup\ModuleContextInterface;
use Magento\Framework\Setup\SchemaSetupInterface;

class InstallSchema implements InstallSchemaInterface
{
    const MEDIUMTEXT_SIZE = 16777216;
    const TEXT_SIZE = 65536;

    public function install(SchemaSetupInterface $setup, ModuleContextInterface $context)
    {
        $installer = $setup;
        $installer->startSetup();
        $connection = $installer->getConnection();

        $rmaTable = $installer->getTable('urma_rma');
        $rmaGridTable = $installer->getTable('urma_rma_grid');
        $rmaItemTable = $installer->getTable('urma_rma_item');
        $rmaCommentTable = $installer->getTable('urma_rma_comment');
        $rmaTrackTable = $installer->getTable('urma_rma_track');
        $shipmentTable = $installer->getTable('sales_shipment');
        $shipmentGridTable = $installer->getTable('sales_shipment_grid');
        $shipmentItemTable = $installer->getTable('sales_shipment_item');
        $shipmentCommentTable = $installer->getTable('sales_shipment_comment');
        $shipmentTrackTable = $installer->getTable('sales_shipment_track');

        $rmaTableDdl = $connection->createTableByDdl($shipmentTable, $rmaTable);
        $rmaItemTableDdl = $connection->createTableByDdl($shipmentItemTable, $rmaItemTable);
        $rmaCommentTableDdl = $connection->createTableByDdl($shipmentCommentTable, $rmaCommentTable);
        $rmaTrackTableDdl = $connection->createTableByDdl($shipmentTrackTable, $rmaTrackTable);
        $connection->createTable($rmaTableDdl);
        $connection->createTable($rmaItemTableDdl);
        $connection->createTable($rmaCommentTableDdl);
        $connection->createTable($rmaTrackTableDdl);
        foreach ([$rmaTableDdl, $rmaItemTableDdl, $rmaCommentTableDdl, $rmaTrackTableDdl] as $tableDdl) {
            foreach ($tableDdl->getForeignKeys() as $fkName => $foreignKey) {
                $connection->dropForeignKey($tableDdl->getName(), $fkName);
            }
        }

        $connection->addColumn($rmaTable, 'udropship_status', ['TYPE'=>Table::TYPE_SMALLINT,'nullable' => true,'COMMENT'=>'udropship_status']);
        $connection->addColumn($rmaTable, 'shipping_amount', ['TYPE'=>Table::TYPE_DECIMAL,'LENGTH' => '12,4','nullable' => true,'COMMENT'=>'shipping_amount']);
        $connection->addColumn($rmaTable, 'udropship_method', ['TYPE'=>Table::TYPE_TEXT,'LENGTH' => 64,'nullable' => true,'COMMENT'=>'udropship_method']);
        $connection->addColumn($rmaTable, 'udropship_method_description', ['TYPE'=>Table::TYPE_TEXT,'LENGTH' => 128,'nullable' => true,'COMMENT'=>'udropship_method_description']);
        $connection->addColumn($rmaTable, 'total_qty', ['TYPE'=>Table::TYPE_DECIMAL,'LENGTH' => '12,4','nullable' => true,'COMMENT'=>'total_qty']);
        $connection->addColumn($rmaTable, 'udropship_vendor', ['TYPE'=>Table::TYPE_INTEGER,'nullable' => false,'unsigned' => true,'COMMENT'=>'udropship_vendor']);
        $connection->addColumn($rmaTable, 'rma_status', ['TYPE'=>Table::TYPE_TEXT,'nullable' => true,'LENGTH'=>32,'COMMENT'=>'rma_status']);
        $connection->addColumn($rmaCommentTable, 'rma_status', ['TYPE'=>Table::TYPE_TEXT,'nullable' => true,'LENGTH'=>32,'COMMENT'=>'rma_status']);
        $connection->addColumn($rmaCommentTable, 'is_vendor_notified', ['TYPE'=>Table::TYPE_SMALLINT,'nullable' => true,'COMMENT'=>'is_vendor_notified']);
        $connection->addColumn($rmaCommentTable, 'is_visible_to_vendor', ['TYPE'=>Table::TYPE_SMALLINT,'nullable' => true,'COMMENT'=>'is_visible_to_vendor']);
        $connection->addColumn($rmaCommentTable, 'udropship_status', ['TYPE'=>Table::TYPE_TEXT,'nullable' => true,'LENGTH'=>64,'COMMENT'=>'udropship_status']);
        $connection->addColumn($rmaCommentTable, 'username', ['TYPE'=>Table::TYPE_TEXT,'nullable' => true,'LENGTH'=>40,'COMMENT'=>'username']);
        $connection->addColumn($rmaTable, 'is_admin', ['TYPE'=>Table::TYPE_SMALLINT,'nullable' => true,'COMMENT'=>'is_admin']);
        $connection->addColumn($rmaTable, 'is_customer', ['TYPE'=>Table::TYPE_SMALLINT,'nullable' => true,'COMMENT'=>'is_customer']);
        $connection->addColumn($rmaTable, 'resolution_notes', ['TYPE'=>Table::TYPE_TEXT,'nullable' => true,'LENGTH'=>255,'COMMENT'=>'resolution_notes']);
        $connection->addColumn($rmaTable, 'rma_reason', ['TYPE'=>Table::TYPE_TEXT,'nullable' => true,'LENGTH'=>128,'COMMENT'=>'rma_reason']);
        $connection->addColumn($rmaTable, 'username', ['TYPE'=>Table::TYPE_TEXT,'nullable' => true,'LENGTH'=>40,'COMMENT'=>'username']);
        $connection->addColumn($rmaTable, 'shipment_id', ['TYPE'=>Table::TYPE_INTEGER,'nullable' => true,'unsigned' => true,'COMMENT'=>'shipment_id']);
        $connection->addColumn($rmaTable, 'shipment_increment_id', ['TYPE'=>Table::TYPE_TEXT,'nullable' => true,'LENGTH'=>50,'COMMENT'=>'shipment_increment_id']);
        $connection->addColumn($rmaItemTable, 'item_condition', ['TYPE'=>Table::TYPE_TEXT,'nullable' => true,'LENGTH'=>128,'COMMENT'=>'item_condition']);

        $connection->addColumn($rmaTrackTable, 'batch_id', ['TYPE'=>Table::TYPE_INTEGER,'nullable' => true,'COMMENT'=>'batch_id']);
        $connection->addColumn($rmaTrackTable, 'master_tracking_id', ['TYPE'=>Table::TYPE_TEXT,'LENGTH'=>255,'nullable' => true,'COMMENT'=>'master_tracking_id']);
        $connection->addColumn($rmaTrackTable, 'package_count', ['TYPE'=>Table::TYPE_SMALLINT,'nullable' => true,'COMMENT'=>'package_count']);
        $connection->addColumn($rmaTrackTable, 'package_idx', ['TYPE'=>Table::TYPE_SMALLINT,'nullable' => true,'COMMENT'=>'package_idx']);
        $connection->addColumn($rmaTrackTable, 'label_image', ['TYPE'=>Table::TYPE_TEXT,'LENGTH'=>self::TEXT_SIZE,'nullable' => true,'COMMENT'=>'label_image']);
        $connection->addColumn($rmaTrackTable, 'label_format', ['TYPE'=>Table::TYPE_TEXT,'LENGTH'=>10,'nullable' => true,'COMMENT'=>'label_format']);
        $connection->addColumn($rmaTrackTable, 'label_pic', ['TYPE'=>Table::TYPE_TEXT,'LENGTH'=>255,'nullable' => true,'COMMENT'=>'label_pic']);
        $connection->addColumn($rmaTrackTable, 'final_price', ['TYPE'=>Table::TYPE_DECIMAL,'LENGTH' => '12,4','nullable' => true,'COMMENT'=>'final_price']);
        $connection->addColumn($rmaTrackTable, 'value', ['TYPE'=>Table::TYPE_DECIMAL,'LENGTH' => '12,4','nullable' => true,'COMMENT'=>'value']);
        $connection->addColumn($rmaTrackTable, 'length', ['TYPE'=>Table::TYPE_DECIMAL,'LENGTH' => '12,4','nullable' => true,'COMMENT'=>'length']);
        $connection->addColumn($rmaTrackTable, 'width', ['TYPE'=>Table::TYPE_DECIMAL,'LENGTH' => '12,4','nullable' => true,'COMMENT'=>'width']);
        $connection->addColumn($rmaTrackTable, 'height', ['TYPE'=>Table::TYPE_DECIMAL,'LENGTH' => '12,4','nullable' => true,'COMMENT'=>'height']);
        $connection->addColumn($rmaTrackTable, 'result_extra', ['TYPE'=>Table::TYPE_TEXT,'LENGTH'=>self::TEXT_SIZE,'nullable' => true,'COMMENT'=>'result_extra']);
        $connection->addColumn($rmaTrackTable, 'pkg_num', ['TYPE'=>Table::TYPE_INTEGER,'nullable' => true,'COMMENT'=>'pkg_num']);
        $connection->addColumn($rmaTrackTable, 'int_label_image', ['TYPE'=>Table::TYPE_TEXT,'LENGTH'=>self::TEXT_SIZE,'nullable' => true,'COMMENT'=>'int_label_image']);
        $connection->addColumn($rmaTrackTable, 'label_render_options', ['TYPE'=>Table::TYPE_TEXT,'LENGTH'=>self::TEXT_SIZE,'nullable' => true,'COMMENT'=>'label_render_options']);
        $connection->addColumn($rmaTrackTable, 'udropship_status', ['TYPE'=>Table::TYPE_TEXT,'LENGTH'=>20,'nullable' => true,'COMMENT'=>'udropship_status']);
        $connection->addColumn($rmaTrackTable, 'next_check', ['TYPE'=>Table::TYPE_DATETIME,'nullable' => true,'COMMENT'=>'next_check']);

        $orderItemTable = $installer->getTable('sales_order_item');
        $connection->addColumn($orderItemTable, 'qty_urma', ['TYPE'=>Table::TYPE_DECIMAL,'LENGTH'=>'12,4','nullable' => false,'default'=>0,'COMMENT'=>'qty_urma']);

        $orderTable = $installer->getTable('sales_order');
        $storeTable = $installer->getTable('store');

        $connection->addForeignKey(
            $installer->getFkName($rmaTable, 'order_id', $orderTable, 'entity_id'),
            $rmaTable, 'order_id', $orderTable, 'entity_id'
        );
        $connection->addForeignKey(
            $installer->getFkName($rmaTable, 'store_id', $storeTable, 'store_id'),
            $rmaTable, 'store_id', $storeTable, 'store_id'
        );
        $connection->addForeignKey(
            $installer->getFkName($rmaItemTable, 'parent_id', $rmaTable, 'entity_id'),
            $rmaItemTable, 'parent_id', $rmaTable, 'entity_id'
        );
        $connection->addForeignKey(
            $installer->getFkName($rmaCommentTable, 'parent_id', $rmaTable, 'entity_id'),
            $rmaCommentTable, 'parent_id', $rmaTable, 'entity_id'
        );
        $connection->addForeignKey(
            $installer->getFkName($rmaTrackTable, 'parent_id', $rmaTable, 'entity_id'),
            $rmaTrackTable, 'parent_id', $rmaTable, 'entity_id'
        );

        $table = $installer->getConnection()->newTable(
            $rmaGridTable
        )->addColumn(
            'entity_id',
            \Magento\Framework\DB\Ddl\Table::TYPE_INTEGER,
            null,
            ['unsigned' => true, 'nullable' => false, 'primary' => true],
            'Entity Id'
        )->addColumn(
            'increment_id',
            \Magento\Framework\DB\Ddl\Table::TYPE_TEXT,
            50,
            [],
            'Increment Id'
        )->addColumn(
            'store_id',
            \Magento\Framework\DB\Ddl\Table::TYPE_SMALLINT,
            null,
            ['unsigned' => true],
            'Store Id'
        )->addColumn(
            'order_increment_id',
            \Magento\Framework\DB\Ddl\Table::TYPE_TEXT,
            32,
            ['nullable' => false],
            'Order Increment Id'
        )->addColumn(
            'order_id',
            \Magento\Framework\DB\Ddl\Table::TYPE_INTEGER,
            null,
            ['unsigned' => true, 'nullable' => false],
            'Order Id'
        )->addColumn(
            'order_created_at',
            \Magento\Framework\DB\Ddl\Table::TYPE_TIMESTAMP,
            null,
            ['nullable' => false],
            'Order Increment Id'
        )->addColumn(
            'customer_name',
            \Magento\Framework\DB\Ddl\Table::TYPE_TEXT,
            128,
            ['nullable' => false],
            'Customer Name'
        )->addColumn(
            'total_qty',
            \Magento\Framework\DB\Ddl\Table::TYPE_DECIMAL,
            '12,4',
            [],
            'Total Qty'
        )->addColumn(
            'order_status',
            \Magento\Framework\DB\Ddl\Table::TYPE_TEXT,
            32,
            [],
            'Order'
        )->addColumn(
            'billing_address',
            \Magento\Framework\DB\Ddl\Table::TYPE_TEXT,
            255,
            [],
            'Billing Address'
        )->addColumn(
            'shipping_address',
            \Magento\Framework\DB\Ddl\Table::TYPE_TEXT,
            255,
            [],
            'Shipping Address'
        )->addColumn(
            'billing_name',
            \Magento\Framework\DB\Ddl\Table::TYPE_TEXT,
            128,
            [],
            'Billing Name'
        )->addColumn(
            'shipping_name',
            \Magento\Framework\DB\Ddl\Table::TYPE_TEXT,
            128,
            [],
            'Shipping Name'
        )->addColumn(
            'customer_email',
            \Magento\Framework\DB\Ddl\Table::TYPE_TEXT,
            128,
            [],
            'Customer Email'
        )->addColumn(
            'customer_group_id',
            \Magento\Framework\DB\Ddl\Table::TYPE_SMALLINT,
            null,
            [],
            'Customer Group Id'
        )->addColumn(
            'payment_method',
            \Magento\Framework\DB\Ddl\Table::TYPE_TEXT,
            32,
            [],
            'Payment Method'
        )->addColumn(
            'shipping_information',
            \Magento\Framework\DB\Ddl\Table::TYPE_TEXT,
            255,
            [],
            'Shipping Method Name'
        )->addColumn(
            'created_at',
            \Magento\Framework\DB\Ddl\Table::TYPE_TIMESTAMP,
            null,
            [],
            'Created At'
        )->addColumn(
            'updated_at',
            \Magento\Framework\DB\Ddl\Table::TYPE_TIMESTAMP,
            null,
            [],
            'Updated At'
        )->addIndex(
            $installer->getIdxName(
                $rmaGridTable,
                [
                    'increment_id',
                    'store_id'
                ],
                \Magento\Framework\DB\Adapter\AdapterInterface::INDEX_TYPE_UNIQUE
            ),
            ['increment_id', 'store_id'],
            ['type' => \Magento\Framework\DB\Adapter\AdapterInterface::INDEX_TYPE_UNIQUE]
        )->addIndex(
            $installer->getIdxName(
                $rmaGridTable,
                ['store_id']
            ),
            ['store_id']
        )->addIndex(
            $installer->getIdxName(
                $rmaGridTable,
                ['total_qty']
            ),
            ['total_qty']
        )->addIndex(
            $installer->getIdxName(
                $rmaGridTable,
                ['order_increment_id']
            ),
            ['order_increment_id']
        )->addIndex(
            $installer->getIdxName(
                $rmaGridTable,
                ['order_status']
            ),
            ['order_status']
        )->addIndex(
            $installer->getIdxName($rmaGridTable, ['created_at']),
            ['created_at']
        )->addIndex(
            $installer->getIdxName($rmaGridTable, ['updated_at']),
            ['updated_at']
        )->addIndex(
            $installer->getIdxName($rmaGridTable, ['order_created_at']),
            ['order_created_at']
        )->addIndex(
            $installer->getIdxName($rmaGridTable, ['shipping_name']),
            ['shipping_name']
        )->addIndex(
            $installer->getIdxName($rmaGridTable, ['billing_name']),
            ['billing_name']
        )->addIndex(
            $installer->getIdxName(
                $rmaGridTable,
                [
                    'increment_id',
                    'order_increment_id',
                    'shipping_name',
                    'customer_name',
                    'customer_email',
                    'billing_address',
                    'shipping_address'
                ],
                \Magento\Framework\DB\Adapter\AdapterInterface::INDEX_TYPE_FULLTEXT
            ),
            [
                'increment_id',
                'order_increment_id',
                'shipping_name',
                'customer_name',
                'customer_email',
                'billing_address',
                'shipping_address'
            ],
            ['type' => \Magento\Framework\DB\Adapter\AdapterInterface::INDEX_TYPE_FULLTEXT]
        )->setComment(
            'urma RMA Grid'
        );
        $installer->getConnection()->createTable($table);

        $connection->addForeignKey(
            $installer->getFkName($rmaGridTable, 'entity_id', $rmaTable, 'entity_id'),
            $rmaGridTable, 'entity_id', $rmaTable, 'entity_id'
        );
        $connection->addForeignKey(
            $installer->getFkName($rmaGridTable, 'store_id', $storeTable, 'store_id'),
            $rmaGridTable, 'store_id', $storeTable, 'store_id'
        );

    }
}