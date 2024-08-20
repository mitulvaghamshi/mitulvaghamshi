import 'package:test/test.dart';

import '../bin/checkout_queue.dart' as app;

void main() {
  test('Checkout Queue run test', () => app.main(['data.txt']));
}
