#include <iostream>
#include <string>

using namespace std;

struct Person {
  Person(string name) : name{name} { cout << "ALIVE: " << name << endl; };
  ~Person() { cout << "DEAD:  " << name << endl; };

  void display() { cout << "NAME:  " << name << endl; }

private:
  string name;
};

static Person p1{"Static Bob"};
thread_local Person p2{"Threded Rob"};

int main(void) {
  auto *p3 = new Person("Dynamic John");
  {
    auto p4 = Person{"Local Anna"};
    p2.display();
  }
  delete p3;
  return 0;
}

// ALIVE: Static Bob.
// ALIVE: Dynamic John.
// ALIVE: Local Anna.
// ALIVE: Threded Rob.
// NAME:  Threded Rob.
// DEAD:  Local Anna.
// DEAD:  Dynamic John.
// DEAD:  Threded Rob.
// DEAD:  Static Bob.
