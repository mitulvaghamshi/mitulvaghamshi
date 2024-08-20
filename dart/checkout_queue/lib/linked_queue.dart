class Node<E> {
  Node(this.value, {this.next});

  final E value;
  Node<E>? next;
}

class LinkedQueue<E> {
  Node<E>? _front;
  Node<E>? _rear;

  int _count = 0;

  // Add an item to the Queue.
  // @param value item to be added to the Queue.
  void add(E value) {
    if (_rear == null) {
      _rear = Node(value);
      _front = _rear;
    } else {
      _rear!.next = Node(value);
      _rear = _rear!.next;
    }
    _count++;
  }

  // Remove an item from the Queue.
  // @throws Exception if queue is empty.
  // @return E the item at the front of the Queue.
  E remove() {
    if (isEmpty) throw '[ERROR]: Cannot dequeue, queue is empty.';

    var value = _front!.value;
    _front = _front!.next;
    if (_front == null) _rear = null;
    _count--;

    return value;
  }

  // Check is queue is empty.
  bool get isEmpty => _front == null;

  // Lookup front of the Queue without removing it.
  E get peek => _front!.value;

  // Get number of elements in the Queue.
  int get size => _count;

  // Dump queue data as formated string.
  @override
  String toString() {
    final buffer = StringBuffer('  | No | Item | Time |\n'
        '  | -- | ---- | ---- |\n');
    var current = _front;
    while (current != null) {
      buffer.write(current.value);
      current = current.next;
    }
    return buffer.toString();
  }
}
