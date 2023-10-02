import java.io.File
import java.io.FileNotFoundException
import java.util.Scanner

/**
 * A program that will attempt to optimize the time it takes to process
 * customers in check-out lines inside a grocery store using a queue bases data
 * structure.
 *
 * The general idea is to always place customers in the best checkout line
 * possible.
 *
 * This will be based on the total number of customers and the number of items
 * in each cart being processed.
 */
class Main {
    private var numberOfExpressLines = 0
    private var numberOfRegularLines = 0
    private var expressItemLimit = 0
    private var numberOfCustomer = 0
    private var timeToEmptyStore = 0

    // Store all the checkout lines, and it's required service time
    private lateinit var checkoutLines: Array<CheckoutLine<Customer>>

    /**
     * Read customer and cart information for each customer
     * and initialize required checkout lines.
     *
     * Calculate the optimal time required to serve a customer,
     * and place new customer to the check-out line with the cumulative least
     * amount of time in front of it (the shortest line).
     */
    fun readData(path: String) {
        try {
            Scanner(File(path)).use { input ->
                if (input.hasNextLine()) {
                    numberOfExpressLines = input.nextInt()
                    numberOfRegularLines = input.nextInt()
                    expressItemLimit = input.nextInt()
                    numberOfCustomer = input.nextInt()
                    // Create checkout lines for express and Regular checkout.
                    checkoutLines = Array(totalLines) { CheckoutLine() }
                }
                // Find a checkout line with minimum waiting time and add new customer to that
                // line.
                var i = 0
                while (i < numberOfCustomer && input.hasNextInt()) {
                    val customer = Customer(i + 1, input.nextInt())

                    // If number of items is less than or equal to express limit,
                    // allow customer to enter express line, otherwise check for Regular ines.
                    var lineToServe =
                        if (customer.numberOfItem > expressItemLimit) numberOfExpressLines else 0
                    var minServeTime = checkoutLines[lineToServe].currentWaitTime
                    for (j in lineToServe + 1 until totalLines) {
                        val time = checkoutLines[j].currentWaitTime
                        if (time < minServeTime) {
                            minServeTime = time
                            lineToServe = j
                        }
                    }
                    checkoutLines[lineToServe].queue.enqueue(customer)
                    checkoutLines[lineToServe].addWaitTime(customer.timeToServe())
                    i++
                }
            }
        } catch (e: FileNotFoundException) {
            System.err.println("File does not exist.")
        } catch (e: Exception) {
            e.printStackTrace()
        }
    }

    /**
     * PartA: Output optimum starting case for all the check-out lines in the store
     * and calculate the amount of time it will take for
     * the store to be empty of all customers.
     */
    fun partA() {
        timeToEmptyStore = 0
        for (i in 0 until totalLines) {
            val line = checkoutLines[i]
            if (line.currentWaitTime > timeToEmptyStore) {
                timeToEmptyStore = line.currentWaitTime
            }
            System.out.printf(
                "Checkout[%-7s #%d (Est Time: %3d s)]: %s\n",
                if (i < numberOfExpressLines) "Express" else "Regular",
                i + 1,
                line.currentWaitTime,
                line
            )
        }
        println("Time to clear store of all customers: $timeToEmptyStore s\n")
    }

    /**
     * PartB: Simulate the removal of customers from each check-out by servicing the
     * customers.
     * It will calculate the state of the Checkout lines after each second,
     * and display state of lines every 30 seconds (simulated).
     *
     * Once the amount of time has passed required to service the customer,
     * the customer is removed at the start of the Queue.
     */
    fun partB() {
        print("Time(s) ")
        repeat(totalLines) {
            print(String.format("%-8s", "Line ${it + 1}"))
        }
        repeat(timeToEmptyStore) { i ->
            val queueState = queueStateAtTime(i)
            if (i > 0 && i % 30 == 0) {
                print(queueState)
            }
        }
        // Check for any leftover customer from the simulation.
        if (timeToEmptyStore % 30 != 0) {
            println(queueStateAtTime(timeToEmptyStore))
        }
    }

    /**
     * This method used to check the state of all the checkout lines at particular
     * time.
     * Iterate over all the checkout lines and generate a string report for given
     * time.
     *
     * It is also check if and remove any customer from the checkout queue if it's
     * done processing all the items (run out of time...)
     *
     * @param time when all checkout lines were analyzed.
     * @return a string representation of state of all checkout lines.
     */
    private fun queueStateAtTime(time: Int): String {
        val sb = StringBuilder(String.format("\n%3d", time))
        for (line in checkoutLines) {
            if (!line.queue.isEmpty && line.queue.peek().isDone()) {
                line.queue.dequeue()
            }
            sb.append(String.format("%8d", line.queue.size()))
        }
        return sb.toString()
    }

    /**
     * Calculate the total number of checkout lines.
     *
     * @return total number of checkout line.
     */
    private val totalLines: Int
        get() = numberOfExpressLines + numberOfRegularLines
}

/**
 * Program entry point.
 */
fun main() = with(Main()) {
    readData(path = "data.txt")
    partA()
    partB()
}
