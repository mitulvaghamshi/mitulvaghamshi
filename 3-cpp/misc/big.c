#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef int (^min)(int, int);

int run(min f, int a, int b) { return f(a, b); }

void get_min(void) {
  int x = 10, y = 20;
  min fn = ^(int a, int b) {
    return a * (a < b) + b * (b <= a);
  };
  int r = run(fn, x, y);
  printf("Min of %d and %d is %d\n", x, y, r);
}

typedef struct {
  int i;
  int *p;
  char s;
  char *c;
} TS;

// $ leaks -atExit -- ./a.out
void memory_leak(void) {
  TS *t = malloc(sizeof(TS));
  t->c = malloc(1);
  char *x = "A"; // leak if not freed!
  strcpy(t->c, x);
  // free(x); // Free to prevent memory leak!
  free(t);
}

void type_sizes(void) {
  TS var;
  TS *ptr;

  puts("struct TS { int i; int *p; char s; char *c; };");

  printf("sizeof(int)  : %3lu bytes\n", sizeof(int));    // 4 bytes
  printf("sizeof(int*) : %3lu bytes\n", sizeof(int *));  // 8 bytes
  printf("sizeof(char) : %3lu bytes\n", sizeof(char));   // 1 bytes
  printf("sizeof(char*): %3lu bytes\n", sizeof(char *)); // 8 bytes

  printf("sizeof(TS)   : %3lu bytes\n", sizeof(TS));   // 32 bytes
  printf("sizeof(TS*)  : %3lu bytes\n", sizeof(TS *)); //  8 bytes
  printf("sizeof(var)  : %3lu bytes\n", sizeof(var));  // 32 bytes
  printf("sizeof(ptr)  : %3lu bytes\n", sizeof(ptr));  //  8 bytes
  printf("sizeof(*ptr) : %3lu bytes\n", sizeof(*ptr)); // 32 bytes
}
