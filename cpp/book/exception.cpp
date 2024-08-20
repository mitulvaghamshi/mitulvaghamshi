#include <iostream>
#include <stdexcept>

struct Program {
    void forget(int x) {
        if (x == 0xFACE) {
            throw std::runtime_error{"Something went wrong."};
        } else if (x == 0) {
            throw DevideByZeroException{"Can not devide by zero."};
        }

        std::cout << "Forgot: 0x%x" << x << std::endl;
    }
};

struct DevideByZeroException : std::exception {
  private:
    std::string message;

  public:
    DevideByZeroException(const std::string message);

    ~DevideByZeroException();

    std::string get_message(void) const noexcept;
};

DevideByZeroException::DevideByZeroException(const std::string message)
    : message{message} {};

DevideByZeroException::~DevideByZeroException() {}

std::string DevideByZeroException::get_message(void) const noexcept {
    return message;
}

int main(void) {
    auto app = Program();

    try {
        app.forget(0xC0DE);
        app.forget(0xFACE);
        app.forget(0xC0FFEE);
    } catch (const std::runtime_error &e) {
        std::cerr << e.what() << std::endl;
    } catch (const DevideByZeroException &e) {
        std::cerr << e.get_message() << std::endl;
    }

    return 0;
}
