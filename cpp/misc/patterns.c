#include <stdio.h>
#include <stdlib.h>

void ps(int i) {
  if (i == 0 || i == 9 || i == 10)
    putchar(0);
  else if (i == 2 || i == 6 || i == 11 || i == 12)
    printf("  ");
  else if (i == 3)
    printf("   ");
  else
    printf(" ");
}

void cs(int r, int s, int i) {
  int n = i == 4 ? 0 : s;
  int m = i == 4 ? s : r;
  while (m-- > n)
    ps(i);
}

void pc(int s, int f, int i) {
  do {
    if (i == 5 || i == 6)
      putchar(32);
    printf("%c ", f ? '*' : '-');
    f = !f;
  } while (s--);
  putchar(10);
}

void pp(int s, int r, int f, int i) {
  if (s % 2)
    return;
  cs(r, s, i);
  pc(s, f, i);
}

void cp(int r, int i) {
  putchar(10);
  for (int s = 0; s < r + (i >= 7 ? 1 : 0); s++) {
    if (i == 8 || i == 10 || i == 11)
      continue;
    pp(s, r, 1, i);
  }
  for (int s = r; s >= 0; s--) {
    if (i == 7 || i == 9 || i == 12)
      continue;
    pp(s, r, 1, i);
  }
}

int main(int argc, char const *argv[]) {
  if (argc != 2)
    return 1;
  int r = atoi(argv[1]) * 2;
  for (int i = 0; i <= 12; i++)
    cp(r, i);
  return 0;
}
