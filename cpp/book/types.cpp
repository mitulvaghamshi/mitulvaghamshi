#include <cstdbool>
#include <cstddef>
#include <cstdint>
#include <cstdio>
#include <cstdlib>
#include <cwchar>
#include <vector>

int main(void) {
    // signed char (hd): 1 bytes
    printf("signed char (c): %lu bytes\n", sizeof(signed char));
    // unsigned char (hd): 1 bytes
    printf("unsigned char (c): %lu bytes\n", sizeof(unsigned char));
    // char16_t (hd): 2 bytes
    printf("char16_t (c): %lu bytes\n", sizeof(char16_t));
    // char32_t (hd): 4 bytes
    printf("char32_t (c): %lu bytes\n", sizeof(char32_t));
    // wchar_t (hd): 4 bytes
    printf("wchar_t (c): %lu bytes\n\n", sizeof(wchar_t));

    // signed short (hd): 2 bytes
    printf("signed short (hd): %lu bytes\n", sizeof(signed short));
    // unsigned short (hu): 2 bytes
    printf("unsigned short (hu): %lu bytes\n", sizeof(unsigned short));
    // signed int (d): 4 bytes
    printf("signed int (d): %lu bytes\n", sizeof(signed int));
    // unsigned int (u): 4 bytes
    printf("unsigned int (u): %lu bytes\n", sizeof(unsigned int));
    // signed long (ld): 8 bytes
    printf("signed long (ld): %lu bytes\n", sizeof(signed long));
    // unsigned long (lu): 8 bytes
    printf("unsigned long (lu): %lu bytes\n", sizeof(unsigned long));
    // signed long long (lld): 8 bytes
    printf("signed long long (lld): %lu bytes\n", sizeof(signed long long));
    // unsigned long long (llu): 8 bytes
    printf("unsigned long long (llu): %lu bytes\n\n",
           sizeof(unsigned long long));

    // ssize_t (signed long): 8 bytes
    printf("ssize_t (signed long): %lu bytes\n", sizeof(ssize_t));
    // size_t (unsigned long): 8 bytes
    printf("size_t (unsigned long): %lu bytes\n", sizeof(size_t));
    // user_ssize_t (signed long long): 8 bytes
    printf("user_ssize_t (signed long long): %lu bytes\n",
           sizeof(user_ssize_t));
    // user_size_t (unsigned long long): 8 bytes
    printf("user_size_t (unsigned long long): %lu bytes\n",
           sizeof(user_size_t));
    // __darwin_ssize_t (signed long): 8 bytes
    printf("__darwin_ssize_t (signed long): %lu bytes\n\n",
           sizeof(__darwin_ssize_t));
    // __darwin_size_t (unsigned long): 8 bytes
    printf("__darwin_size_t (unsigned long): %lu bytes\n\n",
           sizeof(__darwin_size_t));

    // int8_t: 1
    printf("int8_t: %lu\n", sizeof(int8_t));
    // int16_t: 2
    printf("int16_t: %lu\n", sizeof(int16_t));
    // int32_t: 4
    printf("int32_t: %lu\n", sizeof(int32_t));
    // int64_t: 8
    printf("int64_t: %lu\n\n", sizeof(int64_t));

    // uint8_t: 1
    printf("uint8_t: %lu\n", sizeof(uint8_t));
    // uint16_t: 2
    printf("uint16_t: %lu\n", sizeof(uint16_t));
    // uint32_t: 4
    printf("uint32_t: %lu\n", sizeof(uint32_t));
    // uint64_t: 8
    printf("uint64_t: %lu\n\n", sizeof(uint64_t));

    // int_least8_t: 1
    printf("int_least8_t: %lu\n", sizeof(int_least8_t));
    // int_least16_t: 2
    printf("int_least16_t: %lu\n", sizeof(int_least16_t));
    // int_least32_t: 4
    printf("int_least32_t: %lu\n", sizeof(int_least32_t));
    // int_least64_t: 8
    printf("int_least64_t: %lu\n\n", sizeof(int_least64_t));

    // uint_least8_t: 1
    printf("uint_least8_t: %lu\n", sizeof(uint_least8_t));
    // uint_least16_t: 2
    printf("uint_least16_t: %lu\n", sizeof(uint_least16_t));
    // uint_least32_t: 4
    printf("uint_least32_t: %lu\n", sizeof(uint_least32_t));
    // uint_least64_t: 8
    printf("uint_least64_t: %lu\n\n", sizeof(uint_least64_t));

    // int_fast8_t: 1
    printf("int_fast8_t: %lu\n", sizeof(int_fast8_t));
    // int_fast16_t: 2
    printf("int_fast16_t: %lu\n", sizeof(int_fast16_t));
    // int_fast32_t: 4
    printf("int_fast32_t: %lu\n", sizeof(int_fast32_t));
    // int_fast64_t: 8
    printf("int_fast64_t: %lu\n\n", sizeof(int_fast64_t));

    // uint_fast8_t: 1
    printf("uint_fast8_t: %lu\n", sizeof(uint_fast8_t));
    // uint_fast16_t: 2
    printf("uint_fast16_t: %lu\n", sizeof(uint_fast16_t));
    // uint_fast32_t: 4
    printf("uint_fast32_t: %lu\n", sizeof(uint_fast32_t));
    // uint_fast64_t: 8
    printf("uint_fast64_t: %lu\n\n", sizeof(uint_fast64_t));

    // intptr_t: 8
    printf("intptr_t: %lu\n", sizeof(intptr_t));
    // uintptr_t: 8
    printf("uintptr_t: %lu\n\n", sizeof(uintptr_t));

    // intmax_t: 8
    printf("intmax_t: %lu\n", sizeof(intmax_t));
    // uintmax_t: 8
    printf("uintmax_t: %lu\n\n", sizeof(uintmax_t));

    // uintmax_t: 16
    printf("__int128_t: %lu\n", sizeof(__int128_t));
    // __uint128_t: 16
    printf("__uint128_t: %lu\n\n", sizeof(__uint128_t));

    unsigned short binary = 0b10101010;
    printf("%hu: %lu\n", binary, sizeof(binary));
    int octal = 0123;
    printf("%o = %d: %lu\n", octal, octal, sizeof(octal));
    unsigned long long hex = 0xFFFFFFFFFFFFFFFF;
    printf("%llx = %llu: %lu\n\n", hex, hex, sizeof(hex));

    auto pi = 3.141595e-4;
    printf("PI: %f, %e, %g\n", pi, pi, pi);
    printf("PI (double): %lf, %le, %lg\n", pi, pi, pi);
    printf("PI (long double): %Lf, %Le, %Lg\n\n", pi, pi, pi);

    char c = 'c';
    char16_t a = u'\u0041';
    char32_t beer = U'\U0001F37A';
    wchar_t t = L'\uF8FF';
    printf("C = %c: %lu bytes\n", c, sizeof(c));
    printf("a = %c: %lu bytes\n", a, sizeof(a));
    printf("beer = %c: %lu bytes\n", beer, sizeof(beer));
    printf("logo = %lc: %lu bytes\n\n", t, sizeof(t));

    std::vector<std::vector<bool>> and_gate{
        {false, false}, {false, true}, {true, false}, {true, true}};
    for (std::vector<bool> v : and_gate) {
        bool a = v[0];
        bool b = v[1];
        printf("| %d | %d | %d |\n", a, b, a == b);
    }
    std::size_t x = sizeof(std::size_t);
    printf("\nsize_t: %zd\n\n", x);
    return 0;
}
