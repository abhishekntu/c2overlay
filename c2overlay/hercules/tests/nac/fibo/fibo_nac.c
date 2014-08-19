#include <stdio.h>
#include <math.h>
#include "main.h"
void fibo (unsigned int n, unsigned int *outp)
{
  unsigned int res;
  unsigned int x;
  unsigned int f0;
  unsigned int f1;
  unsigned int k;
  unsigned int x$11;
  unsigned int f0$11;
  unsigned int f1$11;
  unsigned int res$11;
  unsigned int res$21;
  unsigned int k$31;
  unsigned int f$41;
  unsigned int f0$41;
  unsigned int f1$41;
  unsigned int res$41;
  unsigned int k$41;

LL0:
  x$11 = n;
  f0$11 = 0;
  f1$11 = 1;
  res$11 = f0$11;
  res = res$11;
  x = x$11;
  f0 = f0$11;
  f1 = f1$11;
  if (x$11 <= 0) {goto S_EXIT;} else {goto LL1;}
LL1:
  res$21 = f1;
  res = res$21;
  if (x == 1) {goto S_EXIT;} else {goto LL2;}
LL2:
  k$31 = 2;
  k = k$31;
  goto LL3;
LL3:
  f$41 = f1 + f0;
  f0$41 = f1;
  f1$41 = f$41;
  res$41 = f$41;
  k$41 = k + 1;
  res = res$41;
  f0 = f0$41;
  f1 = f1$41;
  k = k$41;
  if (k$41 <= x) {goto LL3;} else {goto S_EXIT;}
S_EXIT:
  *outp = res;
}
