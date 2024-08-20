import 'dart:io';

const path = 'data/data.txt';

class DataConfig {
  var rows = 0;
  var cols = 0;

  var minPeak = 0;
  var exRadius = 0;

  late final List<List<int>> data;

  DataConfig() {
    read(path);
  }

  void read(String path) {
    try {
      final input = File.fromUri(Uri.file(path)).readAsLinesSync().iterator;
      if (input.moveNext()) {
        final line = input.current.split(RegExp(r'\s'));
        rows = int.parse(line[0]); // Number of rows in dataset.
        cols = int.parse(line[1]); // Number of columns in dataset.
        minPeak = int.parse(line[2]); // Minimum peak value.
        exRadius = int.parse(line[3]); // The exclusion radius.
      }
      // Create array of size [ROWS] * [COLS].
      data = List.generate(rows, (_) => List.generate(cols, (_) => 0));
      for (var i = 0; i < rows && input.moveNext(); i++) {
        final elements = input.current.split(RegExp(r'\s')).iterator;
        for (var j = 0; j < cols && elements.moveNext(); j++) {
          data[i][j] = int.parse(elements.current);
        }
      }
    } on FileSystemException {
      print('File does not exists.');
    }
  }
}
