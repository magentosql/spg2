<?php
return array (
  'backend' => 
  array (
    'frontName' => 'spgadmin',
  ),
  'db' =>

  array (
    'connection' => 
    array (
      'indexer' => 
      array (
        'host' => 'localhost',
        'dbname' => 'spg2ee_db',
        'username' => 'root',
        'password' => '123',
        'active' => '1',
        'persistent' => NULL,
      ),
      'default' => 
      array (
        'host' => 'localhost',
        'dbname' => 'spg2ee_db',
        'username' => 'root',
        'password' => '123',
        'active' => '1',
      ),
    ),
    'table_prefix' => 'spg_',
  ),
  'crypt' => 
  array (
    'key' => '09b7fc1f80dcdcac0856ed6a662fce30',
  ),
  'session' => 
  array (
    'save' => 'files',
  ),
  'resource' => 
  array (
    'default_setup' => 
    array (
      'connection' => 'default',
    ),
  ),
  'x-frame-options' => 'SAMEORIGIN',
  'MAGE_MODE' => 'developer',
  'cache_types' => 
  array (
    'config' => 1,
    'layout' => 1,
    'block_html' => 1,
    'collections' => 1,
    'reflection' => 1,
    'db_ddl' => 1,
    'eav' => 1,
    'customer_notification' => 1,
    'target_rule' => 1,
    'full_page' => 0,
    'config_integration' => 1,
    'config_integration_api' => 1,
    'translate' => 1,
    'config_webservice' => 1,
  ),
  'install' => 
  array (
    'date' => 'Fri, 03 Feb 2017 07:50:37 +0000',
  ),
);
