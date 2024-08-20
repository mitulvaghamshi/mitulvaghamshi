import java.io.File
import java.io.FileNotFoundException
import java.util.*

/**
 * Implement check-out lines in a grocery store using a queue data-structure.
 *
 * Try to place customer in the best checkout line possible based on the total
 * number of customers and the number of items in each cart being processed.
 */
class FakeMart {
    private var expressLines = 0
    private var regularLines = 0
    private var expressItemLimit = 0
    private var numberOfCustomer = 0
    private var timeToEmptyStore = 0

    // Total number of checkout lines including regular and express.
    private val totalLines get() = expressLines + regularLines

    // Store all the checkout lines, and it's required service time
    private lateinit var checkoutLines: Array<CheckoutLine<Customer>>

    /**
     * Read customer and cart information for each customer from data file
     * and initialize required checkout lines.
     *
     * Calculate the optimal time required to serve a customer,
     * and place new customer to the check-out line with the cumulative
     * least amount of time in front of it (the shortest line).
     */
    fun readData(path: String) {
        try {
            Scanner(File(path)).use { input ->
                if (input.hasNextLine()) {
                    expressLines = input.nextInt()
                    regularLines = input.nextInt()
                    expressItemLimit = input.nextInt()
                    numberOfCustomer = input.nextInt()
                    // Create checkout lines for express and Regular checkout.
                    checkoutLines = Array(totalLines) { CheckoutLine() }
                }

                // Find a checkout line with minimum waiting time
                // and add new customer to that line.
                var i = 0
                while (i < numberOfCustomer && input.hasNextInt()) {
                    val customer = Customer(id = i + 1, cartSize = input.nextInt())
                    // If number of items is less than or equal to express limit,
                    // allow customer to enter express line, otherwise check for Regular line.
                    var line = if (customer.cartSize > expressItemLimit) expressLines else 0
                    var minServeTime = checkoutLines[line].waitTime
                    (line + 1..<totalLines).forEach { j ->
                        val time = checkoutLines[j].waitTime
                        if (time < minServeTime) {
                            minServeTime = time
                            line = j
                        }
                    }
                    checkoutLines[line].queue.add(customer)
                    checkoutLines[line].addWaitTime(customer.timeToServe)
                    i++
                }
            }
        } catch (e: FileNotFoundException) {
            println("[ERROR]: File does not exist.")
        } catch (e: Exception) {
            e.printStackTrace()
        }
    }

    /**
     * Optimum starting case for all the check-out lines in the store
     * and calculate the amount of time it will take for
     * the store to be empty of all customers.
     */
    fun partA() {
        timeToEmptyStore = 0
        repeat(totalLines) { i ->
            val line = checkoutLines[i]
            if (line.waitTime > timeToEmptyStore)
                timeToEmptyStore = line.waitTime
            System.out.printf(
                "Checkout [%-7s #%d (Estimated time: %3d s)]: %s\n",
                if (i < expressLines) "Express" else "Regular",
                i + 1, line.waitTime, line
            )
        }
        println("Time to clear store of all customers: $timeToEmptyStore s\n")
    }

    /**
     * Remove customers from each check-out by servicing the customers.
     * It will calculate the state of the checkout lines after every second,
     * and display state of lines every 30 seconds (simulated).
     *
     * Once the amount of time has passed required to serve the customer,
     * the customer is removed at the start of the Queue.
     */
    fun partB() {
        print("Time(s) ")
        repeat(totalLines) { System.out.printf("%-8s", "Line ${it + 1}") }
        repeat(timeToEmptyStore) { tick ->
            val status = queueStatus(tick)
            if (tick > 0 && tick % 30 == 0) print(status)
        }
        // Check for any leftover customer.
        if (timeToEmptyStore % 30 != 0) println(queueStatus(timeToEmptyStore))
    }

    /**
     * Check the state of all the checkout lines at particular time.
     * Lookup all the checkout lines and generate a report for given time.
     * Check and remove any customer from the queue if it's
     * done processing all the items (or, run out of time...).
     *
     * @param time when all checkout lines were analyzed.
     * @return String state report of all checkout lines.
     */
    private fun queueStatus(time: Int) = buildString {
        append(String.format("\n%3d", time))
        checkoutLines.forEach { line ->
            if (!line.queue.isEmpty && line.queue.peek.isDone) {
                line.queue.remove()
            }
            append(String.format("%8d", line.queue.size))
        }
    }
}

fun main() {
    val app = FakeMart()
    app.readData(path = "data/data.txt")
    app.partA()
    app.partB()
}
