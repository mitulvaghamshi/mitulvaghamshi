#include <cstdio>

constexpr int isqrt(int n) {
    int i = 0;
    while (i * i < n) {
        i++;
    }
    return i - (i * i != n);
}

int main(void) {
    constexpr int x = isqrt(1764);
    printf("%d", x);

    return 0;
}
