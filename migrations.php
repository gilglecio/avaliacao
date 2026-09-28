<?php

return [
    'table_storage' => [
        'table_name' => 'migrations',
    ],
    'migrations_paths' => [
        'DoctrineMigrations' => __DIR__ . '/app/migrations',
    ],
    // O MySQL faz commit implícito em DDL; migrações transacionais falham no PHP 8.
    'transactional' => false,
    'all_or_nothing' => false,
];
