#include <stdio.h>
#include <math.h>
#include "main.h"
signed int arr[10] = {
  2,
  3,
  5,
  7,
  11,
  13,
  17,
  19,
  23,
  27
};
void arraysum (signed int in1, signed int *out1)
{
  signed int i;
  signed int sum;
  signed int sum$11;
  signed int i$11;
  signed int D_1370$21;
  signed int sum$21;
  signed int i$21;

L0005:
  sum$11 = 0;
  i$11 = 0;
  i = i$11;
  sum = sum$11;
  goto D_1367;
D_1366:
  D_1370$21 = arr[i];
  sum$21 = D_1370$21 + sum;
  i$21 = i + 1;
  i = i$21;
  sum = sum$21;
  goto D_1367;
D_1367:
  if (i < in1) {goto D_1366;} else {goto D_1368;}
D_1368:
  *out1 = sum;
  goto L_EXIT;
L_EXIT:
  /* NOP */;
}
