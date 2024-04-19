/**
 * This class represents a single checkout line and provides a
 * method to track the time required to finish all the customers on this line.
 *
 * @param <T> type of the element utilizing this generic class.
 */
class CheckoutLine<T> {
    /**
     * Get the current checkout queue.
     *
     * @return current checkout queue.
     */
    val queue: LinkedQueue<T> = LinkedQueue()

    /**
     * Provides the current wait time required by the queue.
     * The current wait time (in seconds) is the total time to serve all the
     * customer within this queue.
     *
     * @return time to serve all the customer.
     */
    var currentWaitTime: Int; private set

    /**
     * Initialize new checkout line with and the
     * time tracker to track total serve time
     */
    init {
        currentWaitTime = 0
    }

    /**
     * Increase the current wait time of this queue by the time required by the
     * newly enqueued customer.
     *
     * @param timeToServe the time required to serve the enqueued customer.
     */
    fun addWaitTime(timeToServe: Int) {
        currentWaitTime += timeToServe
    }

    /**
     * ToString method used to print each of the strings of the checkout queue.
     *
     * @return string representing the current queue.
     */
    override fun toString(): String = queue.toString()
}
