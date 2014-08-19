void isqrt(unsigned int x, unsigned int *outp)
{
  unsigned int m, y, b, x0;
  m = 0x1 << (32 -2);
  y = 0;
  x0 = x;
  while (m != 0)
  {
    b = y | m;
    y = y >> 1;
    if (x0 >= b)
    {
      x0 = x0 - b;
      y = y | m;
    }
    m = m >> 2;
  }
  *outp = y;
}
