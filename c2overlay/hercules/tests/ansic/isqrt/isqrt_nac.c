#include <stdio.h>
#include <math.h>
#include "main.h"
void isqrt (unsigned int x, unsigned int *outp)
{
  unsigned int m;
  unsigned int y;
  unsigned int b;
  unsigned int x0;
  unsigned int m$11;
  unsigned int y$11;
  unsigned int x0$11;
  unsigned int b$21;
  unsigned int y$21;
  unsigned int x0$31;
  unsigned int y$31;
  unsigned int m$41;

L0005:
  m$11 = 1073741824;
  y$11 = 0;
  x0$11 = x;
  m = m$11;
  y = y$11;
  x0 = x0$11;
  goto D_1368;
D_1367:
  b$21 = y | m;
  y$21 = y >> 1;
  y = y$21;
  b = b$21;
  if (x0 >= b$21) {goto D_1371;} else {goto D_1372;}
D_1371:
  x0$31 = x0 - b;
  y$31 = y | m;
  y = y$31;
  x0 = x0$31;
  goto D_1372;
D_1372:
  m$41 = m >> 2;
  m = m$41;
  goto D_1368;
D_1368:
  if (m != 0) {goto D_1367;} else {goto D_1369;}
D_1369:
  *outp = y;
  goto L_EXIT;
L_EXIT:
  /* NOP */;
}
