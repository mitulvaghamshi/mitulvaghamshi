/**
 * Create a checkout line.
 *
 * @param T concrete type for this generic class.
 */
class CheckoutLine<T>(
    val queue: LinkedQueue<T> = LinkedQueue(),
    private var queueWaitTime: Int = 0
) {
    /**
     * Current wait-time required by the queue (in seconds).
     * This is the total time to serve all the customer within this queue.
     *
     * @return Int time to serve all the customer.
     */
    val waitTime get() = queueWaitTime

    /**
     * Increase the current wait-time of this queue by
     * the time required by the newly added customer.
     *
     * @param timeToServe the time required to serve the customer.
     */
    fun addWaitTime(timeToServe: Int) {
        queueWaitTime += timeToServe
    }

    /**
     * Dump queue data as formated string.
     *
     * @return string representation of the queue.
     */
    override fun toString() = queue.toString()
}
