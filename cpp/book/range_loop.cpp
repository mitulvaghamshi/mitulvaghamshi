#include <cstdio>

struct FibIter {
    inline constexpr int operator*() const noexcept { return current; }

    inline constexpr bool operator!=(const int x) const noexcept {
        return x >= current;
    }

    inline constexpr FibIter &operator++() noexcept {
        const auto tmp = current;
        current += last;
        last = tmp;
        return *this;
    }

  private:
    int current{1}, last{1};
};

struct FibRange {
    explicit FibRange(const int max) noexcept : max{max} {}

    inline constexpr FibIter begin() const noexcept { return FibIter{}; }

    inline constexpr int end() const noexcept { return max; }

  private:
    const int max;
};

int main(void) {
    for (const auto i : FibRange{5000}) {
        printf("%d ", i);
    }
    return 0;
}

int main1(void) {
    FibonacciRange range{5000};

    const auto end = range.end();
    for (const auto x = range.begin(); x != end; ++x) {
        const auto i = *x;
        printf("%d ", i);
    }
}
