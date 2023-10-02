<!DOCTYPE html>
<html lang="en-us">
<!-- A single page input form to get five tasks to done by the user -->
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="./css/style.css">
    <title>Multi Notes</title>
</head>

<body>
    <!-- An app bar with icon and title -->
    <div class="app-bar">
        <h1 class="title">Multi Notes</h1>
    </div>
    <!-- content body with form input elements -->
    <div class="main-content">
        <!-- form submited to {tasker.php} file with {post} method -->
        <form action="tasker.php" method="post">
            <!-- date section -->
            <label class="form-label" for="date">Enter task date: </label>
            <input class="form-input" type="date" name="date" id="date" required />
            <br><br>
            <!-- it creates five input controls for task due and description -->
            <?php for ($i = 1; $i <= 5; $i++) { ?>
                <label class="form-label" <?= "for='task$i'" ?>>Enter Task <?= $i ?>: </label>
                <!-- due control -->
                <div class="form-input1">
                    <label class="form-label" <?= "for='time$i'" ?>>Due: </label>
                    <input class="form-input" type="time" <?= "name='time$i'" ?> <?= "id='time$i'" ?> required />
                </div><br>
                <!-- description control -->
                <input class="form-input" type="text" <?= "name='task$i'" ?> <?= "id='task$i'" ?> required placeholder="Enter task description here..." />
            <?php } ?>
            <br>
            <!-- form submit and clear controls -->
            <div class="form-input">
                <input class="form-button" type="submit" name="submit">
                <input class="form-button" type="reset" value="Clear">
            </div>
        </form>
    </div>
</body>

</html>
