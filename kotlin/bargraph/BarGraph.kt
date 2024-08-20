package me.mitul.bargraph

import javafx.application.Application
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
 * The [App] class provides the functionality to draw a bar graph
 * This can be customized according to data provided by user
 */
class App : Application() {
    // number of bars drawn on to the graph.
    private val count = 5

    // labels to display on x-axis
    private val items = arrayOfNulls<String>(count)

    // points are data to be drawn in form of bar
    private val points = DoubleArray(count)

    // ranges are set of values to be shown on y-axis
    private val ranges = DoubleArray(count)

    // minimum and maximum value for y-axis
    private var startRange = 0.0
    private var endRange = 0.0

    /**
     * Start method (use this instead of main).
     *
     * @param stage - The FX stage to draw on
     */
    override fun start(stage: Stage) {
        val title = getInputs()

        // Set canvas size based on user input
        // if user enters 1000 - (endRange) for y-axis,
        // the size will be as: [width: 1000px, height: (1000/2)px]
        val canvas = Canvas(endRange, endRange / 2)
        val root = Group().apply { children.add(canvas) }
        stage.scene = Scene(root)
        stage.title = title
        Thread { animate(canvas.graphicsContext2D, title, canvas) }.start()
        stage.show()
    }

    /**
     * Get user inputs.
     *
     * @return String title of the bar-graph.
     */
    private fun getInputs(): String {
        // Get Application title, shown at top of the bar graph
        print("Enter bar graph title: ")
        val title = readln()

        // Get list of labels from user
        println("Enter $count labels for $title: ")
        repeat(count) {
            print("Label #${it + 1}: ")
            items[it] = readln()
        }

        // Get minimum and maximum value for y-axis
        print("Enter starting range: ")
        startRange = parseDouble(readln())
        print("Enter ending range: ")
        endRange = parseDouble(readln())

        // Get data value from user to be displayed on bar graph
        // Caution: user must enter value between specified range for y-axis
        var i = 0
        while (i < count) {
            print("Enter value for " + items[i] + ": ")
            val temp = parseDouble(readln())
            if (temp in startRange..endRange) points[i++] = temp
            else println("Enter value between ($startRange - $endRange)")
        }

        // Create chunks of provided range to display on y-axis
        // and store all parts into an array of [ranges]
        val slice = (endRange - startRange) / (count - 1)
        var temp = startRange
        repeat(count) {
            ranges[it] = temp
            temp += slice
        }

        return title
    }

    /**
     * Animation thread. This is where you put your animation code.
     *
     * @param gc The drawing surface
     */
    private fun animate(gc: GraphicsContext, title: String?, canvas: Canvas) {
        gc.apply { // prepare y-axis
            font = Font(30.0)
            fill = Paint.valueOf("#0000ff")
            textAlign = TextAlignment.CENTER
            fillText(title, canvas.width / 2, 30.0)
            lineWidth = 2.0
            font = Font(15.0)
            textAlign = TextAlignment.RIGHT
            fill = Paint.valueOf("#000000")
            stroke = Paint.valueOf("#000000")
        }
        // Calculate the specific area occupied for drawing graph
        // if the size[by user] is 1000 this will be: 100px
        val graphStart = (endRange / 10)
        val graphEnd = graphStart * 3 // and this is 300px (100 * 3)
        var yPosition = graphStart // mutable copy of starting point
        val adjust = 5.0f // used to center out horizontal lines to its label on y-axis
        val nextPosition = graphStart / 2 // the distance between two lines on y-axis

        // draw points and lines on y-axis
        var i = count - 1
        while (i >= 0) {
            gc.fillText(
                ranges[i].toString(),
                nextPosition + 25.0,
                yPosition
            )
            gc.strokeLine(
                graphStart + 25.0,
                yPosition - adjust,
                canvas.width.roundToInt() - nextPosition,
                yPosition - adjust
            )
            i--
            yPosition += nextPosition
        }

        // prepare x-axis
        gc.lineWidth = 30.0
        gc.font = Font(20.0)
        gc.textAlign = TextAlignment.CENTER
        gc.fill = Paint.valueOf("#ff0000")

        // calculates position for x-axis elements thickness of each bar
        val barWidth = 20.0
        // starting position for bar and its label
        var xPosition = nextPosition
        // transform user input into pixels
        val scaleSize = (graphEnd - graphStart) / (endRange - startRange)
        // distance between two bars
        val distance = canvas.width / 2.0 / count
        // new position for next label and bar
        val newPosition = (canvas.width - barWidth - (graphStart + nextPosition)) / count * 2
        // calculate pixels to make zero on x-axis for each bar
        val barStart = distance + graphEnd / 10

        // draw labels and its bar
        repeat(count) {
            // calculate height of individual bar
            val barHeight = graphEnd - points[it] * scaleSize
            var xHeight = yPosition // start drawing from zero on x-axis

            // gc.fillRect(
            //     barStart + xPosition,
            //     barHeight - adjust,
            //     barWidth,
            //     yPosition - nextPosition - barHeight
            // )

            gc.fillText(
                items[it],
                barStart + xPosition + adjust * 2,
                yPosition
            )
            do {
                gc.fillRect(
                    barStart + xPosition,
                    xHeight - adjust,
                    barWidth,
                    yPosition - nextPosition - xHeight
                )
                10L.pause() // Add delay for animation
            } while (xHeight-- > barHeight)

            // move to next position for next label and bar
            xPosition += barStart + nextPosition + newPosition - distance
        }
    }

    /**
     * Add delay.
     */
    private fun Long.pause() = try {
        Thread.sleep(this)
    } catch (ignored: InterruptedException) {
    }

    /**
     * This is necessary to kill the animation thread.
     */
    override fun stop() = exitProcess(0)
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
 * Enter value for the USA: 157
 * Enter value for Canada: 38
 * Enter value for UK: 250
 * Enter value for India: 750
 * Enter value for Australia: 500
 */
fun main() = Application.launch(App::class.java)
