import 'package:checkout_queue/checkout_line.dart';
import 'package:checkout_queue/config.dart';
import 'package:checkout_queue/customer.dart';
import 'package:checkout_queue/linked_queue.dart';

/// Implement check-out lines in a grocery store using a queue data-structure.
///
/// Attempt to place a customer in the best checkout line possible
/// based on the total number of customers and the number of items
/// in each cart being processed.
class Store {
  Store({required this.config});

  final Config config;

  int timeToEmpty = 0;

  late final List<CheckoutLine<Customer>> _checkoutLines =
      List.generate(config.totalLines, (_) => CheckoutLine());
}

extension Utils on Store {
  // Read customer and cart information for each customer from data file
  // and initialize required checkout lines.
  //
  // Calculate the optimal time required to serve a customer,
  // and place new customer to the check-out line with the cumulative
  // least amount of time in front of it (the shortest line).
  void populateStore(Iterator<String> entries) {
    // Find a checkout line with minimum waiting time
    // and add new customer to that line.
    // If number of items is less than or equal to express limit,
    // allow customer to enter express line, otherwise check for Regular line.
    var i = 0;
    while (i < config.totalCustomer && entries.moveNext()) {
      var customer = Customer(id: i + 1, cartSize: int.parse(entries.current));
      var line = customer.cartSize > config.expressItems //
          ? config.expressLines
          : 0;
      var minServeTime = _checkoutLines[line].waitTime;
      for (var j = line + 1; j < config.totalLines; j++) {
        var time = _checkoutLines[j].waitTime;
        if (time < minServeTime) {
          minServeTime = time;
          line = j;
        }
      }
      _checkoutLines[line].queue.add(customer);
      _checkoutLines[line].addWaitTime(customer.timeToServe);
      i++;
    }
  }

  // Optimum starting case for all the check-out lines in the store
  // and calculate the amount of time it will take for
  // the store to be empty of all customers.
  void printQueueInfo() {
    timeToEmpty = 0;
    for (var i = 0; i < config.totalLines; i++) {
      final line = _checkoutLines[i];
      if (line.waitTime > timeToEmpty) timeToEmpty = line.waitTime;
      print(
        'Checkout #${i + 1} '
        '[${i < config.expressLines ? 'Express' : 'Regular'} '
        '(time: ${line.waitTime}s)]\n$line',
      );
    }
    print('Total time to serve all customers in store: ${timeToEmpty}s\n');
  }

  // Remove customers from each check-out by servicing the customers.
  // It will calculate the state of the checkout lines after every second,
  // and display state of lines every 30 seconds (simulated).
  //
  // Once the amount of time has passed required to serve the customer,
  // the customer is removed at the start of the Queue.
  void serveCustomers() {
    final buffer = StringBuffer('| Time | ');
    for (var i = 0; i < config.totalLines; i++) {
      buffer.write('L#${i + 1} | '.padLeft(7));
    }
    buffer.writeln(
      '\n| ---- | ---- | ---- | ---- | ---- '
      '| ---- | ---- | ---- | ---- | ---- | ---- |',
    );
    // Each iteration equal to 1 second.
    for (var i = 0; i < timeToEmpty; i++) {
      var status = _queueStatus(i);
      if (i > 0 && i % 30 == 0) buffer.writeln(status);
    }
    // Check for any leftover customer.
    if (timeToEmpty % 30 != 0) {
      buffer.writeln(_queueStatus(timeToEmpty));
    }
    print(buffer);
  }
}

extension on Store {
  // Check the state of all the checkout lines at particular time.
  // Lookup all the checkout lines and generate a report for given time.
  // Check and remove any customer from the queue if it's
  // done processing all the items (or, run out of time...).
  //
  // @param time when all checkout lines were analyzed.
  // @return String state report of all checkout lines.
  String _queueStatus(int time) {
    final buffer = StringBuffer('| ${time.toString().padLeft(4)} |');
    for (var line in _checkoutLines) {
      if (line.queue.isNotEmpty && line.queue.peek.isFinished) {
        line.queue.remove();
      }
      buffer.write('${line.queue.size.toString().padLeft(5)} |');
    }
    return buffer.toString();
  }
}
