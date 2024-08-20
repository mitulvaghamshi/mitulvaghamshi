import 'dart:io';

import 'package:elevation_peak/app.dart';
import 'package:elevation_peak/config.dart';

void main(List<String> args) async {
  if (args.isEmpty) {
    stderr.writeln('Please provide Elevation Data file.');
    exit(1);
  }

  final config = await createConfigFromFile(args.first);
  final app = ElevationPeak(config: config);

  final startTime = DateTime.timestamp();

  final minElevation = app.findLowestElevation(config.data);
  final localPeaks = app.findLocalPeaks(config.data);
  final closestPeaks = app.findClosestPeaks(localPeaks);
  final mostCommonHeight = app.findMostCommonHeight(config.data);

  final endTime = DateTime.timestamp();

  stdout.writeAll([
    '> Total execution time: ${endTime.difference(startTime).inMilliseconds} ms.\n',
    '> Lowest elevation: ${minElevation.a}, and it occurs: ${minElevation.b} times.\n',
    '> Total # of peaks: ${localPeaks.length}.\n',
    '> Closest peaks distance: ${closestPeaks.a.distanceTo(closestPeaks.b).toStringAsFixed(2)} m, this occurs at: ${closestPeaks.a} and ${closestPeaks.b}\n',
    '> Most common height: ${mostCommonHeight.a}, this occurs: ${mostCommonHeight.b} times.\n',
  ]);
}

Future<Config> createConfigFromFile(String path) async {
  final file = File.fromUri(.file(path));
  if (!await file.exists()) {
    stderr.writeln('File: $file not found!');
    exit(1);
  }

  final lines = (await file.readAsLines()).iterator;
  if (!lines.moveNext()) {
    print('Invalid data file, or maybe corrupted!');
    exit(1);
  }

  final config = Config.fromStr(lines.current);

  // Create array of size [ROWS] times [COLS].
  for (var i = 0; i < config.rows && lines.moveNext(); i++) {
    final iter = lines.current.split(RegExp(r'\s')).iterator;

    for (var j = 0; j < config.cols && iter.moveNext(); j++) {
      config.data[i][j] = .parse(iter.current);
    }
  }

  return config;
}
