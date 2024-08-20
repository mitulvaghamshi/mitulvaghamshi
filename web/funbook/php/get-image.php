<?php session_start();
/* get post image from database */

/* get databse handler instance */
$dbh = require "connection/getPDO.php";

/* image id */
$id = filter_input(INPUT_POST, "id", FILTER_VALIDATE_INT);

/* validate image id */
if($id !== false && $id !== null) {
    /* check user session */
    if (isset($_SESSION['xUser'])) {
        $now = time(); // get current time
        /* is session timed out */
        if ($now > $_SESSION['expire']) {
            session_destroy(); // clear user data from session
        } else {
            $_SESSION['expire'] = time() + (10 * 60); // set 10 minutes from now for current session
            $sql = "SELECT imageUrl FROM imagelist WHERE id = :pId";
            $stmt = $dbh->prepare($sql);
            $stmt->bindValue(":pId", $id);
            $result = $stmt->execute();
            /* return image url data if available, error code otherwise */
            if ($result && $stmt->rowCount() === 1) {
                echo json_encode($stmt->fetch());
            } else echo json_encode(-1);
        }
    }
}
?>
