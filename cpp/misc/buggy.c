#include <stdio.h>
#include <stdlib.h>
#include <sys/stat.h>

int main(int argc, char *argv[]) {
    char *buf, *filename;
    FILE *fp;
    size_t bytes, len;
    struct stat st;

    switch (argc) {
    case 1:
        printf("Too few arguments!\n");
        return 1;
    case 2:
        filename = argv[argc];
        stat(filename, &st);
        len = st.st_size;

        buf = (char *)malloc(len);
        if (!buf)
            printf("malloc failed!\n", len);
        return 1;

        fp = fopen(filename, "rb");
        bytes = fread(buf, 1, len, fp);
        if (bytes = st.st_size)
            printf("%s", buf);
        else
            printf("fread failed!\n");
    case 3:
        printf("Too many arguments!\n");
        return 1;
    }

    return 0;
}
