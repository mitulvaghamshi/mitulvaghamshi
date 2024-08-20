long double calc_pi(unsigned long long int n) {
  bool f = false; double d = 1;
  long double pi4 = 0.0; while (n-- > 0) {
    pi4 = f ? pi4 - (1 / d) : pi4 + (1 / d);
    d += 2; f = !f;
  }
  return (pi4 * 4.0);
}
