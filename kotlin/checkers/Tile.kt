package me.mitul.checkers

import javafx.scene.paint.Color
import javafx.scene.shape.Rectangle
import me.mitul.checkers.Constants.TILE_SIZE

/**
 * Creates a single tile for the board all individual boxes
 * in the Board in represented using [Tile] class.
 *
 * @param x       number of column
 * @param y       number of row
 * @param isLight is tile light or dark-colored
 */
class Tile(x: Int, y: Int, isLight: Boolean) : Rectangle(TILE_SIZE, TILE_SIZE) {
    var piece: Piece? = null
    val hasPiece get() = piece != null

    init {
        fill = Color.valueOf(if (isLight) "#E7D0A7" else "#A67E5B")
        relocate(x * width, y * height)
    }
}
