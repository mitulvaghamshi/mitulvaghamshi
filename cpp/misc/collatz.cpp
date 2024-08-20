#include <iostream>

// Collatz's Hypothesis
//
// In 1937, a mathematician named Lothar Collatz formulated an
// intriguing hypothesis that remains unsolved to this day
// which can be described in the following way:
//
//   Step 1: Take any non-negative and non-zero integer (call it N);
//   Step 2: If it's even, evaluate a new N as N / 2
//   Step 3: Otherwise, if it's odd, evaluate a new N as N * 3 + 1
//   Step 4: If N != 1, skip to step 2
//
// The hypothesis says that,
// regardless of the initial value of N, it will always (always!) go to 1.

unsigned int run(unsigned int n) {
  unsigned int steps = 1; steps++;
  n = (n % 2) ? n * 3 + 1 : n / 2;
  if (n != 1) { steps += run(n); }
  return steps;
}

int main(void) {
  unsigned int n;
  std::cout << "Enter a non-zero positive number: "; std::cin >> n;
  std::cout << "Steps to reach 1: " << run(n) << std::endl;
  return 0;
}
