#include <stdio.h>
#include <math.h>
#include "main.h"
void popcount (signed int inp_2, signed int *retarg)
{
  signed int data_4;
  signed int count_5;
  signed int data_4$11;
  signed int count_5$11;
  signed int t1$21;
  signed int t5$21;
  signed int t2$31;
  signed int t3$31;
  signed int count_5$31;
  signed int t4$31;
  signed int data_4$31;

t4_lab1:
  data_4$11 = inp_2;
  count_5$11 = 0;
  data_4 = data_4$11;
  count_5 = count_5$11;
  goto LL3;
LL3:
  if (data_4 != 0)
    t1$21 = 1;
  else
    t1$21 = 0;
  if (t1$21 == 0)
    t5$21 = 1;
  else
    t5$21 = 0;
  if (t5$21 != 0) {goto LL1;} else {goto S_00001_X;}
S_00001_X:
  t2$31 = data_4 & 1;
  t3$31 = count_5 + t2$31;
  count_5$31 = t3$31;
  t4$31 = data_4 >> 1;
  data_4$31 = t4$31;
  data_4 = data_4$31;
  count_5 = count_5$31;
  goto LL2;
LL2:
  goto LL3;
LL1:
  *retarg = count_5;
}
