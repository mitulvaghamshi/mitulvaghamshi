#include <cstdio>
#include <cstring>
#include <system_error>

struct File {
    FILE *ptr;

    File(const char *path, bool write) {
        auto file_mode = write ? "w" : "r";
        ptr = fopen(path, file_mode);
        if (!ptr) {
            throw std::system_error(errno, std::system_category());
        }
        printf("File opened/created...\n");
    }

    ~File() {
        fclose(ptr);
        printf("File closed...\n");
    }
};

int main(void) {
    {
        File file = File("../message.txt", true);
        const auto message = "We apologize for the inconvenience.";
        fwrite(message, strlen(message), 1, file.ptr);
    }

    File file = File("message.txt", false);
    char message[37]{};

    fread(message, sizeof(message), 1, file.ptr);
    printf("Message: %s\n", message);

    return 0;
}
