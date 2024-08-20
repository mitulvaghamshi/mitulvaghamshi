#include <iostream>
#include <new>
#include <ostream>

using namespace std;

struct Bucket {
  const static size_t data_size{4096};
  char data[data_size];
};

struct Heap {
  void *allocate(size_t bytes) {
    if (bytes > Bucket::data_size)
      throw bad_alloc{};
    for (size_t i{}; i < n_heap_buckets; i++)
      if (!bucket_used[i]) {
        bucket_used[i] = true;
        return buckets[i].data;
      }
    throw bad_alloc{};
  }

  void free(void *p) {
    for (size_t i{}; i < n_heap_buckets; i++) {
      if (buckets[i].data == p) {
        bucket_used[i] = false;
        return;
      }
    }
  }

  static const size_t n_heap_buckets{10};
  Bucket buckets[n_heap_buckets]{};
  bool bucket_used[n_heap_buckets]{};
};

Heap heap;

void *operator new(size_t n_bytes) { return heap.allocate(n_bytes); }
void operator delete(void *p) noexcept { return heap.free(p); }

int main(void) {
  cout << "Buckets: " << heap.buckets << endl;

  auto breakfast = new unsigned int{0xC0FFEE};
  auto dinner = new unsigned int{0xDEADBEEF};

  cout << "Breakfast: " << breakfast << *breakfast << endl;
  cout << "Dinner: " << dinner << *dinner << endl;
  delete breakfast;
  delete dinner;

  try {
    while (true) {
      new char;
      cout << "Allocated a char." << endl;
    }
  } catch (const bad_alloc &) {
    cerr << "bad_alloc caught." << endl;
  }

  return 0;
}

struct Point {
  Point() : x{}, y{}, z{} {
    cout << "Point at " << this << " constructed." << endl;
  }
  ~Point() { cout << "Point at " << this << " destructed." << endl; }

  double x, y, z;
};

int main1(void) {
  const auto point_size = sizeof(Point);
  char data[3 * point_size];
  cout << "Data starts at " << &data << endl;

  auto point1 = new (&data[0 * point_size]) Point{};
  auto point2 = new (&data[1 * point_size]) Point{};
  auto point3 = new (&data[2 * point_size]) Point{};

  point1->~Point();
  point2->~Point();
  point3->~Point();

  return 0;
}
