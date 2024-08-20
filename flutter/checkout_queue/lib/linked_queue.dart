class Node<E> {
  Node({required this.value, this.next});

  final E value;
  Node<E>? next;
}

class LinkedQueue<E> {
  LinkedQueue();

  Node<E>? front;
  Node<E>? rear;

  int count = 0;

  // Add an item to the Queue.
  // @param value item to be added to the Queue.
  void add(E value) {
    if (rear == null) {
      rear = Node(value: value);
      front = rear;
    } else {
      rear!.next = Node(value: value);
      rear = rear!.next;
    }
    count++;
  }

  // Remove an item from the Queue.
  // @throws Exception if queue is empty.
  // @return E the item at the front of the Queue.
  E remove() {
    if (isEmpty) throw "[ERROR]: Cannot dequeue, queue is empty.";

    var value = front!.value;
    front = front!.next;
    if (front == null) rear = null;
    count--;

    return value;
  }

  // Check is queue is empty.
  bool get isEmpty => front == null;

  // Lookup front of the Queue without removing it.
  E get peek => front!.value;

  // Get number of elements in the Queue.
  int get size => count;

  // Dump queue data as formated string.
  @override
  String toString() {
    final buffer = StringBuffer();
    var current = front;
    buffer.write('[');
    while (current != null) {
      buffer.write('\n  ');
      buffer.write(current.value);
      current = current.next;
    }
    buffer.write('\n]\n');

    return buffer.toString();
  }
}
