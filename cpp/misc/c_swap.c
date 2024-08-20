#include <stdio.h>

int main() {
  int a = 10;
  int b = 20;
  printf("Original: A = %d, B = %d\n", a, b);

  a ^= b;
  b ^= a;
  a ^= b;
  printf("XOR Swapped: A = %d, B = %d\n", a, b);

  a = a + b;
  b = a - b;
  a = a - b;
  printf("Re Swapped: A = %d, B = %d\n", a, b);

  return 0;
}
