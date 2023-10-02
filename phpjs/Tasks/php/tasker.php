<!DOCTYPE html>

<html lang="en-US">
<!-- This script will accept, proccess and display the values submited by the user from index.php -->
<?php

/* return to homepage, if request is made from other source */
if (!isset($_POST["submit"])) header("Location: ../index.php");

/* set timezone to America/Toronto, GMT -04:00 */
date_default_timezone_set("America/Toronto");

/* import task class */
require('task.class.php');

/* date input is already validated by tnput type = date and required attribute */
$date = filter_input(INPUT_POST, 'date');

/* create an empty array to store user tasks */
$tasks = array();

/* get and validate all(five) user inputs and store it into tasks array */
for ($i = 1; $i <= 5; $i++) {
    $time = filter_input(INPUT_POST, "time$i");
    $desc = filter_input(INPUT_POST, "task$i", FILTER_SANITIZE_STRING);
    if ($time and $desc) array_push($tasks, new Task($time, $desc));
}
?>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="style.css">
    <title>Multi Notes</title>
</head>

<!-- display formated output to the user of all day tasks -->
<body>
    <!-- appbar with icon and title -->
    <div class="app-bar">
        <h1 class="title">Multi Notes</h1>
    </div>

    <!-- background graphics -->
    <!-- <img class="background" src="task.png" alt="background image 1"> -->
    <!-- <img class="background foreground" src="fg.svg" alt="background image 2"> -->

    <!-- body content -->
    <div class="main-content">
        <!-- task list -->
        <ul class="task-list">
            <!-- list header with date -->
            <li class="list-item list-header">
                <label class="list-thumb">Start here</label>
                <label class="task-due"><?= $date ?></label>
                <label class="list-heading">Tasks to be done today</label>
            </li>
            <br>

            <!-- generate list item for ever hour (24 hours) of the day -->
            <?php for ($i = 0; $i < 24; $i++) {
                /* store value of hour in 24 hour format, 06:00 am */
                $hour = date("H:i a", mktime($i, 00));
                $time = ""; /* task due time */
                $desc = ""; /* task description */
                $color = ""; /* list item color to highlight available tasks from the list */

                /* display task if available during perticular hour, or make an empty list item */
                foreach ($tasks as $task) {
                    /* check if task hour value matches with any hour of the day */
                    if ((int) substr($task->get_time(), 0, 2) == $i) {
                        $color = "color";
                        $time = 'Due: ' . $task->get_time();
                        $desc = $task->get_desc();
                    }
                } ?>

                <!-- display all the list item -->
                <li <?= "class='list-item $color'" ?>>
                    <label class="list-thumb"><?= $hour ?></label>
                    <label class="list-desc"><?= $desc ?></label>
                    <label class="task-due"><?= $time ?></label>
                </li>
            <?php } ?>
        </ul>
    </div>
</body>

</html>
