#include <stdio.h>
#include <math.h>
#include "main.h"
void sierpinski (signed int *tot)
{
  signed int iftmp_0;
  signed int col;
  signed int row;
  signed int table[1024];
  signed int sum;
  signed int sum$11;
  signed int col$11;
  signed int row$11;
  signed int D_1373$31;
  signed int D_1374$31;
  signed int iftmp_0$41;
  signed int iftmp_0$51;
  signed int temp$61;
  signed int D_1378$61;
  signed int D_1379$61;
  signed int sum$61;
  signed int col$71;
  signed int col$81;
  signed int row$81;

L0005:
  sum$11 = 0;
  col$11 = 0;
  row$11 = 0;
  col = col$11;
  row = row$11;
  sum = sum$11;
  goto D_1367;
D_1367:
  if (col >= row) {goto D_1370;} else {goto D_1371;}
D_1370:
  D_1373$31 = ~(col);
  D_1374$31 = D_1373$31 & row;
  if (D_1374$31 != 0) {goto D_1375;} else {goto D_1376;}
D_1375:
  iftmp_0$41 = 46;
  iftmp_0 = iftmp_0$41;
  goto D_1377;
D_1376:
  iftmp_0$51 = 64;
  iftmp_0 = iftmp_0$51;
  goto D_1377;
D_1377:
  temp$61 = iftmp_0;
  D_1378$61 = (signed int)row * (signed int)32;
  D_1379$61 = D_1378$61 + col;
  table[D_1379$61] = temp$61;
  sum$61 = sum + temp$61;
  sum = sum$61;
  goto D_1371;
D_1371:
  col$71 = col + 1;
  col = col$71;
  if (col$71 > 31) {goto D_1380;} else {goto D_1381;}
D_1380:
  col$81 = 0;
  row$81 = row + 1;
  col = col$81;
  row = row$81;
  goto D_1381;
D_1381:
  if (row != 32) {goto D_1367;} else {goto D_1368;}
D_1368:
  *tot = sum;
  goto L_EXIT;
L_EXIT:
  /* NOP */;
}
