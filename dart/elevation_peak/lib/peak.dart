import 'dart:math' as math;

/// An elevation with value and location.
/// Initialize new Peak(elevation) object.
///
/// @param i - Index of the Row in dataset.
/// @param j - Index of the Column in dataset.
/// @param v - Peak (elevation) value at above Row and Column index.
class Peak {
  const Peak({required this.i, required this.j, required this.v});

  final int i;
  final int j;
  final int v;

  /// Compare the two elevation by its location and find the distance.
  /// Formula: Distance^2 = E1(Row) - E2(Row)^2 + E1(Column) - E2(Column)^2
  /// where, E1 = first peak (initial), E2 = second peak (other).
  ///
  /// @param other accepts a Peak object to compare with.
  /// @return double distance value between two peaks.
  double distanceTo(Peak other) =>
      math.sqrt(math.pow(i - other.i, 2.0) + math.pow(j - other.j, 2.0));

  @override
  String toString() => '[Row: $i, Column: $j, Elevation: $v]';
}
