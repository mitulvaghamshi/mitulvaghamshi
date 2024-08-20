#include <algorithm>
#include <iostream>
#include <vector>

using namespace std;

int main(void)
{
  vector<int> x{0, 1, 8, 13, 5, 2, 3};
  x[0] = 21;
  x.push_back(1);
  sort(x.begin(), x.end());
  cout << "Printing " << x.size() << " fibonacci numbers:" << endl;
  for (auto n : x)
  {
    cout << n << endl;
  }
  // Lambda: [capture](arguments) { body }
  auto even_count =
      count_if(x.begin(), x.end(), [](auto n)
               { return n % 2 == 0; });
  cout << "Even fibs: " << even_count << endl;
  return 0;
}
