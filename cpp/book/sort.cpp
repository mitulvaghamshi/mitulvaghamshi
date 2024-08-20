#include <algorithm>
#include <iostream>
#include <vector>

int main(void) {
    std::vector<int> x{0, 1, 8, 13, 5, 2, 3};
    x[0] = 21;
    x.push_back(1);

    std::sort(x.begin(), x.end());

    std::cout << "Printing " << x.size() << " fibonacci numbers:" << std::endl;
    for (auto n : x) {
        std::cout << n << std::endl;
    }

    // Lambda: [capture](arguments) { body }
    auto even_count =
        std::count_if(x.begin(), x.end(), [](auto n) { return n % 2 == 0; });
    std::cout << "Even fibs: " << even_count << std::endl;

    return 0;
}
