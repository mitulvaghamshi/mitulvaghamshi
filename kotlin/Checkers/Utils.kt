object Constants {
    const val ROWS = 8 // number of rows inside the board
    const val COLUMNS = 8 // number of columns inside the board
    const val TILE_SIZE = 100.0 // size of the tile
    const val BOARD_SIZE = TILE_SIZE * (ROWS or COLUMNS) // size of the board
}

/**
 * Types of the pieces to be created with its moving direction
 * the piece can be moved in specified direction only
 *
 * @param direction moving direction of the piece
 */
enum class PieceType(val direction: Int) { RED(1), GREEN(-1) }
