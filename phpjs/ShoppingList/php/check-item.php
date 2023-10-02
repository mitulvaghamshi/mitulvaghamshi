<?php
/* This script will done or undone the list item */
require("connect.php"); // import database connection object

/* get and validate item id */
$id = filter_input(INPUT_GET, "id", FILTER_VALIDATE_INT);
/* get and validate current state of an item */
$done = filter_input(INPUT_GET, "done", FILTER_VALIDATE_INT);

/* check it paramenters contain required value */
if ($id !== null && $id !== false && $done !== null && $done !== false) {
    $done = $done === 1 ? 0 : 1; // toggle current state value
    /* create and prepare update query */
    $sql = "UPDATE shopinglist SET isdone = :isdone WHERE id = :id";
    $stmt = $dbh->prepare($sql);
    /* bind value of query perameters */
    $stmt->bindValue(":id", $id);
    $stmt->bindValue(":isdone", $done);
    /* execute update query */
    $result = $stmt->execute();
}
?>
