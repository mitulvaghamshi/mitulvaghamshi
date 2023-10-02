<?php
/**
 * This class is used to create a single task object
 * that can hold a task description and a task due time
 */
class Task
{
    /* This variable used to store task due-time */
    private $time;

    /* This variable used to store task content - description */
    private $desc;

    /**
     * This public constructor will initialize a task object with given parameters
     *
     * @param {Time} time - task due time
     * @param {String} desc - task description
     */
    public function __construct($time, $desc)
    {
        $this->time = $time;
        $this->desc = $desc;
    }

    /**
     * This method used to retrieve due time of a task
     *
     * @return {String} time - task due time
     */
    public function get_time(): string
    {
        return $this->time;
    }

    /**
     * This method used to retrieve task description
     *
     * @return {String} desc - task description
     */
    public function get_desc(): string
    {
        return $this->desc;
    }
}
