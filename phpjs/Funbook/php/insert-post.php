<?php session_start();
/* insert new post (image, thoughts) to the database */

/* database hander instance */
$dbh = require "connection/getPDO.php";

/* retrieve post parameters */
$type = filter_input(INPUT_POST, "type", FILTER_VALIDATE_INT);
$data = filter_input(INPUT_POST, "data", FILTER_SANITIZE_SPECIAL_CHARS);

/* validate parameters */
if ($type !== false && $type !== null && $data !== "" && $data !== null) {
    /* check user session */
    if (isset($_SESSION['xUser'])) {
        $now = time();
        /* clear data on session timeout */
        if ($now > $_SESSION['expire']) {
            session_destroy();
        } else {
            $_SESSION['expire'] = time() + (10 * 60); // set 10 minutes session timeout
            $sql = "INSERT INTO `userdata` (`userId`, `id`, `type`, `data`, `likes`, `dislikes`) VALUES (:pUser, null, :pType, :pData, :pLike, :pDislike)";
            $stmt = $dbh->prepare($sql);
            $stmt->bindValue(":pUser", $_SESSION['xUser']);
            $stmt->bindValue(":pType", $type);
            $stmt->bindValue(":pData", $data);
            $stmt->bindValue(":pLike", 0);
            $stmt->bindValue(":pDislike", 0);
            $result = $stmt->execute();
        }
    }
}
?>
