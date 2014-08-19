#include <stdio.h>
#include <math.h>
#include "main.h"
void eda (signed int in1_2, signed int in2_3, signed int *out1_4)
{
  signed int t1_6;
  signed int t2_7;
  signed int t6_11;
  signed int a_13;
  signed int b_14;
  signed int x_15;
  signed int t10;
  signed int t13;
  signed int t15;
  signed int t17;
  signed int t23;
  signed int a_13$11;
  signed int b_14$11;
  signed int t8$11;
  signed int t9$21;
  signed int t10$21;
  signed int t10$31;
  signed int t1_6$41;
  signed int t11$41;
  signed int t12$51;
  signed int t13$51;
  signed int t13$61;
  signed int t2_7$71;
  signed int t14$71;
  signed int t15$81;
  signed int t15$91;
  signed int x_15$101;
  signed int t16$101;
  signed int t17$111;
  signed int t17$121;
  signed int y_16$131;
  signed int t18$131;
  signed int t3_8$131;
  signed int t19$131;
  signed int t4_9$131;
  signed int t20$131;
  signed int t5_10$131;
  signed int t21$131;
  signed int t6_11$131;
  signed int t22$131;
  signed int t23$141;
  signed int t23$151;
  signed int t7_12$161;

t23_lab1:
  a_13$11 = in1_2;
  b_14$11 = in2_3;
  if (a_13$11 > 0)
    t8$11 = 1;
  else
    t8$11 = 0;
  a_13 = a_13$11;
  b_14 = b_14$11;
  if (t8$11 != 0) {goto LL1;} else {goto S_00001_X;}
S_00001_X:
  t9$21 = ~(a_13) + 1;
  t10$21 = t9$21;
  t10 = t10$21;
  goto LL2;
LL1:
  t10$31 = a_13;
  t10 = t10$31;
  goto LL2;
LL2:
  t1_6$41 = t10;
  if (b_14 > 0)
    t11$41 = 1;
  else
    t11$41 = 0;
  t1_6 = t1_6$41;
  if (t11$41 != 0) {goto LL3;} else {goto S_00002_X;}
S_00002_X:
  t12$51 = ~(b_14) + 1;
  t13$51 = t12$51;
  t13 = t13$51;
  goto LL4;
LL3:
  t13$61 = b_14;
  t13 = t13$61;
  goto LL4;
LL4:
  t2_7$71 = t13;
  if (t1_6 > t2_7$71)
    t14$71 = 1;
  else
    t14$71 = 0;
  t2_7 = t2_7$71;
  if (t14$71 != 0) {goto LL5;} else {goto S_00003_X;}
S_00003_X:
  t15$81 = t2_7;
  t15 = t15$81;
  goto LL6;
LL5:
  t15$91 = t1_6;
  t15 = t15$91;
  goto LL6;
LL6:
  x_15$101 = t15;
  if (t1_6 < t2_7)
    t16$101 = 1;
  else
    t16$101 = 0;
  x_15 = x_15$101;
  if (t16$101 != 0) {goto LL7;} else {goto S_00004_X;}
S_00004_X:
  t17$111 = t2_7;
  t17 = t17$111;
  goto LL8;
LL7:
  t17$121 = t1_6;
  t17 = t17$121;
  goto LL8;
LL8:
  y_16$131 = t17;
  t18$131 = x_15 >> 3;
  t3_8$131 = t18$131;
  t19$131 = y_16$131 >> 1;
  t4_9$131 = t19$131;
  t20$131 = x_15 - t3_8$131;
  t5_10$131 = t20$131;
  t21$131 = t4_9$131 + t5_10$131;
  t6_11$131 = t21$131;
  if (t6_11$131 > x_15)
    t22$131 = 1;
  else
    t22$131 = 0;
  t6_11 = t6_11$131;
  if (t22$131 != 0) {goto LL9;} else {goto S_00005_X;}
S_00005_X:
  t23$141 = x_15;
  t23 = t23$141;
  goto LL10;
LL9:
  t23$151 = t6_11;
  t23 = t23$151;
  goto LL10;
LL10:
  t7_12$161 = t23;
  *out1_4 = t7_12$161;
}
