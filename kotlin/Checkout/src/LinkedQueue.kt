class LinkedQueue<E>(private var count: Int = 0) {
    private data class Node<E>(var value: E, var next: Node<E>? = null)

    private var front: Node<E>? = null
    private var rear: Node<E>? = null

    /**
     * Add an item to the Queue.
     *
     * @param value item to be added to the Queue.
     */
    fun add(value: E) {
        if (rear == null) {
            rear = Node(value)
            front = rear
        } else {
            rear!!.next = Node(value)
            rear = rear!!.next
        }
        count++
    }

    /**
     * Remove an item from the Queue.
     *
     * @throws Exception if queue is empty.
     * @return E the item at the front of the Queue.
     */
    fun remove(): E {
        check(!isEmpty) { "Cannot dequeue - Queue is empty" }

        val value = front!!.value
        front = front!!.next
        if (front == null) rear = null
        count--

        return value
    }

    /**
     * Check is queue is empty.
     *
     * @return Boolean true if empty, false otherwise.
     */
    val isEmpty get() = front == null

    /**
     * Lookup front of the Queue without removing it.
     *
     * @return E the value of the first item in the Queue.
     */
    val peek get() = front!!.value

    /**
     * Get number of elements in the Queue.
     *
     * @return int number of elements in queue.
     */
    val size get() = count

    /**
     * Dump queue data as formated string.
     *
     * @return string representation of the queue.
     */
    override fun toString() = buildString {
        var current = front
        append("[")
        while (current != null) {
            append("\n\t")
            append(current.value)
            current = current.next
        }
        append("\n]\n")
    }
}
