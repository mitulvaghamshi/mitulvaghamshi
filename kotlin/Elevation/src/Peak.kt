import kotlin.math.pow
import kotlin.math.sqrt

/**
 * An elevation with value and location.
 * Initialize new Peak(elevation) object.
 *
 * @param i     Index of the Row in dataset.
 * @param j     Index of the Column in dataset.
 * @param value Peak (elevation) value at above Row and Column index.
 */
data class Peak(private val i: Int, private val j: Int, val value: Int) {
    /**
     * Compare the two elevation by its location and find the distance.
     * Formula: Distance^2 = E1(Row) - E2(Row)^2 + E1(Column) - E2(Column)^2
     * where, E1 = first peak (initial), E2 = second peak (other).
     *
     * @param other accepts a Peak object to compare with.
     * @return double distance value between two peaks.
     */
    fun distanceTo(other: Peak) = sqrt(
        (i - other.i).toDouble().pow(2.0)
                + (j - other.j).toDouble().pow(2.0)
    )

    /**
     * Convert this elevation to String format with value and location.
     *
     * @return String representation of this peak.
     */
    override fun toString() = "[Row: $i, Column: $j, Elevation: $value]"
}
