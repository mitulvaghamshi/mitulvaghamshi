#include <iomanip>
#include <iostream>

using namespace std;

int main()
{
  const char *a = "[{(<>)}]";
  for (int i = 1; i <= 20; i++)
    if (i <= 4)
      cout << left << setw(16) << a << a << a << a << endl;
    else if (i <= 8)
      cout << setw(16) << a << a << endl;
    else if (i <= 12)
      cout << a << a << a << a << a << endl;
    else if (i <= 16)
      cout << right << setw(24) << a << setw(16) << a << endl;
    else if (i <= 20)
      cout << a << a << a << setw(16) << a << endl;
  return 0;
}

// OUTPUT:
//
// [{(<>)}]        [{(<>)}][{(<>)}][{(<>)}]
// [{(<>)}]        [{(<>)}][{(<>)}][{(<>)}]
// [{(<>)}]        [{(<>)}][{(<>)}][{(<>)}]
// [{(<>)}]        [{(<>)}][{(<>)}][{(<>)}]
// [{(<>)}]        [{(<>)}]
// [{(<>)}]        [{(<>)}]
// [{(<>)}]        [{(<>)}]
// [{(<>)}]        [{(<>)}]
// [{(<>)}][{(<>)}][{(<>)}][{(<>)}][{(<>)}]
// [{(<>)}][{(<>)}][{(<>)}][{(<>)}][{(<>)}]
// [{(<>)}][{(<>)}][{(<>)}][{(<>)}][{(<>)}]
// [{(<>)}][{(<>)}][{(<>)}][{(<>)}][{(<>)}]
//                 [{(<>)}]        [{(<>)}]
//                 [{(<>)}]        [{(<>)}]
//                 [{(<>)}]        [{(<>)}]
//                 [{(<>)}]        [{(<>)}]
// [{(<>)}][{(<>)}][{(<>)}]        [{(<>)}]
// [{(<>)}][{(<>)}][{(<>)}]        [{(<>)}]
// [{(<>)}][{(<>)}][{(<>)}]        [{(<>)}]
// [{(<>)}][{(<>)}][{(<>)}]        [{(<>)}]