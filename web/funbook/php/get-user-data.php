<?php session_start();
/* retrieve all user data (image and thought) on login */

/* databse handler  instance */
$dbh = require "connection/getPDO.php";

/* check user session */
if (isset($_SESSION['xUser'])) {
    $now = time();
    /* clear data if session timed out */
    if ($now > $_SESSION['expire']) {
        session_destroy();
    } else {
        $_SESSION['expire'] = time() + (10 * 60); // create session of 10 minutes from now
        $sql = "SELECT `id`, `type`, `data`, `likes`, `dislikes` FROM userdata WHERE userID = :pUser ORDER BY `id`";
        $stmt = $dbh->prepare($sql);
        $stmt->bindValue(":pUser", $_SESSION['xUser']);
        $result = $stmt->execute();
        /* return data if available, error code otherwise */
        if ($result && $stmt->rowCount() > 0) {
            echo json_encode($stmt->fetchAll());
        } else echo json_encode(-1);
    }
}
?>
