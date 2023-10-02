<?php session_start();
$xValid = false;
$xUser = "Guest";
if (isset($_SESSION['xUser'])) {
    $now = time();
    if ($now > $_SESSION['expire']) {
        session_destroy();
    } else {
        $_SESSION['expire'] = time() + (30 * 60); // 30 min
        $xUser = $_SESSION["xUser"];
        $xValid = true;
    }
}
?>
<!DOCTYPE html>
<html lang="en-us">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="css/home.css">
    <link rel="stylesheet" href="css/index.css">
    <title>FUNBOOK</title>
</head>

<body>
    <!-- app bar -->
    <div class="app-bar">
        <h1 class="title">FUNBOOK
            <input type="button" id="logout" value="Logout">
            <span id="username">Welcome, <?= $xUser ?></span>
        </h1>
    </div>

    <!-- if user is not logged in -->
    <?php if (!$xValid) { ?>
        <div id="login-again-page">
            <h1>Session timed out<br>Please login...</h1>
        </div>
    <?php } else { ?>
        <!-- valid login -->
        <div class="home-content">
            <!-- page header -->
            <div id="header">
                <textarea class="input-field input" id="new-post" placeholder="What's on your mind..."></textarea>
                <div id="new-post-btn">
                    <input type="button" class="btn" id="post-btn" value="POST">
                    <input type="button" class="btn" id="post-img-btn" value="ADD NEW IMAGE">
                </div>
            </div>

            <!-- left menu -->
            <div id="menu">
                <h1>Ad banners</h1>
            </div>

            <!-- main content -->
            <div id="main">
                <ul id="post-list">
                    <div id="post">
                        <img src="./img/fg.svg" id="post-image" alt="placeholder...">
                    </div>
                </ul>
            </div>

            <!-- right panel -->
            <div id="right">
                <h1>Friend list</h1>
            </div>

            <!-- footer -->
            <div id="footer">
                <h1>&copy; All Rights Reserved. 2020</h1>
            </div>
        </div>
    <?php } ?>

    <!-- load jQuery library and other scripts -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="js/home.js"></script>
</body>

</html>
