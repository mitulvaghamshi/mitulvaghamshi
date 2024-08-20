import 'package:checkout_queue/linked_queue.dart';

/// Create a checkout line of items of type `T`.
class CheckoutLine<T> {
  CheckoutLine();

  final LinkedQueue<T> queue = LinkedQueue();

  int _queueWaitTime = 0;

  // Get current wait-time required by the queue (in seconds).
  // This is the total time to serve all the customer of this queue.
  int get waitTime => _queueWaitTime;

  // Increase the current wait-time of this queue by
  // the time required by the newly added customer.
  void addWaitTime(int timeToServe) => _queueWaitTime += timeToServe;

  // Dump queue data as formated string.
  @override
  String toString() => queue.toString();
}
