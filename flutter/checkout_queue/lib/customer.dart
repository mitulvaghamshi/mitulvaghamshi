/// A customer with total number of items in cart and an unique identifier.
class Customer {
  Customer({required this.id, required this.cartSize});

  final int id;
  final int cartSize;

  // Calculate and store time required to serve the customer.
  late int _timeToServe = 45 + 5 * cartSize;

  // Time required to serve the customer.
  int get timeToServe => _timeToServe;

  // Check weather all cart items has been processed or not.
  // On every request, reduce 1 second from total remaining time
  // and check if the customer used all it's time.
  bool get isDone => --_timeToServe == 0;

  // Dump customer data as formated string.
  @override
  String toString() => '[Customer $id: Items: $cartSize, Time: $timeToServe]';
}
