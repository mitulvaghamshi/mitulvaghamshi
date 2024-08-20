#include <fstream>
#include <sstream>
#include <vector>

using namespace std;

#ifndef _EMPLOYEE_H
#define _EMPLOYEE_H

#include <iomanip>
#include <iostream>

struct Employee {
    std::string name;
    int number;
    double rate;
    double hours;
    double gross;

    Employee();
    Employee(std::string, int, double, double);

    void print();
};

#endif

#ifndef _EMPLOYEE_IMPLEMENTATION
#define _EMPLOYEE_IMPLEMENTATION

Employee::Employee() {}

Employee::Employee(string name, int number, double rate, double hours)
    : name{name}, number{number}, rate{rate}, hours{hours} {
    gross = hours > 40.0 ? (rate * 40.0) + (hours - 40.0) * rate * 1.5
                         : hours * rate;
}

void Employee::print() {
    cout << setfill(' ') << "| " << left << setw(15) << name.c_str() << " | "
         << left << setw(10) << setprecision(4) << number << " | " << left
         << setw(10) << setprecision(4) << rate << " | " << left << showpoint
         << setw(10) << setprecision(4) << hours << " | " << right << setw(9)
         << setprecision(6) << gross << " | " << endl;
}

#endif

struct Program {
    Program();
    void read();
    void sort(char *);
    bool cmp(Employee, Employee);
    void menu();
    void print();

  private:
    int count;
    int choice;

    Employee items[100];

    vector<string> split(const string &s, char delim) {
        string item;
        stringstream ss(s);
        vector<string> result;
        while (getline(ss, item, delim)) {
            result.push_back(item);
        }
        return result;
    }
};

Program::Program() : count{0} {}

void Program::read(char *file) {
    ifstream in(file);
    if (in.is_open()) {
        while (!in.eof()) {
            string line;
            getline(in, line);
            if (line.length() > 0) {
                vector<string> words = split(line, ',');
                items[count++] = Employee(words[0], stoi(words[1]),
                                          stod(words[2]), stod(words[3]));
            }
        }
        in.close();
    }
}

// Algorithm: Selection Sort
// Source: [GeeksForGeeks] https://bit.ly/35XMw1v
//
// Description:
// This sorting algorithm is an in-place comparison-based algorithm in
// which the list is divided into two parts, the sorted part at the left end and
// the unsorted part at the right end. Initially, the sorted part is empty and
// the unsorted part is the entire list.
//
// Working:
// The smallest element is selected from the unsorted array and swapped
// with the leftmost element, and that element becomes a part of the sorted
// array. This process continues moving unsorted array boundary by one element
// to the right.
//
// Limitation:
// This algorithm is not suitable for large data sets as its average
// and worst case complexities are of $Ο(n2)$, where n is the number of items.
// Source: [Tutorialspoint] https://bit.ly/3j13YG7
void Program::sort() {
    // Selection Sort.
    for (int i = 0; i < count - 1; i++) {
        int min = i;
        for (int j = i + 1; j < count; j++) {
            if (cmp(items[j], items[min])) {
                min = j;
            }
        }
        if (min != i) {
            Employee e = items[min];
            items[min] = items[i];
            items[i] = e;
        }
    }
    print();
}

bool Program::cmp(Employee e1, Employee e2) {
    switch (choice) {
    case 1:
        return e1.name < e2.name;
    case 2:
        return e1.number < e2.number;
    case 3:
        return e1.rate > e2.rate;
    case 4:
        return e1.hours > e2.hours;
    case 5:
        return e1.gross > e2.gross;
    default:
        return false;
    }
}

void Program::menu() {
    cout << "1. Sort by Name" << endl;
    cout << "2. Sort by Number" << endl;
    cout << "3. Sort by Pay Rate" << endl;
    cout << "4. Sort by Hours" << endl;
    cout << "5. Sort by Gross Pay" << endl;
    cout << endl << "6. Exit" << endl;

    bool isValid = false;
    while (!isValid) {
        cout << "Enter your choice: ";
        cin >> choice;
        if (cin.fail()) {
            cout << "[ERROR]: Invalid Input..., Bye! Bye!" << endl;
            choice = 6;
            isValid = true;
        } else if (!(isValid = choice > 0 && choice < 7)) {
            cout << "Invalid choice, choose between (1-6)" << endl;
        }
    }
    if (choice != 6) {
        sort();
    }
}

void Program::print() {
    system("clear");

    cout << setfill(' ') << left << "| " << setw(15) << "Employee"
         << " | " << setw(10) << "Number"
         << " | " << setw(10) << "Rate"
         << " | " << setw(10) << "Hours"
         << " | " << setw(9) << "Gross Pay"
         << " | " << endl;

    cout << setfill('-') << "| " << setw(15) << "-"
         << " | " << setw(10) << "-"
         << " | " << setw(10) << "-"
         << " | " << setw(10) << "-"
         << " | " << setw(9) << "-"
         << " | " << endl;

    for (int i = 0; i < count; i++) {
        items[i].print();
    }
    cout << endl;
    menu();
}

int main(int argc, char **argv) {
    if (argc != 2) {
        return 1;
    }
    auto p = Program();
    p.read(argv[1]);
    p.menu();
    return 0;
}

// OUTPUT:
//
// $ g++ main.cpp employee.cpp
//
// 1. Sort by Name
// 2. Sort by Number
// 3. Sort by Pay Rate
// 4. Sort by Hours
// 5. Sort by Gross Pay
//
// 6. Exit
// Enter your choice: 1
//
// | Employee        | Number     | Rate       | Hours      | Gross Pay |
// | --------------- | ---------- | ---------- | ---------- | --------- |
// | Arthur Curry    | 565603     | 21.09      | 23.75      |   500.887 |
// | Barry Allan     | 342562     | 25.12      | 25.50      |   640.560 |
// | Bruce Wayne     | 123456     | 25.88      | 35.50      |   918.740 |
// | Carter Hall     | 657123     | 19.34      | 42.75      |   853.378 |
// | Clark Kent      | 232344     | 25.88      | 38.75      |   1002.85 |
// | Diana Prince    | 657659     | 27.62      | 30.25      |   835.505 |
// | Dinah Lance     | 342988     | 18.99      | 34.50      |   655.155 |
// | Hal Jordan      | 989431     | 23.14      | 44.25      |   1073.12 |
// | John Jones      | 812984     | 18.99      | 32.75      |   621.922 |
// | Oliver Queen    | 340236     | 17.45      | 41.25      |   730.719 |
// | Ray Palmer      | 120985     | 24.75      | 40.00      |   990.000 |
// | Ronald Raymond  | 239824     | 16.43      | 35.00      |   575.050 |
// | Shayera Hol     | 761742     | 16.73      | 38.50      |   644.105 |
