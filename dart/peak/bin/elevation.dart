import 'dart:io';

import 'package:peak/config.dart';
import 'package:peak/elevation.dart';

void main() async {
  final config = await _getConfigFromFile;
  final app = Elevation(config: config);

  final startTime = DateTime.timestamp();

  final minElevation = app.findLowestElevation(config.data);
  final localPeaks = app.findLocalPeaks(config.data);
  final closestPeaks = app.findClosestPeaks(localPeaks);
  final mostCommonHeight = app.findMostCommonHeight(config.data);

  final endTime = DateTime.timestamp();

  print(
    'Total time: ${endTime.difference(startTime).inMilliseconds} ms.\n'
    'Lowest elevation: ${minElevation.a}, and it occurs: ${minElevation.b} times.\n'
    'Total number of peaks: ${localPeaks.length}.\n'
    'Distance between two closest peaks: ${(closestPeaks.a.distanceTo(closestPeaks.b)).toStringAsFixed(2)} m,\n'
    'This occurs at: ${closestPeaks.a} and ${closestPeaks.b}\n'
    'Most common height in the terrain: ${mostCommonHeight.a}\n'
    'This occurs: ${mostCommonHeight.b} times.\n',
  );
}

Future<Config> get _getConfigFromFile async {
  try {
    final file = File.fromUri(.file('data.txt'));
    final lines = (await file.readAsLines()).iterator;
    if (!lines.moveNext()) throw StateError('Input file not valid');
    final config = Config.fromStr(lines.current);
    // Create array of size [ROWS] times [COLS].
    for (var i = 0; i < config.rows && lines.moveNext(); i++) {
      final elements = lines.current.split(RegExp(r'\s')).iterator;
      for (var j = 0; j < config.cols && elements.moveNext(); j++) {
        config.data[i][j] = .parse(elements.current);
      }
    }
    return Future.value(config);
  } on FileSystemException {
    throw ArgumentError('[ERROR]: File does not exists');
  }
}
