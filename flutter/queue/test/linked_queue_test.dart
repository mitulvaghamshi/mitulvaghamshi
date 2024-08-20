import 'package:queue/linked_queue.dart';
import 'package:test/test.dart';

void main() {
  final queue = LinkedQueue<int>();

  test('Linked Queue test', () {
    expect(queue.isEmpty, true);

    queue.add(10);
    queue.add(20);

    expect(queue.size, 2);
    expect(queue.peek, 10);
    expect(queue.remove(), 10);
    expect(queue.size, 1);
    expect(queue.peek, 20);
    expect(queue.isEmpty, false);
    expect(queue.remove(), 20);
    expect(queue.isEmpty, true);
  });
}
