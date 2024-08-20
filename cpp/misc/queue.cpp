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
    Document();

    /// Helper method definition to printout current state of the
    /// document.
    void print();
};

/// Initialize the program unique counter.
int Document::count = 0;

/// Initialize the new document instance.
/// Creates a new doc with unique id and,
/// random amount of time (1-5 Sec) to process this doc.
Document::Document() {
    // Increment unique counter.
    number = ++count;
    // Amount of time affects final result,
    // 1 - 8 Sec - Saves time.
    // >= 9 Sec  - Left docs unprocessed.
    timeLeft = rand() % 10 + 1;
};

/// Printout current status of the document,
/// Document number and, time remained to
/// finish processing and exit the queue.
void Document::print() {
    cout << "[Document: " << setw(2) << to_string(number)
         << " (Time remaining: " << setw(2) << to_string(timeLeft) << " Sec)]";
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
    cout << "[Time: " << setw(2) << to_string(time) << ": PrintQueue "
         << queueId << "]: Processing: ";
    // ...and the document being processed.
    doc->print();

    // If remaining printing time of a document is over,
    // print its status and remove it from the queue.
    if (--doc->timeLeft == 0) {
        cout << setw(12) << " Removing: ";
        doc->print(); // Print and,
        queue->pop(); // Remove.
    }

    // Check the chances of arriving new document,
    // if the chances are about 15%, create and add a new document.
    if (chance <= 15) {
        Document newDoc = Document(); // Initialize new doc.
        cout << setw(12) << " Addding: ";
        newDoc.print();      // Print status and,
        queue->push(newDoc); // Add to the queue.
    }
    cout << endl; // New line.
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
    queue<Document> queue1 = queue<Document>();
    queue<Document> queue2 = queue<Document>();

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
        // Simulate 1 Sec delay.
        // __libcpp_thread_sleep_for(chrono::seconds(1));

        // Generate random chance (15%) which adds new document to
        // any active queue.
        int chances = intRandom(engine);
        // Process first queue until its empty.
        if (queue1.size() > 0) {
            // Call to process with current queue state.
            // Param: Queue reference, adding chances, current time, queue
            // number
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
        cout << "Finished processing all documents. Time saved: " << (60 - time)
             << " Seconds." << endl;
    } else {
        cout << "Processing timed out. Unprocessed documents: [Queue 1: "
             << queue1.size() << " Docs, Queue 2: " << queue2.size()
             << " Docs] " << endl;
    }
    return 0;
}
