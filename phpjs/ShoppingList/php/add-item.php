<?php
/* This script will validate and add new list item to the database */
require("connect.php"); // import database connection object

/* get and validate item name */
$item = filter_input(INPUT_GET, "item", FILTER_SANITIZE_SPECIAL_CHARS);
/* get and validate item quantity */
$quantity = filter_input(INPUT_GET, "quantity", FILTER_VALIDATE_INT);

/* check if required information is provided by the user */
if ($item !== null && $item !== "" && $quantity !== null && $quantity !== false && $quantity > 0) {
    /* create and prepare insert statement */
    $sql = "INSERT INTO shopinglist (id, item, quantity, isdone) VALUES (null, :item, :quantity, 0)";
    $stmt = $dbh->prepare($sql);
    /* bind values of query parameters */
    $stmt->bindValue(":item", $item);
    $stmt->bindValue(":quantity", $quantity);
    /* execute insert query */
    $result = $stmt->execute();
}
?>
