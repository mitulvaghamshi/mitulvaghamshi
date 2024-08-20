#include <ctime>

struct Date { int d, m, y; };

Date today(void) {
  auto t = time(nullptr);
  auto lt = *localtime(&t);
  return { lt.tm_mday, lt.tm_mon + 1, lt.tm_year + 1900 };
}
