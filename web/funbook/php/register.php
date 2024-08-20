<?php
/* register new user */

/* database handler instance */
$dbh = require "connection/getPDO.php";

/* retrieve registrantion parameters */
$username = filter_input(INPUT_POST, "reg-username", FILTER_SANITIZE_SPECIAL_CHARS);
$email = filter_input(INPUT_POST, "reg-email", FILTER_VALIDATE_EMAIL);
$password = filter_input(INPUT_POST, "reg-password", FILTER_SANITIZE_SPECIAL_CHARS);
$dob = filter_input(INPUT_POST, "reg-dob", FILTER_SANITIZE_SPECIAL_CHARS);
$gender = filter_input(INPUT_POST, "reg-gender", FILTER_VALIDATE_INT);

/* validate parameters */
if (
    $username !== null && $username !== "" &&
    $password !== null && $password !== "" &&
    $email !== null && $email !== "" &&
    $dob !== null && $dob !== false &&
    $gender !== null && $gender !== false
) {
    /* insert new record */
    $sql = "INSERT INTO user (`username`, `email`, `password`, `dob`, `gender`) VALUES (:pUser, :pEmail, :pPass, :pDob, :pGender)";
    $stmt = $dbh->prepare($sql);
    $stmt->bindValue(":pUser", $username);
    $stmt->bindValue(":pEmail", $email);
    $stmt->bindValue(":pPass", password_hash($password, PASSWORD_DEFAULT));
    $stmt->bindValue(":pDob", $dob);
    $stmt->bindValue(":pGender", $gender);
    $result = $stmt->execute();

    /* check if user susscessfully registerd */
    if ($result) {
        echo json_encode(0); // return success code
    } else {
        echo json_encode(-1); // return error code
    }
}
?>
