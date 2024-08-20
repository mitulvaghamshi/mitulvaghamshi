#include <iostream>
#include <stdexcept>

using namespace std;

struct DevideByZeroException : exception {
private:
  string message;

public:
  DevideByZeroException(const string message) : message(message) {};
  ~DevideByZeroException() {};
  string get_message(void) const noexcept { return message; }
};

struct Program {
  void forget(int x) {
    if (x == 0xFACE) {
      throw runtime_error{"Something went wrong."};
    } else if (x == 0) {
      throw DevideByZeroException{"Can not devide by zero."};
    }
    cout << "Forgot: 0x%x" << x << endl;
  }
};

int main(void) {
  try {
    auto app = Program();
    app.forget(0xC0DE);
    app.forget(0xFACE);
    app.forget(0xC0FFEE);
  } catch (const runtime_error &e) {
    cerr << e.what() << endl;
  } catch (const DevideByZeroException &e) {
    cerr << e.get_message() << endl;
  }
  return 0;
}
