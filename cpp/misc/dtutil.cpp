#include <iostream>

using namespace std;

struct Date { int y, m, d; };

int leap(int y) {
  return (y % 400 == 0 || (y % 4 == 0 && y % 100 != 0));
}

int dom(int y, int m) {
  return (m < 8) ? (m % 2 != 0) ? 31 : (m == 2) ? leap(y) ? 29 : 28 : 30 : (m % 2 == 0) ? 31 : 30;
}

int doy(Date dt) {
  int a = 0;
  for (int i = 1; i < dt.m; i++) a += dom(dt.y, i);
  return a + dt.d;
}

int dbtw(Date d1, Date d2) {
  int a = 0;
  for (int i = d1.y; i < d2.y; i++) a += leap(i) ? 366 : 365;
  return doy(d2) + a - doy(d1);
}

int main(void) {
  Date since, to;
  cout << "Enter first date (y m d): ";
  cin >> since.y >> since.m >> since.d;
  cout << "Enter second date (y m d): ";
  cin >> to.y >> to.m >> to.d;
  cout << dbtw(since, to) << endl;

  return 0;
}
