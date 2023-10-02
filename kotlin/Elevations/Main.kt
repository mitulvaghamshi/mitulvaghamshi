import java.io.File
import java.io.FileNotFoundException
import java.util.Scanner

/**
 * Working with single and multidimensional Arrays.
 *
 * The program contains 4 problems as:
 * 1) Find the lowest elevation value and number of times it occurs in dataset.
 * 2) Find all the local peaks matching given criteria. (!Incomplete).
 * 3) Find the two closest peaks in the dataset.
 * 4) Find the most common elevation and number of times it occurs.
 */
class Main {
    // Specifies the size of the dataset and minimum peak value with exclusion radius.
    private var rows = 0
    private var cols = 0
    private var minPeak = 0
    private var exRadius = 0

    /**
     * Read data from the "data.txt" file.
     *
     * @return two-dimensional integer array with data.
     */
    fun readData(): Array<IntArray>? {
        val file = File("data/data.txt")
        var data: Array<IntArray>? = null
        try {
            Scanner(file).use { input ->
                if (input.hasNextLine()) {
                    rows = input.nextInt() // Number of rows in the dataset.
                    cols = input.nextInt() // Number of columns in the dataset.
                    minPeak = input.nextInt() // Minimum peak value.
                    exRadius = input.nextInt() // The exclusion radius.
                }
                data = Array(rows) { IntArray(cols) } // Create array of size [ROWS] * [COLS].
                repeat(rows) { i ->
                    repeat(cols) { j ->
                        data!![i][j] = input.nextInt()
                    }
                }
            }
        } catch (e: FileNotFoundException) {
            println("File does not exists.")
        } catch (e: Exception) {
            e.printStackTrace()
        }
        return data
    }

    /**
     * Find the lowest elevation and number of time it occurs in the dataset.
     *
     * @param data two-dimensional array to find minimum elevation.
     * @return as integer array containing two elements of minimum elevation and its
     * count.
     */
    fun findLowestElevation(data: Array<IntArray>): IntArray {
        var minElevation = data[0][0]
        var minElevationCount = 0
        repeat(rows) { i ->
            repeat(cols) { j ->
                // If new minimum value found, reset the counter.
                if (data[i][j] < minElevation) {
                    minElevation = data[i][j]
                    minElevationCount = 0
                }
                // if value match the current minimum elevation.
                if (data[i][j] == minElevation) {
                    minElevationCount++
                }
            }
        }
        return intArrayOf(minElevation, minElevationCount)
    }

    /**
     * Find all the local peaks that is grater then or equal to value [minPeak],
     * and that is not contained in the given exclusion radius [exRadius].
     *
     * @param data two-dimensional array containing the data.
     * @return an array of [Peak]s, found in the dataset.
     * [Peak] is a class containing elevation value and its location.
     */
    fun findLocalPeaks(data: Array<IntArray>): Array<Peak?> {
        // A fix sized block in the dataset to look for a peak.
        val windowSize = exRadius * 2 + 1
        // Assuming maximum valid peaks a dataset can contain.
        val maxPeaks = (rows - exRadius * 2) * (cols - exRadius * 2)
        // Array to store valid local peaks.
        val localPeaks = arrayOfNulls<Peak>(maxPeaks)
        var peakCount = 0
        repeat(rows - windowSize) { i ->
            repeat(cols - windowSize) { j ->
                // Find the max value within the block. (block = radius + 1 + radius).
                var peak = Peak(i, j, data[i][j])
                for (i1 in i until windowSize + i) {
                    for (j1 in j until windowSize + j) {
                        if (data[i1][j1] > peak.value) {
                            peak = Peak(i1, j1, data[i1][j1])
                        }
                    }
                }
                // Check if the above max value is within the radius range and >= to minimum peak.
                if (peak.value >= minPeak && peak.value == data[i + exRadius][j + exRadius]) {
                    // store as a valid peak and increase peak counter by 1;
                    localPeaks[peakCount++] = peak
                }
            }
        }
        return localPeaks.copyOf(peakCount)
    }

    /**
     * Find the two closest peaks, from the dataset.
     *
     * @param peaks an array of local peaks found in problem #2.
     * @return an array of peaks, containing two closest local peaks.
     */
    fun findClosestPeaks(peaks: Array<Peak?>): Array<Peak?> {
        var firstPeak: Peak? = null
        var secondPeak: Peak? = null
        // Find the distance between two peaks.
        var minDistance = peaks[0]!!.distanceTo(peaks[1]!!)
        // Find the minimum distance by comparing every single pair of peak to the next peak.
        for (i in 2 until peaks.size - 1) {
            val distance = peaks[i]!!.distanceTo(peaks[i + 1]!!)
            if (distance < minDistance) {
                minDistance = distance
                firstPeak = peaks[i]
                secondPeak = peaks[i + 1]
            }
        }
        return arrayOf(firstPeak, secondPeak)
    }

    /**
     * Find the most common height (elevation) and, the number of times it occurs in
     * the dataset.
     *
     * @param data two-dimensional array containing the dataset.
     * @return as integer array with most common height and its count.
     */
    fun findMostCommonHeight(data: Array<IntArray>): IntArray {
        // Create an array to hold maximum possible value as an index from the dataset.
        val elevationCount = IntArray(112000)
        // Use dataset value as an index to the array and find its count.
        repeat(rows) { i ->
            repeat(cols) { j ->
                elevationCount[data[i][j]]++
            }
        }
        var maxCount = elevationCount[0]
        var mostCommonElevation = 0
        // Find the maximum count (the value) and its associated index (as an elevation).
        for (i in 1 until elevationCount.size) {
            if (maxCount < elevationCount[i]) {
                maxCount = elevationCount[i]
                mostCommonElevation = i
            }
        }
        return intArrayOf(mostCommonElevation, maxCount)
    }
}

fun main(): Unit = with(Main()) {
    // A two-dimensional array, will store the data to be processed.
    readData()?.let { data ->
        val startTime = System.nanoTime() // Stores the starting time.

        // Contain results for individual questions.
        val minElevation = findLowestElevation(data)
        val localPeaks = findLocalPeaks(data)
        val closestPeaks = findClosestPeaks(localPeaks)
        val mostCommonHeight = findMostCommonHeight(data)
        val stopTime = System.nanoTime() // Stores the finish time.

        // Display time required to solve the problem and results.
        println("\nTotal time to solve problem: ${(stopTime - startTime) / 1000 / 1000} ms.\n")
        println("The lowest elevation is: ${minElevation[0]}, and it occurs: ${minElevation[1]} times.\n")
        println("The total number of peaks are: ${localPeaks.size}.\n")
        println(
            String.format(
                "The distance between two closest peaks is: %.2f m\n",
                closestPeaks[0]!!.distanceTo(closestPeaks[1]!!)
            )
        )
        println("This occurs at: ${closestPeaks[0]} and ${closestPeaks[1]}\n")
        println("The most common height in the terrain is: ${mostCommonHeight[0]}, it occurs ${mostCommonHeight[1]} times.")
    }
}
