<?php
/* This script will edit an item in database */
require("connect.php"); // import database connection object

/* get and validate item id */
$id = filter_input(INPUT_GET, "id", FILTER_VALIDATE_INT);
/* get and validate new quantity */
$quantity = filter_input(INPUT_GET, "quantity", FILTER_VALIDATE_INT);
/* get and validate new item name */
$item = $item = filter_input(INPUT_GET, "item", FILTER_SANITIZE_SPECIAL_CHARS);

/* check if required values are provided */
if ($id !== null && $id !== false && $item !== null && $item !== "" && $quantity !== null && $quantity !== false && $quantity > 0) {
    /* create and prepare update query */
    $sql = "UPDATE shopinglist SET item = :item, quantity = :quantity, isdone = 0 WHERE id = :id";
    $stmt = $dbh->prepare($sql);
    /* bind value of query parameters */
    $stmt->bindValue(":id", $id);
    $stmt->bindValue(":item", $item);
    $stmt->bindValue(":quantity", $quantity);
    /* execute update query */
    $result = $stmt->execute();
}
?>
