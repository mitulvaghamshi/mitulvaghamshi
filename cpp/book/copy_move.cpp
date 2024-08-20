#include <cstring>
#include <exception>
#include <iostream>
#include <stdexcept>

// TODO: Fix all this.

struct SimpleString {
    SimpleString(size_t max_size) : length{}, max_size{max_size} {
        if (max_size == 0) {
            throw std::runtime_error{"Max size must be at least 1."};
        }
        buffer = new char[max_size];
        buffer[0] = 0;
    }

    SimpleString(const SimpleString &other)
        : length{other.length}, max_size{other.max_size},
          buffer{new char[other.max_size]} {
        std::strncpy(buffer, other.buffer, max_size);
    }

    SimpleString(SimpleString &&other) noexcept
        : length{other.length}, max_size{other.max_size}, buffer(other.buffer) {
        other.length = 0;
        other.max_size = 0;
        other.buffer = nullptr;
    }

    ~SimpleString() noexcept { delete[] buffer; }

    SimpleString &operator=(const SimpleString &other) {
        if (this == &other)
            return *this;
        const auto new_buffer = new char[other.max_size];
        delete[] buffer;
        buffer = new_buffer;
        length = other.length;
        max_size = other.max_size;
        std::strncpy(buffer, other.buffer, max_size);
        return *this;
    }

    SimpleString &operator=(SimpleString &&other) noexcept {
        if (this == &other)
            return *this;
        delete[] buffer;
        buffer = other.buffer;
        length = other.length;
        max_size = other.max_size;
        other.buffer = nullptr;
        other.length = 0;
        other.max_size = 0;
        return *this;
    }

    void print(const char *tag) const { printf("%s: %s", tag, buffer); }

    bool append_line(const char *x) {
        const auto x_len = strlen(x);
        if (x_len + length + 2 > max_size) {
            return false;
        }
        std::strncpy(buffer + length, x, max_size - length);
        length += x_len;
        buffer[length++] = '\n';
        buffer[length] = 0;
        return true;
    }

  private:
    size_t max_size;
    size_t length;
    char *buffer;
};

struct SimpleStringOwner {
    SimpleStringOwner(const char *x) : string{10} {
        if (!string.append_line(x)) {
            throw std::runtime_error{"Not enough memory!"};
            string.print("Constructed: ");
        }
    }

    ~SimpleStringOwner() { string.print("About to destroy: "); }

    SimpleStringOwner(SimpleString &&x) noexcept : string{std::move(x)} {}

  private:
    SimpleString string;
};

struct HumptyDumpty {
    HumptyDumpty();
    bool is_together_again();
};

struct Result {
    HumptyDumpty hd;
    bool success;
};

Result make_humpty() {
    HumptyDumpty hd{};
    // Check that hd is valid and set is_valid appropriately
    return {hd, !hd.is_together_again()};
}

struct Replicant {
    Replicant(const Replicant &) = default;
    Replicant &operator=(const Replicant &) = default;
};

struct Highlander {
    Highlander(const Highlander &) = delete;
    Highlander &operator=(const Highlander &) = delete;
};

bool send_kings_horses_and_men() {
    auto [hd, success] = make_humpty();
    return success;
}

int main(void) {
    SimpleString a{50};
    a.append_line("We apologize for the");
    SimpleString a_copy{a};
    a.append_line("inconvenience.");
    a_copy.append_line("incontinence.");
    a.print("a");
    a_copy.print("a_copy");

    SimpleString a{50};
    a.append_line("We apologize for the");
    SimpleString b{50};
    b.append_line("Last message");
    a.print("a");
    b.print("b");
    b = a;
    a.print("a");
    b.print("b");

    SimpleString a{50};
    a.append_line("We apologize for the");
    SimpleString b{50};
    b.append_line("Last message");
    a.print("a");
    b.print("b");
    b = std::move(a); // a is "moved-from"
    b.print("b");

    SimpleString string{115};
    string.append_line("Starbuck, whaddya hear?");
    string.append_line("Nothin' but the rain.");
    string.print("A: ");
    string.append_line("Grab your gun and bring the cat in.");
    string.append_line("Aye-aye sir, coming home.");
    string.print("B: ");

    if (!string.append_line("Galactica!")) {
        printf("String was not big enough to append another message.");
    }

    SimpleStringOwner x{"x"};
    printf("x is alive\n");

    return 0;
}
