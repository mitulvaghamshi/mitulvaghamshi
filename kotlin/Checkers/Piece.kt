import javafx.scene.paint.Color
import javafx.scene.shape.Circle
import Constants.TILE_SIZE

/**
 * Create a [Piece] that extends a [Circle] and uses its methods
 * A constructor to create a piece object it accepts x and y position of the tile
 *
 * @param x    number of row
 * @param y    number of column
 * @param type type of the piece to create
 */
class Piece(x: Int, y: Int, val type: PieceType) : Circle(
    TILE_SIZE / 2.0, TILE_SIZE / 2.0, 35.0
) {
    /**
     * [x] coordinate of the piece
     * @return x return column position
     */
    var x = 0.0
        private set

    /**
     * [y] coordinate of the piece
     * @return y returns row position
     */
    var y = 0.0
        private set

    init {
        move(x, y) // position the circle
        translateX = TILE_SIZE / 2.0 - radius
        translateY = TILE_SIZE / 2.0 - radius
        strokeWidth = 5.0
        stroke = Color.BLACK
        // set background color
        fill = if (type == PieceType.RED) Color.RED else Color.GREEN
    }

    /**
     * Relocate piece inside the tile
     * it accepts x and y position of the piece
     *
     * @param x number of column
     * @param y number of row
     */
    fun move(x: Int, y: Int) {
        this.x = (x * TILE_SIZE).toDouble()
        this.y = (y * TILE_SIZE).toDouble()
        relocate(this.x, this.y)
    }
}
