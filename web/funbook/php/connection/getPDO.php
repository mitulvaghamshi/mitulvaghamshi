<?php
require 'connect.php';
$env = require 'env.php';
return Connection::make($env['dev']);
?>
