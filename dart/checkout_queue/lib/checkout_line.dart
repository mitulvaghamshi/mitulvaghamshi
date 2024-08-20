import 'package:checkout_queue/linked_queue.dart';

/// Create a checkout line of items of type T.
class CheckoutLine<T> {
  final queue = LinkedQueue<T>();

  int _waitTime = 0;

  @override
  String toString() => queue.toString();
}

extension Utils<T> on CheckoutLine<T> {
  // Get current wait-time required by the queue (in seconds).
  // This is the total time to serve all the customer of this queue.
  int get waitTime => _waitTime;

  // Increase the current wait-time of this queue by
  // the time required by the newly added customer.
  void addWaitTime(int timeToServe) => _waitTime += timeToServe;
}
