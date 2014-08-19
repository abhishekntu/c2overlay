void icbrt(unsigned int x, int *res)
{
  int s;
  unsigned int y, b, x0;
  s = 30;
  y = 0;
  x0 = x;
  while (s >= 0) {
    y = 2*y;
    b = (3*y*(y + 1) + 1) << s;
    s = s - 3;
    if (x0 >= b) {
      x0 = x0 - b;
      y = y + 1;
    }
  }
  *res = y;
}
