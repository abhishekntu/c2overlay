#include <stdio.h>
#include <math.h>
#include "main.h"
void bitrev (unsigned char inp, unsigned char *D_1377)
{
  unsigned char i;
  unsigned char temp;
  unsigned char temp$11;
  unsigned char i$11;
  signed int D_1368$21;
  signed int D_1369$21;
  signed int D_1370$21;
  signed int D_1371$21;
  signed int D_1369$22;
  signed int D_1372$21;
  signed int D_1372$22;
  signed int D_1373$21;
  signed char D_1374$21;
  signed char temp_0$21;
  signed char D_1376$21;
  unsigned char temp$21;
  unsigned char i$21;

L0005:
  temp$11 = 0;
  i$11 = 0;
  i = i$11;
  temp = temp$11;
  goto D_1365;
D_1364:
  D_1368$21 = (signed int)(inp);
  D_1369$21 = (signed int)(i);
  D_1370$21 = D_1368$21 >> D_1369$21;
  D_1371$21 = D_1370$21 & 1;
  D_1369$22 = (signed int)(i);
  D_1372$21 = 7;
  D_1372$22 = D_1372$21 - D_1369$22;
  D_1373$21 = D_1371$21 << D_1372$22;
  D_1374$21 = D_1373$21 & 255;
  temp_0$21 = (signed char)(temp);
  D_1376$21 = D_1374$21 | temp_0$21;
  temp$21 = (unsigned char)(D_1376$21);
  i$21 = i + 1;
  i = i$21;
  temp = temp$21;
  goto D_1365;
D_1365:
  if (i <= 7) {goto D_1364;} else {goto D_1366;}
D_1366:
  *D_1377 = temp;
}
