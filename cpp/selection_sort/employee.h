#ifndef _EMPLOYEE_H
#define _EMPLOYEE_H

#include <iomanip>
#include <iostream>

struct Employee
{
  std::string name;
  int number;
  double rate;
  double hours;
  double gross;
  Employee();
  Employee(std::string, int, double, double);
  void print();
};

#endif // _EMPLOYEE_H

#ifndef _EMPLOYEE_IMPLEMENTATION
#define _EMPLOYEE_IMPLEMENTATION

using namespace std;

Employee::Employee() {}

Employee::Employee(string name, int number, double rate, double hours)
    : name{name}, number{number}, rate{rate}, hours{hours}
{
  gross =
      hours > 40.0 ? (rate * 40.0) + (hours - 40.0) * rate * 1.5 : hours * rate;
}

void Employee::print()
{
  cout << setfill(' ') << "| " << left << setw(15) << name.c_str() << " | "
       << left << setw(10) << setprecision(4) << number << " | " << left
       << setw(10) << setprecision(4) << rate << " | " << left << showpoint
       << setw(10) << setprecision(4) << hours << " | " << right << setw(9)
       << setprecision(6) << gross << " | " << endl;
}

#endif // _EMPLOYEE_IMPLEMENTATION
