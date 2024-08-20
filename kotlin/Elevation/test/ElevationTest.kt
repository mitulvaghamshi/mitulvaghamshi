import org.junit.jupiter.api.AfterEach
import org.junit.jupiter.api.BeforeEach
import org.junit.jupiter.api.Test

class ElevationTest {
    private lateinit var config: DataConfig
    private lateinit var app: Elevation

    @BeforeEach
    fun setUp() {
        config = DataConfig()
        app = Elevation(config)
    }

    @AfterEach
    fun tearDown() = println("Elevation Test Complete...")

    @Test
    fun testAll() {
        val startTime = System.nanoTime()

        val minElevation = app.p1FindLowestElevation()
        val localPeaks = app.p2FindLocalPeaks()
        val closestPeaks = app.p3FindClosestPeaks(localPeaks)
        val mostCommonHeight = app.p4FindMostCommonHeight()

        val stopTime = System.nanoTime()

        val content = buildString {
            append("Total time to solve problem: ${(stopTime - startTime) / 1000 / 1000} ms.").appendLine().appendLine()
            append("The lowest elevation is: ${minElevation.first}, and it occurs: ${minElevation.second} times.").appendLine()
            append("The total number of peaks are: ${localPeaks.size}.").appendLine()
            String.format(
                "The distance between two closest peaks is: %.2f m",
                closestPeaks.first.distanceTo(closestPeaks.second)
            ).also { append(it).appendLine() }
            append("This occurs at: ${closestPeaks.first} and ${closestPeaks.second}").appendLine()
            append("The most common height in the terrain is: ${mostCommonHeight.first}, it occurs ${mostCommonHeight.second} times.")
        }
        println(content)
    }
}
