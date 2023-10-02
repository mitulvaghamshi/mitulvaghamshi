<?php
/**
 * This script will retrieve all the items from the database
 * and output all records in json format
 */
require("connect.php"); // import database connection object

/* create and prepare select query */
$sql = "SELECT * FROM shopinglist ORDER BY isdone, item";
$stmt = $dbh->prepare($sql);
/* execute select query */
$result = $stmt->execute();

/* return json encoded string if query successful and at least one item is available */
if ($result && $stmt->rowCount() > 0) echo json_encode($stmt->fetchAll());
else echo "999"; // return error code, used by javascript to determine
?>
