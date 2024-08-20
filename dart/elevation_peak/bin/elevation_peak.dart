import 'package:elevation_peak/data_config.dart';
import 'package:elevation_peak/elevation_peak.dart';

void main(List<String> arguments) {
  ElevationPeakTest(config: DataConfig()).run();
}

class ElevationPeakTest {
  const ElevationPeakTest({required this.config});

  final DataConfig config;

  void run() {
    final app = Elevation(config: config);

    final startTime = DateTime.timestamp();

    final minElevation = app.findLowestElevation(config.data);
    final localPeaks = app.findLocalPeaks(config.data);
    final closestPeaks = app.findClosestPeaks(localPeaks);
    final mostCommonHeight = app.findMostCommonHeight(config.data);

    final endTime = DateTime.timestamp();

    final content = StringBuffer()
      ..writeAll([
        'Total time: ${endTime.difference(startTime).inMilliseconds} ms.',
        'Lowest elevation: ${minElevation.key}, and it occurs: ${minElevation.value} times.',
        'Total number of peaks: ${localPeaks.length}.',
        'Distance between two closest peaks: ${(closestPeaks.$1.distanceTo(closestPeaks.$2)).toStringAsFixed(2)} m,',
        'This occurs at: ${closestPeaks.$1} and ${closestPeaks.$2}',
        'Most common height in the terrain: ${mostCommonHeight.key}',
        'This occurs: ${mostCommonHeight.value} times.',
      ], '\n');
    print(content);
  }
}
