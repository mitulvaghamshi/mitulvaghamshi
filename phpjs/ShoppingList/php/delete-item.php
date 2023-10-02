<?php
/* This script will delete perticuler item from the database */
require("connect.php"); // import database connection object

/* get and validate item id */
$id = filter_input(INPUT_GET, "id", FILTER_VALIDATE_INT);

/* check if id value is provided */
if ($id !== null && $id !== false) {
    /* create and prepare delete quary */
    $sql = "DELETE FROM shopinglist WHERE id = :id";
    $stmt = $dbh->prepare($sql);
    /* bind value of query parameters */
    $stmt->bindValue(":id", $id);
    /* execute delete query */
    $result = $stmt->execute();
}
?>
