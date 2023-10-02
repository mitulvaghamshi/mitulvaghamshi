import javafx.scene.paint.Color
import javafx.scene.shape.Rectangle

/**
 * Creates a single tile for the board all individual boxes
 * in the Board in represented using [Tile] class.
 *
 * @param x       number of column
 * @param y       number of row
 * @param isLight is tile light or dark colored
 */
class Tile(x: Int, y: Int, isLight: Boolean) : Rectangle() {
    var piece: Piece? = null // piece inside the tile

    /**
     * Check whether a tile has any piece or not.
     *
     * @return boolean returns boolean value stating whether a piece found or not
     */
    val hasPiece: Boolean
        get() = null != piece

    init {
        val tileSize = Constants.TILE_SIZE.toDouble()
        // set tile width and height
        width = tileSize
        height = tileSize
        // set background color
        fill = Color.valueOf(if (isLight) "#E7D0A7" else "#A67E5B")
        // position tile inside the board
        relocate((x * tileSize), (y * tileSize))
    }
}
