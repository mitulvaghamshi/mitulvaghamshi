import 'package:elevation_peak/config.dart';
import 'package:elevation_peak/peak.dart';

typedef Pair<T> = ({T a, T b});

/// Working with single and multidimensional arrays.
///
/// Solve 4 problems as:
/// 1) Find the lowest elevation value and number of times it occurs in dataset.
/// 2) Find all the local peaks matching given criteria. (Incomplete).
/// 3) Find the two closest peaks in the dataset.
/// 4) Find the most common elevation and number of times it occurs.
class ElevationPeak {
  const ElevationPeak({required this.config});

  final Config config;
}

/// Find the lowest elevation and number of time it occurs in the dataset.
///
/// @param data two-dimensional array to find minimum elevation.
/// @return Int array with two elements of minimum elevation and its count.
extension Problem1 on ElevationPeak {
  Pair<int> findLowestElevation(List<List<int>> data) {
    var minElevation = data[0][0];
    var minElevationCount = 0;

    for (var row in data) {
      for (var item in row) {
        // Reset counter if new minimum found, increase otherwise.
        if (item < minElevation) {
          minElevation = item;
          minElevationCount = 0;
        }

        if (item == minElevation) minElevationCount++;
      }
    }

    // Lowest elevation: 20119, and it occurs: 4 times.
    return (a: minElevation, b: minElevationCount);
  }
}

/// Find all the local peaks that is grater then or equal to
/// value [Config.minPeak], and that is not contained
/// in the given exclusion radius [Config.exRadius].
///
/// @param data two-dimensional array containing the data.
/// @return an array of [Peak]s, found in the dataset.
/// [Peak] is a class containing elevation value and its location.
///
/// This implementation Incomplete / Inaccurate.
extension Problem2 on ElevationPeak {
  List<Peak> findLocalPeaks(List<List<int>> data) {
    final list = <Peak>[];

    // A fix sized block in the dataset to look for peaks.
    final windowSize = config.exRadius * 2 + 1;

    for (var i = 0; i < config.rows - windowSize; i++) {
      for (var j = 0; j < config.cols - windowSize; j++) {
        final valueAt = data[i][j];

        // Find the max value within the block,
        // i.e. `block = radius + 1 + radius`.
        var peak = Peak(i: i, j: j, v: valueAt);

        for (var m = i; m < windowSize - 1 + i; m++) {
          for (var n = j; n < windowSize - 1 + j; n++) {
            if (data[m][n] > peak.v) {
              peak = Peak(i: m, j: n, v: data[m][n]);
            }
          }
        }

        // Check if the above max value is within the radius range,
        // and value is greater then or equal to minimum peak.
        if (peak.v >= config.minPeak &&
            peak.v == data[i + config.exRadius][j + config.exRadius]) {
          list.add(peak);
        }
      }
    }

    return list;
  }
}

/// Find the two closest peaks, from the dataset.
///
/// @param peaks an array of local peaks found in problem #2.
/// @return an array of peaks, containing two closest local peaks.
extension Problem3 on ElevationPeak {
  Pair<Peak> findClosestPeaks(List<Peak> peaks) {
    late Pair<Peak> pair;

    // Find the distance between two peaks.
    var minDistance = peaks[0].distanceTo(peaks[1]);

    // Find the minimim distance by comparing every single pair of Peak
    // to the next Peak.
    for (var i = 2; i < peaks.length - 1; i++) {
      var distance = peaks[i].distanceTo(peaks[i + 1]);

      if (distance < minDistance) {
        minDistance = distance;
        pair = (a: peaks[i], b: peaks[i + 1]);
      }
    }

    return pair;
  }
}

/// Most common height (elevation) and number of times it occurs in the dataset.
/// @param data two-dimensional array containing the dataset.
/// @return Pair with most common height and its count.
extension Problem4 on ElevationPeak {
  Pair<int> findMostCommonHeight(List<List<int>> data) {
    // Hold maximum possible value as an index from the dataset.
    final elevationCount = <int, int>{}; // 112000;

    // Use dataset value as an index to the array and find its count.
    for (var row in data) {
      for (var item in row) {
        elevationCount.update(item, (value) => value + 1, ifAbsent: () => 1);
      }
    }

    var mostCommonHeight = (a: -1, b: -1);

    // Find the maximum count (value) and its assosiated index (elevation).
    for (var item in elevationCount.entries) {
      if (mostCommonHeight.b < item.value) {
        mostCommonHeight = (a: item.key, b: item.value);
      }
    }

    return mostCommonHeight;
  }
}
