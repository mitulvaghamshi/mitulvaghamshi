<?php
/*
 * This will creates a connection to the database
 * the connection made to the database using given host, db and credentials
 * throws an exception on failure
 */
try {
   // $dbh = new PDO("mysql:host=localhost;dbname=db-name","db-name","db-password"); // server
   $dbh = new PDO("mysql:host=localhost;dbname=xdb","root",""); // localhost
} catch(Exception $e) {
   die("ERROR: Could not connect. {$e->getMessage()}");
}
?>
