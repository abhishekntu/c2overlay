#include <stdio.h>
#include <math.h>
#include "main.h"
void gcd (unsigned short a, unsigned short b, unsigned short *outp)
{
  unsigned short x;
  unsigned short y;
  unsigned short res;
  unsigned short x$1;
  unsigned short y$1;
  unsigned short t1$1;
  unsigned short t2$1;
  unsigned short t3$1;
  unsigned short res$1;

S_1:
  x$1 = a;
  y$1 = b;
  if (x$1 != 0)
    t1$1 = 1;
  else
    t1$1 = 0;
  if (y$1 != 0)
    t2$1 = 1;
  else
    t2$1 = 0;
  t3$1 = t1$1 & t2$1;
  res$1 = 0;
  x = x$1;
  y = y$1;
  res = res$1;
  if (t3$1 != 1) {goto S_EXIT;} else {goto S_2;}
S_2:
  if (x > y) {goto S_5;} else {goto S_3;}
S_3:
  if (x < y) {goto S_6;} else {goto S_4;}
S_4:
  res$1 = x;
  res = res$1;
  goto S_EXIT;
S_5:
  x$1 = x - y;
  x = x$1;
  goto S_2;
S_6:
  y$1 = y - x;
  y = y$1;
  goto S_2;
S_EXIT:
  *outp = res;
}
