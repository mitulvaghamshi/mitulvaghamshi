import 'package:elevation_peak/data_config.dart';
import 'package:test/test.dart';

import '../bin/elevation_peak.dart';

void main() {
  test('Test run Elevation Peak.', () {
    ElevationPeakTest(config: DataConfig()).run();
  });
}
