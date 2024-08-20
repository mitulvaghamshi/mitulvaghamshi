package me.mitul.checkers

object Constants {
    const val ROWS = 8
    const val COLS = 8
    const val TILE_SIZE = 100.0
    const val BOARD_SIZE = TILE_SIZE * (ROWS or COLS)
}

/**
 * Types of the pieces to be created with its moving direction
 * the piece can be moved in specified direction only
 *
 * - ( 1) = Moves forward.
 * - (-1) = Moves backward.
 *
 * @param direction moving direction of the piece
 */
enum class PieceType(val direction: Int) { RED(1), GREEN(-1) }
