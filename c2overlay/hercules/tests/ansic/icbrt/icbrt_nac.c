#include <stdio.h>
#include <math.h>
#include "main.h"
void icbrt (unsigned int x, signed int *res)
{
  signed int s;
  unsigned int y;
  unsigned int b;
  unsigned int x0;
  signed int s$11;
  unsigned int y$11;
  unsigned int x0$11;
  unsigned int y$21;
  unsigned int D_1371$21;
  unsigned int D_1372$21;
  unsigned int D_1373$21;
  unsigned int D_1374$21;
  unsigned int b$21;
  signed int s$21;
  unsigned int x0$31;
  unsigned int y$31;
  signed int y_0$61;

L0005:
  s$11 = 30;
  y$11 = 0;
  x0$11 = x;
  s = s$11;
  y = y$11;
  x0 = x0$11;
  goto D_1368;
D_1367:
  y$21 = (unsigned int)y * (unsigned int)2;
  D_1371$21 = y$21 + 1;
  D_1372$21 = (unsigned int)D_1371$21 * (unsigned int)y$21;
  D_1373$21 = (unsigned int)D_1372$21 * (unsigned int)3;
  D_1374$21 = D_1373$21 + 1;
  b$21 = D_1374$21 << s;
  s$21 = s - 3;
  s = s$21;
  y = y$21;
  b = b$21;
  if (x0 >= b$21) {goto D_1375;} else {goto D_1376;}
D_1375:
  x0$31 = x0 - b;
  y$31 = y + 1;
  y = y$31;
  x0 = x0$31;
  goto D_1376;
D_1376:
  goto D_1368;
D_1368:
  if (s >= 0) {goto D_1367;} else {goto D_1369;}
D_1369:
  y_0$61 = (signed int)(y);
  *res = y_0$61;
  goto L_EXIT;
L_EXIT:
  /* NOP */;
}
