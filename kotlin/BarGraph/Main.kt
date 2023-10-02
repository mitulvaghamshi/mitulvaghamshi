import javafx.application.Application
import javafx.application.Application.launch
import javafx.scene.Group
import javafx.scene.Scene
import javafx.scene.canvas.Canvas
import javafx.scene.canvas.GraphicsContext
import javafx.scene.paint.Paint
import javafx.scene.text.Font
import javafx.scene.text.TextAlignment
import javafx.stage.Stage
import java.lang.Double.parseDouble
import kotlin.math.roundToInt
import kotlin.system.exitProcess

/**
 * The [Main] class provides the functionality to draw a bar graph
 * This can be customized according to data provided by user
 */
class Main : Application() {
    /**
     * number of bars drawn on to the graph.
     */
    private val numRecord = 5

    /**
     * [labels, points, ranges] are arrays holding:
     * - labels to display on x-axis
     * - points are data to be drawn in form of bar
     * - ranges are set of values to be shown on y-axis
     */
    private val labels = arrayOfNulls<String>(numRecord)
    private val points = DoubleArray(numRecord)
    private val ranges = DoubleArray(numRecord)

    /**
     * [startRange, endRange] holds user define, minimum and maximum value for y-axis
     */
    private var startRange = 0.0
    private var endRange = 0.0

    /**
     * The [getInput()] a helper method used to retrieve data, from user and store
     * it into particular fields
     *
     * @return title - returns title of the bar graph given by user
     */
    private fun getInputs(): String {
        // Get Application title, shown at top of the bar graph
        print("Enter bar graph title: ")
        val title = readln()

        // Get list of labels from user
        println("Enter $numRecord labels for $title: ")
        for (i in 0 until numRecord) {
            print("Label #" + (i + 1) + ": ")
            labels[i] = readln()
        }

        // Get minimum and maximum value for y-axis
        print("Enter starting range: ")
        startRange = parseDouble(readln())
        print("Enter ending range: ")
        endRange = parseDouble(readln())

        // Get data value from user to be displayed on bar graph
        // Validation - user must enter value between specified range for y-axis
        run {
            var i = 0
            while (i < numRecord) {
                print("Enter value for " + labels[i] + ": ")
                val temp = parseDouble(readln())
                // - If the value is out of range, tell the user and ask new value
                if (temp < startRange || temp > endRange) {
                    System.err.println("$temp is not in range, please try again!!!")
                    i--
                } else points[i] = temp
                i++
            }
        }

        // Create chunks of provided range to display on y-axis
        // and store all parts into an array of [ranges]
        val slice = (endRange - startRange) / (numRecord - 1)
        var temp = startRange
        var i = 0
        while (i < 5) {
            ranges[i++] = temp
            temp += slice
        }
        return title
    }

    /**
     * Start method (use this instead of main).
     *
     * @param stage - The FX stage to draw on
     */
    override fun start(stage: Stage) {
        val title = getInputs() // application title
        val root = Group()
        val scene = Scene(root)

        // Set canvas size based on user input
        // if user enters 1000 - (endRange) for y-axis,
        // the size will be as: [width: 1000px, height: (1000/2)px]
        val canvas = Canvas(endRange, (endRange / 2))
        root.children.add(canvas)
        stage.scene = scene
        stage.title = title // Set application window title
        Thread {
            animate(canvas.graphicsContext2D, title, canvas)
        }.start()
        stage.show()
    }

    /**
     * Animation thread. This is where you put your animation code.
     *
     * @param gc The drawing surface
     */
    private fun animate(gc: GraphicsContext, title: String?, canvas: Canvas) {
        // modify the instance of graphics context to with following values for y-axis
        gc.font = Font(30.0)
        gc.fill = Paint.valueOf("#0000ff") // blue
        gc.textAlign = TextAlignment.CENTER
        gc.fillText(title, canvas.width / 2, 30.0) // center the title
        gc.lineWidth = 2.0
        gc.font = Font(15.0)
        gc.textAlign = TextAlignment.RIGHT
        gc.fill = Paint.valueOf("#000000") // black
        gc.stroke = Paint.valueOf("#000000") // black

        // Calculate the specific area occupied for drawing graph
        // if the size[by user] is 1000 this will be: 100px
        val graphStart = (endRange / 10)
        val graphEnd = graphStart * 3 // and this is 300px (100 * 3)
        var yPosition = graphStart // mutable copy of starting point
        val adjust = 5.0f // used to center out horizontal lines to its label on y-axis
        val nextPosition = graphStart / 2 // the distance between two lines on y-axis

        // draw points and lines on y-axis
        run {
            var i = numRecord - 1
            while (i >= 0) {
                gc.fillText(ranges[i].toString(), nextPosition + 25.0, yPosition)
                gc.strokeLine(
                    /* x1 = */ graphStart + 25.0,
                    /* y1 = */ yPosition - adjust,
                    /* x2 = */ canvas.width.roundToInt() - nextPosition,
                    /* y2 = */ yPosition - adjust
                )
                i--
                yPosition += nextPosition
            }
        }

        // modify the instance of graphics context to with following values for x-axis
        gc.lineWidth = 30.0
        gc.font = Font(20.0)
        gc.textAlign = TextAlignment.CENTER
        gc.fill = Paint.valueOf("#ff0000") // red

        // calculates position for x-axis elements
        // thickness of each bar
        val barWidth = 20.0
        // starting position for bar and its label
        var xPosition = nextPosition
        // transform user input into pixels
        val scaleSize = (graphEnd - graphStart) / (endRange - startRange)
        // distance between two bars
        val distance = canvas.width / 2.0 / numRecord
        // new position for next label and bar
        val newPosition = (canvas.width - barWidth - (graphStart + nextPosition)) / (numRecord * 2)
        // calculate pixels to make zero on x-axis for each bar
        val barStart = distance + graphEnd / 10

        // draw labels and its bar
        repeat(numRecord) { i ->
            // calculate height of individual bar
            val barHeight = graphEnd - points[i] * scaleSize
            var xHeight = yPosition // start drawing from zero on x-axis

            // gc.fillRect(
            //     /* x = */ barStart + xPosition,
            //     /* y = */ barHeight - adjust,
            //     /* w = */ barWidth,
            //     /* h = */ yPosition - nextPosition - barHeight
            // )
            gc.fillText(labels[i], barStart + xPosition + adjust * 2, yPosition)
            do {
                gc.fillRect(
                    /* x = */ barStart + xPosition,  // x position
                    /* y = */ xHeight - adjust,  // y position
                    /* w = */ barWidth,  // width
                    /* h = */ yPosition - nextPosition - xHeight // height
                )
                10L.pause() // Slight pause
            } while (xHeight-- > barHeight)

            // move to next position for next label and bar
            xPosition += barStart + nextPosition + newPosition - distance
        }
    }

    /**
     * Use this method instead of Thread.sleep(). It handles the possible exception
     * by catching it, because re-throwing it is not an option in this case.
     */
    private fun Long.pause() = try {
        Thread.sleep(this)
    } catch (ignored: InterruptedException) {
    }

    /**
     * Exits the app completely when the window is closed. This is necessary to kill
     * the animation thread.
     */
    override fun stop(): Unit = exitProcess(0)
}

/**
 * Launch the app.
 *
 * Sample Input:
 * Enter bar graph title: Population 2023
 * Enter 5 labels for Population 2023:
 * Label #1: USA
 * Label #2: Canada
 * Label #3: UK
 * Label #4: India
 * Label #5: Australia
 * Enter starting range: 0
 * Enter ending range: 1000
 * Enter value for USA: 157
 * Enter value for Canada: 38
 * Enter value for UK: 250
 * Enter value for India: 750
 * Enter value for Australia: 500
 */
fun main() = launch(Main().javaClass)
