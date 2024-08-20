import java.io.File
import java.io.FileNotFoundException
import java.util.*

class DataConfig {
    private companion object {
        private const val PATH = "data/data.txt"
    }

    // Size of the dataset
    var rows = 0; private set
    var cols = 0; private set

    // Current minimum peak
    var minPeak = 0; private set

    // Exclusion radius
    var exRadius = 0; private set

    var data: Array<IntArray> = arrayOf(); private set

    init {
        read(PATH)
    }

    /**
     * Read data from the "data.txt" file.
     *
     * @return two-dimensional integer array with data.
     */
    private fun read(path: String) {
        try {
            Scanner(File(path)).let { input ->
                if (input.hasNextLine()) {
                    rows = input.nextInt() // Number of rows in dataset.
                    cols = input.nextInt() // Number of columns in dataset.
                    minPeak = input.nextInt() // Minimum peak value.
                    exRadius = input.nextInt() // The exclusion radius.
                }
                // Create array of size [ROWS] * [COLS].
                data = Array(rows) { IntArray(cols) }
                repeat(rows) { i ->
                    repeat(cols) { j -> data[i][j] = input.nextInt() }
                }
            }
        } catch (e: FileNotFoundException) {
            println("File does not exists.")
        } catch (e: Exception) {
            e.printStackTrace()
        }
    }
}
