#include <iostream>

template <typename T> constexpr inline T add(T x, T y, T z) noexcept {
    return x + y + z;
}

int main(void) {
    constexpr auto a = add(1, 2, 3);
    constexpr auto b = add(1l, 2l, 3l);
    constexpr auto c = add(1.f, 2.f, 3.f);

    std::cout << "Sums: " << a << ", " << b << ", " << c << std::endl;
    return 0;
}
