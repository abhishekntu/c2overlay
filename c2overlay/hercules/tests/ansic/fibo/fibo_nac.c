#include <stdio.h>
#include <math.h>
#include "main.h"
void fibo (unsigned int x, unsigned int *D_1369)
{
  unsigned int f0;
  unsigned int f1;
  unsigned int k;
  unsigned int f;
  unsigned int f0$11;
  unsigned int f1$11;
  unsigned int k$11;
  unsigned int k$21;
  unsigned int f$21;
  unsigned int f0$21;
  unsigned int f1$21;

L0005:
  f0$11 = 0;
  f1$11 = 1;
  k$11 = 2;
  f0 = f0$11;
  f1 = f1$11;
  k = k$11;
  goto D_1366;
D_1366:
  k$21 = k + 1;
  f$21 = f1 + f0;
  f0$21 = f1;
  f1$21 = f$21;
  f0 = f0$21;
  f1 = f1$21;
  k = k$21;
  f = f$21;
  if (k$21 <= x) {goto D_1366;} else {goto D_1367;}
D_1367:
  *D_1369 = f;
}
