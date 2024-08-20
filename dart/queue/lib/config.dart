class Config {
  const Config({
    required this.expressLines,
    required this.regularLines,
    required this.expressItems,
    required this.totalCustomer,
  });

  factory Config.fromStr(String input) {
    final values = input.split(RegExp(r'\s'));
    return Config(
      expressLines: .parse(values[0]),
      regularLines: .parse(values[1]),
      expressItems: .parse(values[2]),
      totalCustomer: .parse(values[3]),
    );
  }

  final int expressLines;
  final int regularLines;
  final int expressItems;
  final int totalCustomer;
}

extension Utils on Config {
  // Total number of checkout lines.
  int get totalLines => expressLines + regularLines;
}
