#include <cstdio>

constexpr inline int absolute_value(int x) { return x < 0 ? x * -1 : x; }

int main(void) {
    constexpr int my_num = -10;

    printf("The absolute value of %d is %d.\n", my_num, absolute_value(my_num));
    return 0;
}
