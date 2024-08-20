#include <cstdio>
#include <utility>

inline void ref_type(const char *&x) noexcept { printf("lvalue %s\n", x); }

inline void ref_type(const char *&&x) noexcept { printf("rvalue %s\n", x); }

int main(void) {
    auto x{"Hello"};
    ref_type(x);            // lvalue
    ref_type(std::move(x)); // rvalue
    ref_type("Hi");         // rvalue
    ref_type(x);            // rvalue
    return 0;
}
