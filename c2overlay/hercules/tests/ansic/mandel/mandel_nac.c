#include <stdio.h>
#include <math.h>
#include "main.h"
void mandel (signed int *out1)
{
  signed int x;
  signed int y;
  signed int on;
  signed int cnt;
  signed int cnt$11;
  signed int y$11;
  signed int x$21;
  signed int on$31;
  signed int on_0$31;
  signed int cnt$41;
  signed int on_0$51;
  signed int x$71;
  signed int y$91;

L0005:
  cnt$11 = 0;
  y$11 = 950;
  y = y$11;
  cnt = cnt$11;
  goto D_1383;
D_1382:
  x$21 = -2100;
  x = x$21;
  goto D_1380;
D_1379:
  checkpixel(x, y, &on$31);
  on_0$31 = on$31;
  on = on$31;
  if (on_0$31 == 1) {goto D_1387;} else {goto D_1388;}
D_1387:
  cnt$41 = cnt + 1;
  cnt = cnt$41;
  goto D_1388;
D_1388:
  on_0$51 = on;
  if (on_0$51 == 0) {goto D_1389;} else {goto D_1390;}
D_1389:
  goto D_1390;
D_1390:
  x$71 = x + 40;
  x = x$71;
  goto D_1380;
D_1380:
  if (x <= 999) {goto D_1379;} else {goto D_1381;}
D_1381:
  y$91 = y - 50;
  y = y$91;
  goto D_1383;
D_1383:
  if (y >= -949) {goto D_1382;} else {goto D_1384;}
D_1384:
  *out1 = cnt;
  goto L_EXIT;
L_EXIT:
  /* NOP */;
}
