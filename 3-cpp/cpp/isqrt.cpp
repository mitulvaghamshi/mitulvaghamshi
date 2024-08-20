#include <iostream>

constexpr int isqrt(int n) {
  int i = 0;
  while (i * i < n)
    i++;
  return i - (i * i != n);
}

int main(void) {
  constexpr int x = isqrt(1764);
  std::cout << x << std::endl;
  return 0;
}
