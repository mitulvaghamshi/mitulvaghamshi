<?php session_start();
/* initiate user login */

/* databse access instance */
$dbh = require "connection/getPDO.php";

/* retrieve login parameters */
$username = filter_input(INPUT_POST, "log-username", FILTER_SANITIZE_SPECIAL_CHARS);
$password = filter_input(INPUT_POST, "log-password", FILTER_SANITIZE_SPECIAL_CHARS);

/* validate parameters */
if ($username !== null && $username !== "" && $password !== null && $password !== "") {
    $sql = "SELECT `username`, `password` FROM `user` WHERE `username` = :pUser";
    $stmt = $dbh->prepare($sql);
    $stmt->bindValue(":pUser", $username);
    $result = $stmt->execute();

    /* if user entry available */
    if ($result && $stmt->rowCount() === 1) {
        $uData = $stmt->fetch();
         /* varify hashed password from database */
        if (password_verify($password, $uData["password"])) {
            $_SESSION["xUser"] = $uData["username"]; // add current user to the database
            $_SESSION['expire'] = time() + (10 * 60); // assign 10 minutes session
            echo json_encode(0); // return success code
        } else {
            session_unset();
            session_destroy();
            echo json_encode(-1);
        }
    } else {
        session_unset();
        session_destroy();
        echo json_encode(-1);
    }
}
?>
