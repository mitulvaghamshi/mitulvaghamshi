<?php
return [
    'dev' => [
        'pass' => '',
        'user' => 'root',
        'db' => 'dbname=xdb;',
        'host' => 'mysql:host=localhost;'
    ],
    'prod' => [
        'pass' => 'root',
        'user' => 'root',
        'db' => 'dbname=mydb;',
        'host' => 'mysql:host=endpoint;'
    ]
];
?>
