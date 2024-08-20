class _Node<T> {
  _Node(this.value, {this.next});

  final T value;
  _Node<T>? next;
}

class LinkedQueue<E> {
  _Node<E>? _front;
  _Node<E>? _rear;

  int _count = 0;

  @override
  String toString() {
    final buffer = StringBuffer(
      '  | No | Item | Time |\n'
      '  | -- | ---- | ---- |\n',
    );
    var node = _front;
    while (node != null) {
      buffer.write(node.value);
      node = node.next;
    }
    return buffer.toString();
  }
}

extension Utils<E> on LinkedQueue<E> {
  // Check is queue is empty.
  bool get isEmpty => _front == null;

  // Check is queue is empty.
  bool get isNotEmpty => !isEmpty;

  // Lookup front of the Queue without removing it.
  E get peek => _front!.value;

  // Get number of elements in the Queue.
  int get size => _count;
}

extension Ops<E> on LinkedQueue<E> {
  // Add an item to the Queue.
  // @param value item to be added to the Queue.
  void add(E value) {
    if (_rear == null) {
      _rear = _Node(value);
      _front = _rear;
    } else {
      _rear!.next = _Node(value);
      _rear = _rear!.next;
    }
    _count++;
  }

  // Remove an item from the Queue.
  // @throws Exception if queue is empty.
  // @return E the item at the front of the Queue.
  E remove() {
    if (isEmpty) {
      throw '[ERROR]: Cannot dequeue, queue is empty.';
    }
    var value = _front!.value;
    _front = _front!.next;
    if (_front == null) _rear = null;
    _count--;
    return value;
  }
}
