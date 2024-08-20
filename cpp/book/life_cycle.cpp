#include <cstdio>
#include <iostream>

struct Person {
    std::string name;

    Person(std::string name) : name{name} {
        printf("ALIVE: %s.\n", name.c_str());
    };

    ~Person() { printf("DEAD:  %s.\n", name.c_str()); };

    void display() { printf("NAME:  %s.\n", name.c_str()); }
};

static Person p1{"Static Bob"};

thread_local Person p2{"Threded Rob"};

int main(void) {
    auto *p3 = new Person("Dynamic John");

    {
        Person p4 = Person{"Local Anna"};
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
