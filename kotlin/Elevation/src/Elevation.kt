/**
 * Working with single and multidimensional arrays.
 *
 * Solve 4 problems as:
 * 1) Find the lowest elevation value and number of times it occurs in dataset.
 * 2) Find all the local peaks matching given criteria. (!Incomplete).
 * 3) Find the two closest peaks in the dataset.
 * 4) Find the most common elevation and number of times it occurs.
 */
class Elevation(private val config: DataConfig) {
    /**
     * Find the lowest elevation and number of time it occurs in the dataset.
     *
     * @param data two-dimensional array to find minimum elevation.
     * @return Int array with two elements of minimum elevation and its count.
     */
    fun p1FindLowestElevation(data: Array<IntArray> = config.data): Pair<Int, Int> {
        var minElevation = data[0][0]
        var minElevationCount = 0
        repeat(config.rows) { i ->
            repeat(config.cols) { j ->
                // If new minimum value found, reset the counter.
                if (data[i][j] < minElevation) {
                    minElevation = data[i][j]
                    minElevationCount = 0
                }
                if (data[i][j] == minElevation) minElevationCount++
                // if value match the current minimum elevation.
            }
        }
        return Pair(minElevation, minElevationCount)
    }

    /**
     * Find all the local peaks that is grater then or equal to value [DataConfig.minPeak],
     * and that is not contained in the given exclusion radius [DataConfig.exRadius].
     *
     * @param data two-dimensional array containing the data.
     * @return an array of [Peak]s, found in the dataset.
     * [Peak] is a class containing elevation value and its location.
     */
    fun p2FindLocalPeaks(data: Array<IntArray> = config.data) = buildList {
        val windowSize = config.exRadius * 2 + 1
        // A fix sized block in the dataset to look for a peak.
        repeat(config.rows - windowSize) { i ->
            repeat(config.cols - windowSize) { j ->
                // Find the max value within the block,
                // i.e. block = radius + 1 + radius.
                var peak = Peak(i, j, data[i][j])
                for (i1 in i..<windowSize + i) {
                    for (j1 in j..<windowSize + j) {
                        if (data[i1][j1] > peak.value) {
                            peak = Peak(i1, j1, data[i1][j1])
                        }
                    }
                }
                // Check if the above max value is within the radius range
                // and value >= to minimum peak.
                if (
                    peak.value >= config.minPeak &&
                    peak.value == data[i + config.exRadius][j + config.exRadius]
                ) add(peak)
            }
        }
    }

    /**
     * Find the two closest peaks, from the dataset.
     *
     * @param peaks an array of local peaks found in problem #2.
     * @return an array of peaks, containing two closest local peaks.
     */
    fun p3FindClosestPeaks(peaks: List<Peak>): Pair<Peak, Peak> {
        lateinit var pair: Pair<Peak, Peak>
        // Find the distance between two peaks.
        var minDistance = peaks[0].distanceTo(peaks[1])
        // Find the minimum distance by comparing every single pair of peak to the next peak.
        for (i in 2..<peaks.size - 1) {
            val distance = peaks[i].distanceTo(peaks[i + 1])
            if (distance < minDistance) {
                minDistance = distance
                pair = Pair(peaks[i], peaks[i + 1])
            }
        }
        return pair
    }

    /**
     * Most common height (elevation) and,
     * number of times it occurs in the dataset.
     *
     * @param data two-dimensional array containing the dataset.
     * @return Pair with most common height and its count.
     */
    fun p4FindMostCommonHeight(data: Array<IntArray> = config.data): Pair<Int, Int> {
        // Create an array to hold maximum possible value as an index from the dataset.
        val elevationCount = IntArray(112000)

        // Use dataset value as an index to the array and find its count.
        repeat(config.rows) { i ->
            repeat(config.cols) { j -> elevationCount[data[i][j]]++ }
        }

        var maxCount = elevationCount[0]
        var mostCommonElevation = 0
        // Find the maximum count (the value) and its associated index (as an elevation).
        for (i in 1..<elevationCount.size) {
            if (maxCount < elevationCount[i]) {
                maxCount = elevationCount[i]
                mostCommonElevation = i
            }
        }
        return Pair(mostCommonElevation, maxCount)
    }
}
