/**
 * This class represents a customer at the checkout line.
 *
 * It holds number of items in the cart for the customer,
 * and a unique id to identify the location of the customer.
 *
 * Initialize a customer instance with given properties,
 * and calculate the time required to serve the customer.
 *
 * @param id a unique customer id
 * @param cartSize the number of items in the cart
 */
class Customer(private val id: Int, val cartSize: Int) {
    /**
     * Time required to serve the customer.
     *
     * @return time to serve in seconds.
     */
    var timeToServe = 45 + 5 * cartSize; private set

    /**
     * Check if the customer is finished processing all the items in the cart.
     * On every call, it will reduce 1 second from total time
     * and check if the customer used all it's time.
     *
     * @return if the customer has done processing all the cart items.
     */
    val isDone get() = --timeToServe == 0

    /**
     * Display customer id, number of items and time required to serve.
     *
     * @return String return customer info.
     */
    override fun toString() = String.format(
        "[Customer%3d: Item:%3d, Time:%4ds]", id, cartSize, timeToServe
    )
}
