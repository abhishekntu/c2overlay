#include <stdio.h>
#include <math.h>
#include "main.h"
unsigned int input[16] = {
  1,
  2,
  3,
  4,
  5,
  6,
  7,
  8,
  9,
  10,
  11,
  12,
  13,
  14,
  15,
  16
};
unsigned int output[16] = {
};
void c2vwavelet (unsigned int length, unsigned int *y)
{
  unsigned int len;
  unsigned int i;
  unsigned int len$11;
  unsigned int i$21;
  unsigned int D_1376$31;
  unsigned int D_1377$31;
  unsigned int D_1376$32;
  unsigned int D_1378$31;
  unsigned int D_1379$31;
  unsigned int sum$31;
  unsigned int D_1376$33;
  unsigned int D_1377$32;
  unsigned int D_1376$34;
  unsigned int D_1378$32;
  unsigned int D_1379$32;
  unsigned int difference$31;
  unsigned int D_1380$31;
  unsigned int i$31;
  unsigned int len$51;

L0005:
  len$11 = length >> 1;
  len = len$11;
  goto D_1373;
D_1372:
  i$21 = 0;
  i = i$21;
  goto D_1370;
D_1369:
  D_1376$31 = (unsigned int)i * (unsigned int)2;
  D_1377$31 = input[D_1376$31];
  D_1376$32 = (unsigned int)i * (unsigned int)2;
  D_1378$31 = D_1376$32 + 1;
  D_1379$31 = input[D_1378$31];
  sum$31 = D_1377$31 + D_1379$31;
  D_1376$33 = (unsigned int)i * (unsigned int)2;
  D_1377$32 = input[D_1376$33];
  D_1376$34 = (unsigned int)i * (unsigned int)2;
  D_1378$32 = D_1376$34 + 1;
  D_1379$32 = input[D_1378$32];
  difference$31 = D_1377$32 - D_1379$32;
  output[i] = sum$31;
  D_1380$31 = len + i;
  output[D_1380$31] = difference$31;
  i$31 = i + 1;
  i = i$31;
  goto D_1370;
D_1370:
  if (i < len) {goto D_1369;} else {goto D_1371;}
D_1371:
  len$51 = len >> 1;
  len = len$51;
  goto D_1373;
D_1373:
  if (len > 1) {goto D_1372;} else {goto D_1374;}
D_1374:
  *y = 1;
  goto L_EXIT;
L_EXIT:
  /* NOP */;
}
