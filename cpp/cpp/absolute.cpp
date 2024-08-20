#include <iostream>

const constexpr inline int absolute_value(int x) noexcept {
  return x < 0 ? x * -1 : x;
}

int main(void) {
  const constexpr int my_num = -10;
  std::cout << "The absolute value of " << my_num << " is "
            << absolute_value(my_num) << std::endl;
  return EXIT_SUCCESS;
}
