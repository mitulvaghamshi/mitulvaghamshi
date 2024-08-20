import 'dart:io';

import 'package:checkout_queue/checkout_line.dart';
import 'package:checkout_queue/customer.dart';

void main(List<String> arguments) {
  final app = FakeMart();
  app.readData('bin/data.txt');
  app.partA();
  app.partB();
}

/// Implement check-out lines in a grocery store using a queue data-structure.
///
/// Attempt to place a customer in the best checkout line possible
/// based on the total number of customers and the number of items
/// in each cart being processed.
class FakeMart {
  late int expressLines;
  late int regularLines;
  late int expressItemLimit;
  late int numberOfCustomer;

  int timeToEmpty = 0;

  // Total number of checkout lines including regular and express.
  int get totalLines => expressLines + regularLines;

  // Store all the checkout lines, and it's required service time
  late final List<CheckoutLine<Customer>> checkoutLines;

  // Read customer and cart information for each customer from data file
  // and initialize required checkout lines.
  //
  // Calculate the optimal time required to serve a customer,
  // and place new customer to the check-out line with the cumulative
  // least amount of time in front of it (the shortest line).
  void readData(String path) {
    try {
      final lines = File.fromUri(Uri.file(path)).readAsLinesSync().iterator;

      if (lines.moveNext()) {
        final line = lines.current.split(' ');
        expressLines = int.parse(line[0]);
        regularLines = int.parse(line[1]);
        expressItemLimit = int.parse(line[2]);
        numberOfCustomer = int.parse(line[3]);
        // Create express and Regular checkout lines.
        checkoutLines = List.filled(totalLines, CheckoutLine());
      }

      // Find a checkout line with minimum waiting time
      // and add new customer to that line.
      var i = 0;
      while (i < numberOfCustomer && lines.moveNext()) {
        var customer = Customer(id: i + 1, cartSize: int.parse(lines.current));
        // If number of items is less than or equal to express limit,
        // allow customer to enter express line, otherwise check for Regular line.
        var line = customer.cartSize > expressItemLimit ? expressLines : 0;
        var minServeTime = checkoutLines[line].waitTime;
        for (var i = line + 1; i < totalLines; i++) {
          var time = checkoutLines[i].waitTime;
          if (time < minServeTime) {
            minServeTime = time;
            line = i;
          }
        }
        checkoutLines[line].queue.add(customer);
        checkoutLines[line].addWaitTime(customer.timeToServe);
        i++;
      }
    } on PathExistsException {
      print('[ERROR]: File does not exist.');
    }
  }

  // Optimum starting case for all the check-out lines in the store
  // and calculate the amount of time it will take for
  // the store to be empty of all customers.
  void partA() {
    timeToEmpty = 0;
    for (var i = 0; i < totalLines; i++) {
      final line = checkoutLines[i];
      if (line.waitTime > timeToEmpty) timeToEmpty = line.waitTime;
      print('Checkout [${i < expressLines ? 'Express' : 'Regular'}s '
          '#${i + 1} (Estimated time: ${line.waitTime} s)]: $line\n');
    }
    print('Time to clear store of all customers: ${timeToEmpty}s\n');
  }

  // Remove customers from each check-out by servicing the customers.
  // It will calculate the state of the checkout lines after every second,
  // and display state of lines every 30 seconds (simulated).
  //
  // Once the amount of time has passed required to serve the customer,
  // the customer is removed at the start of the Queue.
  void partB() {
    final buffer = StringBuffer('Time(s) | ');
    for (var i = 0; i < totalLines; i++) {
      buffer.write('Line ${i + 1} | ');
    }
    print(buffer);
    for (var i = 0; i < timeToEmpty; i++) {
      if (i > 0 && i % 30 == 0) print(queueStatus(i));
    }
    // Check for any leftover customer.
    if (timeToEmpty % 30 != 0) print(queueStatus(timeToEmpty));
  }

  // Check the state of all the checkout lines at particular time.
  // Lookup all the checkout lines and generate a report for given time.
  // Check and remove any customer from the queue if it's
  // done processing all the items (or, run out of time...).
  //
  // @param time when all checkout lines were analyzed.
  // @return String state report of all checkout lines.
  String queueStatus(int time) {
    final buffer = StringBuffer('\n$time');

    for (var line in checkoutLines) {
      if (!line.queue.isEmpty && line.queue.peek.isDone) {
        line.queue.remove();
      }
      buffer.write('| ${line.queue.size} ');
    }

    return buffer.toString();
  }
}
