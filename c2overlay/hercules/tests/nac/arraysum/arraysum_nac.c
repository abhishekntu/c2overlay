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
  signed int D_1963$21;
  signed int sum$21;
  signed int i$21;

L0001:
  sum$11 = 0;
  i$11 = 0;
  i = i$11;
  sum = sum$11;
  goto D_1221;
D_1220:
  D_1963$21 = arr[i];
  sum$21 = sum + D_1963$21;
  i$21 = i + 1;
  i = i$21;
  sum = sum$21;
  goto D_1221;
D_1221:
  if (i < in1) {goto D_1220;} else {goto D_1222;}
D_1222:
  printf("sum = %08x\n", sum);
  *out1 = sum;
}
