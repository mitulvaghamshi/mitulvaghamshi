class LinkedQueue<E> {
    /**
     * Node class to be used by the LinkedQueue class
     *
     * @param <E>
    </E> */
    private class Node<E>(var value: E, var next: Node<E>?)

    private var count: Int
    private var front: Node<E>? = null
    private var rear: Node<E>? = null

    /**
     * Constructor for a LinkedQueue
     */
    init {
        front = rear
        count = 0
    }

    /**
     * Add an item to the Queue
     *
     * @param value item to be added to the Queue
     */
    fun enqueue(value: E) {
        if (rear != null) {
            rear!!.next = Node(value, null)
            rear = rear!!.next
        } else {
            rear = Node(value, null)
            front = rear
        }
        count++
    }

    /**
     * Remove an item from the Queue - throws exception if queue is empty
     *
     * @return the item at the from of the Queue
     */
    fun dequeue(): E {
        check(!isEmpty) { "Cannot dequeue - Queue is empty" }
        val value = front!!.value
        front = front!!.next
        count--
        if (front == null) {
            rear = null
        }
        return value
    }

    /**
     * Check is queue is empty
     *
     * @return true if empty, false if not
     */
    /**
     * Check is queue is empty
     *
     * @return true if empty, false if not
     */
    val isEmpty: Boolean = front == null

    /**
     * Shows front of Queue
     *
     * @return the value of the first item in the Queue
     */
    fun peek(): E = front!!.value

    /**
     * Obtain the number of elements in the Queue
     *
     * @return int
     */
    fun size(): Int = count

    /**
     * ToString method used to print each of the strings of the objects
     *
     * @return string representing the class
     */
    override fun toString(): String {
        val result = StringBuilder("[")
        var current = front
        while (current != null) {
            result.append("\n\t").append(current.value)
            if (current.next != null) {
                result.append(", ")
            }
            current = current.next
        }
        result.append("]\n")
        return result.toString()
    }
}
