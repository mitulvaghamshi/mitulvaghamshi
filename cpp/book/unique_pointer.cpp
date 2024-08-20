#include <cstdio>
#include <iostream>

template <typename T> struct UniquePointer {
    UniquePointer() = default;

    UniquePointer(T *founder) : founder{founder} {
        std::cout << "UniquePointer: created..." << std::endl;
    }

    ~UniquePointer() noexcept {
        std::cout << "UniquePointer: removing..." << std::endl;
        if (founder) {
            printf("Founder before delete: : 0x%p\n", founder);
            founder = nullptr;
            printf("Founder after delete: : 0x%p\n", founder);
            std::cout << "UniquePointer: removed..." << std::endl;
        }
    }

    UniquePointer(const UniquePointer &) = delete;

    UniquePointer(UniquePointer &&other) noexcept : founder{other.founder} {
        std::cout << "Move constructor..." << std::endl;
        other.founder = nullptr;
    }

    UniquePointer &operator=(const UniquePointer &) = delete;

    UniquePointer &operator=(UniquePointer &&other) noexcept {
        std::cout << "Move assignment..." << std::endl;
        if (founder) {
            std::cout << "Move assignment free founder..." << std::endl;
            delete founder;
        }
        founder = other.founder;
        std::cout << "Move assignment free param founder..." << std::endl;
        other.founder = nullptr;
        return *this;
    }

    T *get_founger() const noexcept { return founder; }

  private:
    T *founder;
};

int main(void) {
    UniquePointer<const char> who_foundation{"Mr. Who!"};
    printf("Founder who: 0x%p\n", who_foundation.get_founger());

    auto me_foundation =
        new UniquePointer<const char>{std::move(who_foundation)};
    printf("Founder me: 0x%p\n", me_foundation->get_founger());
    printf("Founder after move: : 0x%p\n", who_foundation.get_founger());

    delete me_foundation;
    return 0;
}

template <typename T, typename... Args>
inline UniquePointer<T> make_unique(Args... args) {
    return UniquePointer<T>{new T{args...}};
}
