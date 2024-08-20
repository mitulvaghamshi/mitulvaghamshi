class Config {
  const Config({
    required this.rows,
    required this.cols,
    required this.minPeak,
    required this.exRadius,
    required this.data,
  });

  factory Config.fromStr(String input) {
    final line = input.split(RegExp(r'\s'));
    final rows = int.parse(line[0]);
    final cols = int.parse(line[1]);
    return Config(
      rows: rows, // Number of rows in dataset.
      cols: cols, // Number of columns in dataset.
      minPeak: .parse(line[2]), // Minimum peak value.
      exRadius: .parse(line[3]), // The exclusion radius.
      data: .generate(rows, (_) => .generate(cols, (_) => 0)),
    );
  }

  final int rows;
  final int cols;
  final int minPeak;
  final int exRadius;
  final List<List<int>> data;
}
