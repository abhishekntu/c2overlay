#include <stdio.h>
#include <math.h>
#include "main.h"
void popcount (unsigned int inp, unsigned int *outp)
{
  unsigned int data;
  unsigned int count;
  unsigned int data$11;
  unsigned int count$11;
  unsigned int temp$21;
  unsigned int count$21;
  unsigned int data$21;

S_1:
  data$11 = inp;
  count$11 = 0;
  data = data$11;
  count = count$11;
  goto S_2;
S_2:
  temp$21 = data & 1;
  count$21 = count + temp$21;
  data$21 = data >> 1;
  data = data$21;
  count = count$21;
  if (data$21 == 0) {goto S_EXIT;} else {goto S_2;}
S_EXIT:
  *outp = count;
}
