<?php session_start();
/* Logout and clear user session  */
session_destroy();
echo json_encode(0);
?>
