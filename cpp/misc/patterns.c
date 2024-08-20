#include <stdio.h>

void print_space(int index) {
    switch (index) {
    case 0:
    case 9:
    case 10:
        putchar('\0');
        break;
    case 2:
    case 6:
    case 11:
    case 12:
        printf("  ");
        break;
    case 3:
        printf("   ");
        break;
    default:
        printf(" ");
    }
}

void calc_space(int rows, int size, int index) {
    switch (index) {
    case 4:
        while (size--) {
            print_space(index);
        }
        break;
    default:
        while (rows-- > size) {
            print_space(index);
        }
        break;
    }
}

void print_char(int size, int isStar, int index) {
    do {
        switch (index) {
        case 5:
        case 6: {
            if (isStar) {
                printf(" * ");
            } else {
                printf(" - ");
            }
        } break;
        default: {
            if (isStar) {
                printf("* ");
            } else {
                printf("- ");
            }
        } break;
        }
        isStar = isStar ? 0 : 1;
    } while (size--);
    putchar('\n');
}

void print_pattern(int size, int rows, int isStar, int index) {
    if (size % 2 == 0) {
        calc_space(rows, size, index);
        print_char(size, isStar, index);
    }
}

void calc_pattern(int rows, int index) {
    putchar('\n');
    for (int size = 0; size < rows + (index >= 7 ? 1 : 0); size++) {
        switch (index) {
        case 8:
        case 10:
        case 11:
            continue;
        }
        print_pattern(size, rows, 1, index);
    }
    for (int size = rows; size >= 0; size--) {
        switch (index) {
        case 7:
        case 9:
        case 12:
            continue;
        }
        print_pattern(size, rows, 1, index);
    }
}

int main() {
    int rows = 8;
    printf("Enter number of rows: ");
    scanf("%d", &rows);

    for (int index = 0; index <= 12; index++) {
        calc_pattern(rows * 2, index);
    }
    return 0;
}
