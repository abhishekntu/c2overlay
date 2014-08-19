#include <stdio.h>
#include <math.h>
#include "main.h"
unsigned int h_Input[16] = {
  1,
  2,
  3,
  4,
  5,
  6,
  7,
  8,
  9,
  10,
  11,
  12,
  13,
  14,
  15,
  16
};
unsigned int h_Output[16] = {
};
void c2vwalsh (unsigned int log2N, unsigned int *y)
{
  unsigned int pos;
  unsigned int stride;
  unsigned int base;
  unsigned int j;
  unsigned int N;
  unsigned int k$11;
  signed int log2N_0$11;
  unsigned int N$11;
  unsigned int pos$11;
  unsigned int D_1389$21;
  unsigned int pos$21;
  unsigned int stride$41;
  unsigned int base$51;
  unsigned int j$61;
  unsigned int i0$71;
  unsigned int D_1390$71;
  unsigned int i1$71;
  unsigned int T1$71;
  unsigned int T2$71;
  unsigned int D_1391$71;
  unsigned int D_1392$71;
  unsigned int j$71;
  unsigned int D_1393$91;
  unsigned int base$91;
  unsigned int stride$111;

L0005:
  k$11 = 1;
  log2N_0$11 = (signed int)(log2N);
  N$11 = k$11 << log2N_0$11;
  pos$11 = 0;
  pos = pos$11;
  N = N$11;
  goto D_1376;
D_1375:
  D_1389$21 = h_Input[pos];
  h_Output[pos] = D_1389$21;
  pos$21 = pos + 1;
  pos = pos$21;
  goto D_1376;
D_1376:
  if (pos < N) {goto D_1375;} else {goto D_1377;}
D_1377:
  stride$41 = N / 2;
  stride = stride$41;
  goto D_1385;
D_1384:
  base$51 = 0;
  base = base$51;
  goto D_1382;
D_1381:
  j$61 = 0;
  j = j$61;
  goto D_1379;
D_1378:
  i0$71 = base + j;
  D_1390$71 = base + j;
  i1$71 = D_1390$71 + stride;
  T1$71 = h_Output[i0$71];
  T2$71 = h_Output[i1$71];
  D_1391$71 = T1$71 - T2$71;
  h_Output[i1$71] = D_1391$71;
  D_1392$71 = T1$71 + T2$71;
  h_Output[i0$71] = D_1392$71;
  j$71 = j + 1;
  j = j$71;
  goto D_1379;
D_1379:
  if (j < stride) {goto D_1378;} else {goto D_1380;}
D_1380:
  D_1393$91 = (unsigned int)stride * (unsigned int)2;
  base$91 = D_1393$91 + base;
  base = base$91;
  goto D_1382;
D_1382:
  if (base < N) {goto D_1381;} else {goto D_1383;}
D_1383:
  stride$111 = stride >> 1;
  stride = stride$111;
  goto D_1385;
D_1385:
  if (stride != 0) {goto D_1384;} else {goto D_1386;}
D_1386:
  *y = 1;
  goto L_EXIT;
L_EXIT:
  /* NOP */;
}
