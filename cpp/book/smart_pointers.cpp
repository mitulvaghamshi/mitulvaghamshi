#include <iostream>
#include <memory>

struct Foundation {
    Foundation() { std::cout << "Foundation: created..." << std::endl; }

    ~Foundation() { std::cout << "Foundation: removed..." << std::endl; }

    const char *founder;
};

struct Mutant {
    Mutant(std::unique_ptr<Foundation> foundation)
        : foundation{std::move(foundation)} {
        std::cout << "Mutant: created..." << std::endl;
    }

    ~Mutant() { std::cout << "Mutant: removed..." << std::endl; }

    std::unique_ptr<Foundation> foundation;
};

int main(void) {
    std::unique_ptr<Foundation> who_foundation{new Foundation{}};
    Mutant mutant{std::move(who_foundation)};
    mutant.foundation->founder = "Mr. Who!";
    std::cout << "Founder: " << mutant.foundation->founder << std::endl;
    return 0;
}
