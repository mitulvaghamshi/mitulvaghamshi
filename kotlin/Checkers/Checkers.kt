import javafx.event.EventHandler
import javafx.scene.Group
import javafx.scene.control.Alert
import javafx.scene.control.Alert.AlertType
import javafx.scene.control.Button
import javafx.scene.control.ButtonBar
import javafx.scene.control.ButtonType
import javafx.scene.control.Label
import javafx.scene.control.TextField
import javafx.scene.layout.Pane
import javafx.scene.paint.Color
import javafx.scene.shape.Rectangle
import javafx.scene.text.Font
import Constants.BOARD_SIZE
import Constants.COLUMNS
import Constants.ROWS

/**
 * Create a new [Checkers] game board with some pieces
 * allows user to add or move pieces inside the game
 */
class Checkers {
    // a group of the tiles inside the board
    internal val tileGroup = Group()

    // a group of the pieces inside the board
    internal val pieceGroup = Group()

    // an array of the tile to be added inside the board
    private val tiles = Array(COLUMNS) { arrayOfNulls<Tile>(ROWS) }

    // A labeled message to direct the user
    private val message = Label()

    // point out which piece has been clicked
    private var selectedPiece: Piece? = null

    // decide what colored piece to add
    private var isRed = false

    // location of the source and target tiles to move between
    private var fromX = 0
    private var fromY = 0
    private var toX = 0
    private var toY = 0

    init {
        populate()
        draw()
    }

    /**
     * This method will draws all the component to the board
     * it get called every time piece added or moved
     */
    private fun draw() {
        if (!pieceGroup.children.isEmpty()) pieceGroup.children.clear()
        repeat(ROWS) { y ->
            repeat(COLUMNS) { x ->
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
        repeat(COLUMNS) { x ->
            // check if the tile is at even position
            val isEven = (x + y) % 2 == 0
            // create a new tile
            val tile = Tile(x, y, isEven)
            // set mouse click handler on each tiles
            tile.onMouseClicked = EventHandler { checkMove(tile) }
            // add every tiles to the array for the reference
            tiles[x][y] = tile
            // add tiles to the group to show
            tileGroup.children.add(tile)
            // create piece reference
            var piece: Piece? = null
            // create a new red piece
            if (y <= 2 && !isEven) piece = createPiece(x, y, PieceType.RED)
            // create a new green piece
            if (y >= 5 && !isEven) piece = createPiece(x, y, PieceType.GREEN)
            // add non null piece to the respective tile
            if (piece != null) tile.piece = piece
        }
    }

    /**
     * This method will creates side control panel
     *
     * @return sideBar it creates and return a control bar
     */
    fun getSidePane(): Pane {
        // create a new panel
        val sideBar = Pane()
        sideBar.setPrefSize(290.0, BOARD_SIZE.toDouble())
        sideBar.relocate(800.0, 0.0)

        // create a new how to play label
        val howTo = Label(
            """"How to play:
                    |1. Select any piece you have to move
                    |2. Select a valid empty box to move piece into
                    |3. When a piece jump on another piece, the piece is killed off and removed
                    |
                    |Add new Piece
                    |- Use input fields above to add new pieces to the board
                    |- type location i.e. 0, 0 will add piece to the top left box in board"""
                .trimMargin()
        )
        howTo.setPrefSize(280.0, 400.0)
        howTo.relocate(10.0, 400.0)
        howTo.font = Font("Georgia", 18.0)
        howTo.isWrapText = true

        // create a new input label
        val descX = Label("Enter row:")
        descX.relocate(10.0, 35.0)
        val descY = Label("Enter column:")
        descY.relocate(10.0, 65.0)

        // create new input fields
        val inputX = TextField()
        inputX.relocate(110.0, 30.0)
        val inputY = TextField()
        inputY.relocate(110.0, 60.0)

        // create new label for color selector
        val colorLabel = Label("Select piece type: ")
        colorLabel.relocate(10.0, 105.0)

        // create new color selector box
        val rect = Rectangle(50.0, 30.0)
        rect.relocate(110.0, 100.0)
        rect.fill = Color.RED
        rect.onMouseClicked = EventHandler {
            rect.fill = if (isRed) Color.RED else Color.GREEN
            isRed = !isRed
        }

        // create new button to trigger add
        val btn = Button("OK")
        btn.setPrefSize(70.0, 30.0)
        btn.relocate(190.0, 100.0)
        btn.onMouseClicked = EventHandler { addPiece(inputX.text, inputY.text) }

        // create new label to show different statuses
        message.relocate(10.0, 200.0)
        message.font = Font(18.0)

        // add all components to the panel
        sideBar.children
            .addAll(descX, descY, inputX, inputY, colorLabel, rect, btn, message, howTo)
        return sideBar
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
     * This is the mouse click handler set on each tiles
     * this method will used to check if the move is legal or not
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
        val fromTile = tiles[fromX][fromY]
        // a tile in which a piece moved to
        val toTile = tiles[toX][toY]

        // return without moving if the target tile already has a piece
        if (toTile!!.hasPiece) {
            showMessage(text = "A piece already exists!!!", color = Color.RED)
            showDialog(
                type = AlertType.INFORMATION,
                header = "Already exists!!!",
                content = "A piece of same type already exists\ncan not move, choose another location"
            )
            return // abort move and return back
        }

        /**
         * check if the source tile has a piece and target tile is at diagonal position
         */
        if (fromTile!!.hasPiece && (toX + toY) % 2 != 0) {
            // check if move is in correct direction according to piece type
            if (toY - fromY == fromTile.piece!!.type.direction) {
                executeMove() // do a move or check if move is a jump over
            } else if (toY - fromY == fromTile.piece!!.type.direction * 2) {
                // another opposite piece
                val middleX = (toX + fromX) / 2 // fine location of the
                val middleY = (toY + fromY) / 2 // piece to be removed
                // check if the piece is valid to remove
                tiles[middleX][middleY]?.let {
                    if (it.hasPiece && it.piece!!.type !== fromTile.piece!!.type) {
                        it.piece = null // remove piece from reference list
                        executeMove() // perform final move
                    }
                }
            } else {
                showMessage("Can move only in forward direction!!!", Color.RED)
            }
        } else {
            showMessage("Can move only diagonally!!!", Color.RED)
        }
        draw()
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

    /**
     * This method will used to add new piece inside the board
     *
     * @param inputX accepts value of the row
     * @param inputY accepts value of the column
     */
    private fun addPiece(inputX: String, inputY: String) {
        // create and add new piece on valid input
        try {
            val x = inputX.toInt()
            val y = inputY.toInt()
            val piece = createPiece(x, y, if (isRed) PieceType.GREEN else PieceType.RED)
            // do not add if piece already exists
            if (tiles[x][y]!!.hasPiece) showMessage(
                text = "A piece already exists",
                color = Color.BLUE,
            ) else {
                tiles[x][y]!!.piece = piece
                draw()
            }
        } catch (e: NumberFormatException) { // throws an error on invalid inputs
            showDialog(
                type = AlertType.ERROR,
                header = "Invalid Input!!!",
                content = "The position entered are invalid\nTry using numerical value e.g. (0, 0)"
            )
        }
    }

    /**
     * This method will simply show message to the user stating what happened
     * by the user action, and show errors and warnings
     *
     * @param text  a text message to show
     * @param color color of the text
     */
    private fun showMessage(text: String, color: Color) {
        message.text = text
        message.textFill = color
    }

    /**
     * This method will created a new alert dialog with given message
     *
     * @param type    accepts type of the alert to create
     * @param header  message to show in header
     * @param content content to be displayed in dialog body
     */
    private fun showDialog(type: AlertType, header: String, content: String) {
        val alert = Alert(type, content, ButtonType("OK", ButtonBar.ButtonData.YES))
        alert.title = "Checkers"
        alert.headerText = header
        alert.showAndWait()
    }
}
