package me.mitul.checkers

import javafx.scene.paint.Color
import javafx.scene.shape.Circle
import me.mitul.checkers.Constants.TILE_SIZE

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
    var x: Double = 0.0; private set
    var y: Double = 0.0; private set

    init {
        move(x, y)
        strokeWidth = 5.0
        stroke = Color.BLACK
        translateX = TILE_SIZE / 2.0 - radius
        translateY = TILE_SIZE / 2.0 - radius
        fill = if (type == PieceType.RED) Color.RED else Color.GREEN
    }

    /**
     * Relocate piece inside the tile
     *
     * @param x number of column
     * @param y number of row
     */
    fun move(x: Int, y: Int) {
        this.x = (x * TILE_SIZE)
        this.y = (y * TILE_SIZE)
        relocate(this.x, this.y)
    }
}
