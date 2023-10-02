<?php

/* Create a database connection */
class Connection
{
    /* static method to establish connection */
    public static function make($env)
    {
        try {
            return new PDO($env['host'] . $env['db'], $env['user'], $env['pass']);
        } catch (PDOException $e) {
            die("ERROR: Could not connect. $e->getMessage()");
        }
    }
}
?>
