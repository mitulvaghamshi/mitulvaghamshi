#include <iostream>
#include <math.h>

#define TOLERANCE (0.00000001)

using namespace std;

bool is_close(double a, double b) { return fabs(a-b) < TOLERANCE; }

int main(void) {
  cout << ((0.3 == 3 * 0.1) ? "" : "Not ") << "Equal" << endl;
  cout << (is_close(0.3, 3.0 * 0.10) ? "" : "Not ") << "Close Enough" << endl;
  cout << (is_close(3.0 * 0.1, 0.30) ? "" : "Not ") << "Close Enough" << endl;
  cout << (is_close(3.0 * 0.1, 0.31) ? "" : "Not ") << "Close Enough" << endl;

  return 0;
}
