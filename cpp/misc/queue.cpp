#include <chrono>
#include <cstdlib>
#include <cstring>
#include <iomanip>
#include <iostream>
#include <queue>
#include <random>
#include <string>

using namespace std;

/// A Document to be processed (printed).
class Document {
private:
  /// A unique counter definition to identify individual docs.
  /// Auto incremented on every new Document initialization.
  static int count;

public:
  /// A document number, the document data.
  int number;

  /// Every document assigned a random time (Seconds), the document
  /// will take to finish processing and printing.
  /// Document is removed from its queue once time over, (document printed).
  int timeLeft;

  /// @brief Default constructor definition.
  Document(void);

  /// Helper method definition to printout current state of the document.
  void print(void);
};

/// Initialize the program unique counter.
int Document::count = 0;

/// Initialize the new document instance.
/// Creates a new doc with unique id and,
/// random amount of time (1-5 Sec) to process this doc.
Document::Document(void) {
  // Increment unique counter.
  number = ++count;
  // Amount of time affects final result,
  // 1 - 8 Sec - Saves time.
  //  >= 9 Sec - Left docs unprocessed.
  timeLeft = rand() % 10 + 1;
};

/// Printout current status of the document,
/// Document number and, time remained to
/// finish processing and exit the queue.
void Document::print(void) {
  cout << "[Doc: " << setw(2) << to_string(number) << " ";
  cout << "(Time required: " << setw(2) << to_string(timeLeft) << " ms)]";
}

/// Helper procedure to handle all the underlying processing,
/// printing, and queue management logic.
/// Any changes made inside this function will be
/// automatically reflected to original data.
/// queue   - Reference to active queue.
/// chance  - Chances of adding new document.
/// time    - Current time status.
/// queueId - Which queue currrently processing.
void process(queue<Document> *queue, int chance, int time, int queueId) {
  // Get reference to the first document inside the active queue.
  Document *doc = &queue->front();

  // Display printing status, including active queue, time...
  cout << "[Time: " << setw(2) << to_string(time);
  cout << ": Queue " << queueId << "]";
  cout << ": Printing: ";
  doc->print(); // ...and the document being processed.

  // If remaining printing time of a document is over,
  // print its status and remove it from the queue.
  if (--doc->timeLeft == 0) {
    cout << setw(10) << " Dequeue: ";
    doc->print(); // Print and,
    queue->pop(); // Remove.
  }

  // Check the chances of arriving new document,
  // if the chances are about 15%, create and add a new document.
  if (chance <= 15) {
    Document newDoc = Document(); // Initialize new doc.
    cout << setw(10) << " Enqueue: ";
    newDoc.print();      // Print status and,
    queue->push(newDoc); // Add to the queue.
  }
  cout << endl; // Newline.
}

int main(void) {
  // This is a random number engine class that generates pseudo-random
  // numbers. It is the library implemention's selection of a generator that
  // provides at least acceptable engine behavior for relatively casual,
  // inexpert, and/or lightweight use.
  default_random_engine engine;

  // Produces random integer values `i` uniformly distributed on the closed
  // interval that is, distributed according to the discrete probability
  // function.
  uniform_int_distribution<int> intRandom(0, 100);

  // Initialize two queues for processing.
  auto queue1 = queue<Document>();
  auto queue2 = queue<Document>();

  // Add couple of `Document`s on each queue.
  queue1.push(Document());
  queue1.push(Document());
  queue2.push(Document());
  queue2.push(Document());

  // We will be running printing process for limited time.
  // Processing can be stopped by either timeout (60 Sec),
  // or both the queues is empty, no more docs ro process.
  int time = 0;
  bool flag = true;

  // Run printing process until timeout or no docts to process.
  while (flag == true && time++ < 60) {
    // Simulate 100 ms delay.
    __libcpp_thread_sleep_for(chrono::milliseconds(100));

    // Generate random chance (15%) which adds new document to any active queue.
    int chances = intRandom(engine);

    // Process first queue until its empty.
    if (queue1.size() > 0) {
      // Call to process with current queue state.
      // Param: Queue reference, adding chances, current time, queue number
      process(&queue1, chances, time, 1);
    } else {
      // Process second queue, otherwise.
      process(&queue2, chances, time, 2);
    }

    // Every second check whether all queues were empty or not.
    // The `true` value cauces end of program (all docs processed),
    // Timeout may close without processing all docs.
    flag = queue1.size() > 0 || queue2.size() > 0;
  }

  // Display final printing result.
  if (time < 60) {
    cout << endl;
    cout << "Finished processing all documents. ";
    cout << "Time saved: " << (60 - time) << " ms" << endl;
  } else {
    cout << endl;
    cout << "Processing Timeout! 60 Seconds." << endl;
    cout << "Unprocessed Documents: [";
    cout << "Queue 1: " << queue1.size() << " Docs, ";
    cout << "Queue 2: " << queue2.size() << " Docs]" << endl;
  }

  return 0;
}

// [Time:  1: Queue 1]: Printing: [Doc:  1 (Time required:  8 ms)] Enqueue: [Doc:  5 (Time required:  1 ms)]
// [Time:  2: Queue 1]: Printing: [Doc:  1 (Time required:  7 ms)]
// [Time:  3: Queue 1]: Printing: [Doc:  1 (Time required:  6 ms)]
// [Time:  4: Queue 1]: Printing: [Doc:  1 (Time required:  5 ms)]
// [Time:  5: Queue 1]: Printing: [Doc:  1 (Time required:  4 ms)]
// [Time:  6: Queue 1]: Printing: [Doc:  1 (Time required:  3 ms)]
// [Time:  7: Queue 1]: Printing: [Doc:  1 (Time required:  2 ms)]
// [Time:  8: Queue 1]: Printing: [Doc:  1 (Time required:  1 ms)] Dequeue: [Doc:  1 (Time required:  0 ms)]
// [Time:  9: Queue 1]: Printing: [Doc:  2 (Time required: 10 ms)]
// [Time: 10: Queue 1]: Printing: [Doc:  2 (Time required:  9 ms)]
// [Time: 11: Queue 1]: Printing: [Doc:  2 (Time required:  8 ms)]
// [Time: 12: Queue 1]: Printing: [Doc:  2 (Time required:  7 ms)] Enqueue: [Doc:  6 (Time required:  3 ms)]
// [Time: 13: Queue 1]: Printing: [Doc:  2 (Time required:  6 ms)]
// [Time: 14: Queue 1]: Printing: [Doc:  2 (Time required:  5 ms)]
// [Time: 15: Queue 1]: Printing: [Doc:  2 (Time required:  4 ms)] Enqueue: [Doc:  7 (Time required:  5 ms)]
// [Time: 16: Queue 1]: Printing: [Doc:  2 (Time required:  3 ms)]
// [Time: 17: Queue 1]: Printing: [Doc:  2 (Time required:  2 ms)]
// [Time: 18: Queue 1]: Printing: [Doc:  2 (Time required:  1 ms)] Dequeue: [Doc:  2 (Time required:  0 ms)]
// [Time: 19: Queue 1]: Printing: [Doc:  5 (Time required:  1 ms)] Dequeue: [Doc:  5 (Time required:  0 ms)] Enqueue: [Doc:  8 (Time required:  9 ms)]
// [Time: 20: Queue 1]: Printing: [Doc:  6 (Time required:  3 ms)]
// [Time: 21: Queue 1]: Printing: [Doc:  6 (Time required:  2 ms)]
// [Time: 22: Queue 1]: Printing: [Doc:  6 (Time required:  1 ms)] Dequeue: [Doc:  6 (Time required:  0 ms)]
// [Time: 23: Queue 1]: Printing: [Doc:  7 (Time required:  5 ms)]
// [Time: 24: Queue 1]: Printing: [Doc:  7 (Time required:  4 ms)]
// [Time: 25: Queue 1]: Printing: [Doc:  7 (Time required:  3 ms)]
// [Time: 26: Queue 1]: Printing: [Doc:  7 (Time required:  2 ms)] Enqueue: [Doc:  9 (Time required:  4 ms)]
// [Time: 27: Queue 1]: Printing: [Doc:  7 (Time required:  1 ms)] Dequeue: [Doc:  7 (Time required:  0 ms)]
// [Time: 28: Queue 1]: Printing: [Doc:  8 (Time required:  9 ms)]
// [Time: 29: Queue 1]: Printing: [Doc:  8 (Time required:  8 ms)]
// [Time: 30: Queue 1]: Printing: [Doc:  8 (Time required:  7 ms)]
// [Time: 31: Queue 1]: Printing: [Doc:  8 (Time required:  6 ms)]
// [Time: 32: Queue 1]: Printing: [Doc:  8 (Time required:  5 ms)] Enqueue: [Doc: 10 (Time required: 10 ms)]
// [Time: 33: Queue 1]: Printing: [Doc:  8 (Time required:  4 ms)]
// [Time: 34: Queue 1]: Printing: [Doc:  8 (Time required:  3 ms)]
// [Time: 35: Queue 1]: Printing: [Doc:  8 (Time required:  2 ms)]
// [Time: 36: Queue 1]: Printing: [Doc:  8 (Time required:  1 ms)] Dequeue: [Doc:  8 (Time required:  0 ms)]
// [Time: 37: Queue 1]: Printing: [Doc:  9 (Time required:  4 ms)]
// [Time: 38: Queue 1]: Printing: [Doc:  9 (Time required:  3 ms)]
// [Time: 39: Queue 1]: Printing: [Doc:  9 (Time required:  2 ms)]
// [Time: 40: Queue 1]: Printing: [Doc:  9 (Time required:  1 ms)] Dequeue: [Doc:  9 (Time required:  0 ms)]
// [Time: 41: Queue 1]: Printing: [Doc: 10 (Time required: 10 ms)] Enqueue: [Doc: 11 (Time required:  1 ms)]
// [Time: 42: Queue 1]: Printing: [Doc: 10 (Time required:  9 ms)]
// [Time: 43: Queue 1]: Printing: [Doc: 10 (Time required:  8 ms)] Enqueue: [Doc: 12 (Time required:  6 ms)]
// [Time: 44: Queue 1]: Printing: [Doc: 10 (Time required:  7 ms)]
// [Time: 45: Queue 1]: Printing: [Doc: 10 (Time required:  6 ms)]
// [Time: 46: Queue 1]: Printing: [Doc: 10 (Time required:  5 ms)] Enqueue: [Doc: 13 (Time required:  3 ms)]
// [Time: 47: Queue 1]: Printing: [Doc: 10 (Time required:  4 ms)]
// [Time: 48: Queue 1]: Printing: [Doc: 10 (Time required:  3 ms)]
// [Time: 49: Queue 1]: Printing: [Doc: 10 (Time required:  2 ms)] Enqueue: [Doc: 14 (Time required:  3 ms)]
// [Time: 50: Queue 1]: Printing: [Doc: 10 (Time required:  1 ms)] Dequeue: [Doc: 10 (Time required:  0 ms)]
// [Time: 51: Queue 1]: Printing: [Doc: 11 (Time required:  1 ms)] Dequeue: [Doc: 11 (Time required:  0 ms)] Enqueue: [Doc: 15 (Time required:  8 ms)]
// [Time: 52: Queue 1]: Printing: [Doc: 12 (Time required:  6 ms)]
// [Time: 53: Queue 1]: Printing: [Doc: 12 (Time required:  5 ms)]
// [Time: 54: Queue 1]: Printing: [Doc: 12 (Time required:  4 ms)] Enqueue: [Doc: 16 (Time required:  4 ms)]
// [Time: 55: Queue 1]: Printing: [Doc: 12 (Time required:  3 ms)] Enqueue: [Doc: 17 (Time required:  8 ms)]
// [Time: 56: Queue 1]: Printing: [Doc: 12 (Time required:  2 ms)]
// [Time: 57: Queue 1]: Printing: [Doc: 12 (Time required:  1 ms)] Dequeue: [Doc: 12 (Time required:  0 ms)]
// [Time: 58: Queue 1]: Printing: [Doc: 13 (Time required:  3 ms)]
// [Time: 59: Queue 1]: Printing: [Doc: 13 (Time required:  2 ms)]
// [Time: 60: Queue 1]: Printing: [Doc: 13 (Time required:  1 ms)] Dequeue: [Doc: 13 (Time required:  0 ms)]

// Processing Timeout! 60 Seconds.
// Unprocessed Documents: [Queue 1: 4 Docs, Queue 2: 2 Docs]
