#include <stdio.h>
#include <math.h>
#include "main.h"
void eda (signed int in1, signed int in2, unsigned int *out1)
{
  unsigned int t1$11;
  unsigned int t2$11;
  unsigned int x$11;
  unsigned int y$11;
  unsigned int t3$11;
  unsigned int t4$11;
  unsigned int t5$11;
  unsigned int t6$11;
  unsigned int t7$11;

S_1:
  if (in1 < 0)
    t1$11 = -(in1);
  else
    t1$11 = in1;
  if (in2 < 0)
    t2$11 = -(in2);
  else
    t2$11 = in2;
  if (t1$11 > t2$11)
    x$11 = t1$11;
  else
    x$11 = t2$11;
  if (t1$11 < t2$11)
    y$11 = t1$11;
  else
    y$11 = t2$11;
  t3$11 = x$11 >> 3;
  t4$11 = y$11 >> 1;
  t5$11 = x$11 - t3$11;
  t6$11 = t4$11 + t5$11;
  if (t6$11 > x$11)
    t7$11 = t6$11;
  else
    t7$11 = x$11;
  *out1 = t7$11;
}
