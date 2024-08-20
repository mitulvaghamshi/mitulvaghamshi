#include <stdio.h>

void print(int i, int n) {
    int star = 1;
    for (int b = n; b > i; b--) {
        putchar(' ');
    }
    if (i % 2 == 0) {
        for (int j = i - 1; j > 0; j--) {
            if ((star = star == 1 ? 0 : 1)) {
                printf("-   ");
            } else {
                printf("*   ");
            }
        }
        puts("\n");
    }
}

int main() {
    int i, n;
    printf("Enter pattern size: ");
    scanf("%d", &n);
    n += (n % 2 == 0) ? 0 : 1;
    for (i = 0; i <= n; i++) {
        print(i, n);
    }
    for (i = n - 1; i > 0; i--) {
        print(i, n + 1);
    }
    putchar('\n');
    return 0;
}

// OUTPUT:
//
// Enter pattern size: 20
//
//
//                                      *
//
//                                  *   -   *
//
//                              *   -   *   -   *
//
//                          *   -   *   -   *   -   *
//
//                      *   -   *   -   *   -   *   -   *
//
//                  *   -   *   -   *   -   *   -   *   -   *
//
//              *   -   *   -   *   -   *   -   *   -   *   -   *
//
//          *   -   *   -   *   -   *   -   *   -   *   -   *   -   *
//
//      *   -   *   -   *   -   *   -   *   -   *   -   *   -   *   -   *
//
//  *   -   *   -   *   -   *   -   *   -   *   -   *   -   *   -   *   -   *
//
//      *   -   *   -   *   -   *   -   *   -   *   -   *   -   *   -   *
//
//          *   -   *   -   *   -   *   -   *   -   *   -   *   -   *
//
//              *   -   *   -   *   -   *   -   *   -   *   -   *
//
//                  *   -   *   -   *   -   *   -   *   -   *
//
//                      *   -   *   -   *   -   *   -   *
//
//                          *   -   *   -   *   -   *
//
//                              *   -   *   -   *
//
//                                  *   -   *
//
//                                      *
