<?php

require_once 'vendor/autoload.php';

use Doctrine\DBAL\DriverManager;
use Doctrine\Migrations\Configuration\Connection\ExistingConnection;
use Doctrine\Migrations\Configuration\Migration\PhpFile;
use Doctrine\Migrations\DependencyFactory;

/**
 * Database params
 */
$db = require 'app/env.php';
$db = (object) $db['db'];

$connection = DriverManager::getConnection([
    'dbname' => $db->dbname,
    'user' => $db->username,
    'password' => $db->password,
    'host' => $db->host,
    'charset' => $db->charset,
    'driver' => 'pdo_mysql',
]);

return DependencyFactory::fromConnection(new PhpFile(__DIR__ . '/migrations.php'), new ExistingConnection($connection));
