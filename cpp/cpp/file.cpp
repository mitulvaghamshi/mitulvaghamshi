#include <iostream>
#include <system_error>

using namespace std;

struct File {
  FILE *ptr;
  File(const char *path, bool write) {
    ptr = fopen(path, write ? "w" : "r");
    if (!ptr)
      throw system_error(errno, system_category());
    cout << "File opened/created..." << endl;
  }

  ~File() {
    fclose(ptr);
    cout << "File closed..." << endl;
  }
};

int main(void) {
  {
    auto file = File("message.txt", true);
    const auto msg = "We apologize for the inconvenience.";
    fwrite(msg, strlen(msg), 1, file.ptr);
  }

  auto file = File("message.txt", false);
  char msg[37]{};

  fread(msg, sizeof(msg), 1, file.ptr);
  cout << "Message: " << msg << endl;

  return 0;
}
