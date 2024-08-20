package me.mitul.checkers

import javafx.event.EventHandler
import javafx.scene.Group
import javafx.scene.paint.Color
import me.mitul.checkers.Constants.COLS
import me.mitul.checkers.Constants.ROWS

/**
 * Create a new [Board] game board with some pieces
 * allows user to add or move pieces inside the game
 */
class Board {
    internal val tileGroup: Group = Group()
    internal val pieceGroup: Group = Group()

    private val tiles = Array(COLS) { arrayOfNulls<Tile>(ROWS) }
    private var selectedPiece: Piece? = null

    private var fromX = 0
    private var fromY = 0

    private var toX = 0
    private var toY = 0

    init {
        populate()
        draw()
    }

    /**
     * Draw all the component to the board every time piece added or moved
     */
    private fun draw() {
        if (!pieceGroup.children.isEmpty()) pieceGroup.children.clear()
        repeat(ROWS) { y ->
            repeat(COLS) { x ->
                tiles[x][y]?.piece?.let { piece ->
                    piece.stroke = if (piece == selectedPiece) Color.WHITE else Color.BLACK
                    pieceGroup.children.add(piece)
                }
            }
        }
    }

    /**
     * Populate game board with components.
     *
     * pair of loops will create new tiles and pieces
     * and add all them to the respective group
     */
    private fun populate() = repeat(ROWS) { y ->
        repeat(COLS) { x ->
            val isEven = (x + y) % 2 == 0
            val tile = Tile(x, y, isEven)
            tile.onMouseClicked = EventHandler {
                checkMove(tile)
                draw()
            }
            tiles[x][y] = tile
            tileGroup.children.add(tile)

            when {
                y <= 2 && !isEven -> createPiece(x, y, PieceType.RED)
                y >= 5 && !isEven -> createPiece(x, y, PieceType.GREEN)
                else -> null
            }?.let { tile.piece = it }
        }
    }

    /**
     * This method will perform actual move between tiles
     * it move selected piece from one tile to another tile
     */
    private fun executeMove() {
        tiles[fromX][fromY]!!.piece!!.move(toX, toY) // move piece
        tiles[toX][toY]!!.piece = tiles[fromX][fromY]!!.piece // set reference to the new piece
        tiles[fromX][fromY]!!.piece = null // delete old piece
    }

    /**
     * Mouse click handler for each tile to check if the move is legal or not.
     *
     * @param tile it accepts a tile, this method called on
     */
    private fun checkMove(tile: Tile) {
        // reset selected piece
        selectedPiece = null
        // get target x position
        toX = tile.layoutX.toInt() / 100
        // get target y position
        toY = tile.layoutY.toInt() / 100
        // a tile from which a piece to be moved
        val fromTile = tiles[fromX][fromY] ?: return
        // a tile in which a piece moved to
        val toTile = tiles[toX][toY] ?: return

        // return without moving if the target tile already has a piece
        if (toTile.hasPiece) {
            println("A piece of same type already exists, choose another location.")
            return
        }

        // check if the source tile has a piece and target tile is at diagonal position
        if (!fromTile.hasPiece || (toX + toY) % 2 == 0) {
            println("Can move only diagonally.")
            return
        }

        // check if move is in correct direction according to piece type
        if (toY - fromY == fromTile.piece!!.type.direction) {
            executeMove() // do a move or check if move is a jump over
            return
        }

        if (toY - fromY != fromTile.piece!!.type.direction * 2) {
            println("Can move only in forward direction.")
            return
        }

        // find location of the piece to be removed
        val midX = (toX + fromX) / 2
        val midY = (toY + fromY) / 2

        // check if the piece is valid to remove
        val targetTile = tiles[midX][midY] ?: return
        if (targetTile.hasPiece && targetTile.piece!!.type !== fromTile.piece!!.type) {
            targetTile.piece = null // remove piece from reference list
            executeMove() // perform final move
        }
    }

    /**
     * This method will create a new piece ane assign mouse click handle to it
     *
     * @param x    number of the column
     * @param y    number of the row
     * @param type type of the piece
     * @return piece returns a newly created piece
     */
    private fun createPiece(x: Int, y: Int, type: PieceType): Piece {
        val piece = Piece(x, y, type)
        piece.onMouseClicked = EventHandler {
            fromX = piece.x.toInt() / 100
            fromY = piece.y.toInt() / 100
            selectedPiece = piece
            draw()
        }
        return piece
    }
}
