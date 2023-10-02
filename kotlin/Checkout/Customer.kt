/**
 * This class represents a customer at the checkout line.
 * It holds number of items in the cart for the customer,
 * and, a unique id to identify the location of the customer.
 *
 * Initialize a customer instance with given properties.
 * It also calculates the time required to serve the customer.
 *
 * @param id   a unique customer id
 * @param numberOfItem the number of items in the cart
 */
class Customer(private val id: Int, val numberOfItem: Int) {
    private var timeToServe: Int = 45 + 5 * numberOfItem

    /**
     * This method provides the time required to serve by the customer.
     *
     * @return time to serve in seconds.
     */
    fun timeToServe(): Int = timeToServe

    /**
     * This method check if the customer is finished processing all the items in the
     * cart
     * On every call to this method, it will reduce 1 second from total time
     * required by the customer,
     * and check if the customer used oll it's time.
     *
     * @return if the customer has done processing all the cart items.
     */
    fun isDone(): Boolean = --timeToServe == 0

    /**
     * Returns a string representation of the customer.
     * In general, it displays customer id, number of items in the cart and time
     * required to serve.
     *
     * @return a string representation of the customer.
     */
    override fun toString(): String = String.format(
        "[Customer%2d: Item:%3d, Time:%4d s]", id, numberOfItem, timeToServe()
    )
}
