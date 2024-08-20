class StoreConfig {
  StoreConfig({
    required this.expressLines,
    required this.regularLines,
    required this.expressItems,
    required this.totalCustomer,
    required this.timeToEmpty,
  });

  factory StoreConfig.from(String input) {
    final values = input.split(RegExp(r'\s'));
    return StoreConfig(
      expressLines: int.parse(values[0]),
      regularLines: int.parse(values[1]),
      expressItems: int.parse(values[2]),
      totalCustomer: int.parse(values[3]),
      timeToEmpty: 0,
    );
  }

  final int expressLines;
  final int regularLines;
  final int expressItems;
  final int totalCustomer;

  int timeToEmpty;

  // Total number of checkout lines.
  int get totalLines => expressLines + regularLines;
}
