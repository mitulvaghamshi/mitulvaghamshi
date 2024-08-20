#include <iostream>

void code_1(void) {
  std::cout << "Enter Year = ";
  int y; std::cin >> y;
  int a = y % 19;
  int b = y % 4;
  int c = y % 7;
  int d = (a * 19 + 24) % 30;
  int e = (2 * b + 4 * c + 6 * d + 5) % 7;
  if (d + e < 10)
    std::cout << "March " << d + e + 22 << std::endl;
  else
    std::cout << "April " << d + e - 9 << std::endl;
}

void code_2(void) {
  std::cout << "Enter Year Month Date : ";
  int y, m, d; std::cin >> y >> m >> d;
  m -= 2; if (m <= 0) { m += 12; y--; }
  m = m * 83 / 32;
  m += d;
  m += y;
  m += y / 4;
  m -= y / 100;
  m += y / 400;
  std::cout << m % 7 << endl;
}
