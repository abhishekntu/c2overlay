#include <stdio.h>
#include <math.h>
#include "main.h"
void checkpixel (signed int x, signed int y, signed int *flag)
{
  signed int real;
  signed int imag;
  signed int iter;
  signed int f;
  signed int f$11;
  signed int real$11;
  signed int imag$11;
  signed int iter$11;
  signed int D_1391$21;
  signed int D_1392$21;
  signed int D_1393$21;
  signed int D_1394$21;
  signed int D_1395$21;
  signed int D_1396$21;
  signed int D_1397$21;
  signed int temp$21;
  signed int D_1398$21;
  signed int D_1399$21;
  signed int D_1400$21;
  signed int D_1401$21;
  signed int imag$21;
  signed int real$21;
  signed int D_1402$21;
  signed int D_1403$21;
  signed int D_1404$21;
  signed int f$31;
  signed int iter$41;

L0005:
  f$11 = 1;
  real$11 = 0;
  imag$11 = 0;
  iter$11 = 0;
  real = real$11;
  imag = imag$11;
  iter = iter$11;
  f = f$11;
  goto D_1371;
D_1370:
  D_1391$21 = (signed int)real * (signed int)real;
  D_1392$21 = D_1391$21 + 500;
  D_1393$21 = D_1392$21 / 1000;
  D_1394$21 = (signed int)imag * (signed int)imag;
  D_1395$21 = D_1394$21 + 500;
  D_1396$21 = D_1395$21 / -1000;
  D_1397$21 = D_1393$21 + D_1396$21;
  temp$21 = D_1397$21 + x;
  D_1398$21 = (signed int)real * (signed int)2;
  D_1399$21 = (signed int)D_1398$21 * (signed int)imag;
  D_1400$21 = D_1399$21 + 500;
  D_1401$21 = D_1400$21 / 1000;
  imag$21 = D_1401$21 + y;
  real$21 = temp$21;
  if (real$21 < 0)
    D_1402$21 = -(real$21);
  else
    D_1402$21 = real$21;
  if (imag$21 < 0)
    D_1403$21 = -(imag$21);
  else
    D_1403$21 = imag$21;
  D_1404$21 = D_1402$21 + D_1403$21;
  real = real$21;
  imag = imag$21;
  if (D_1404$21 > 5000) {goto D_1405;} else {goto D_1406;}
D_1405:
  f$31 = 0;
  f = f$31;
  goto D_1369;
D_1406:
  iter$41 = iter + 1;
  iter = iter$41;
  goto D_1371;
D_1371:
  if (iter <= 254) {goto D_1370;} else {goto D_1369;}
D_1369:
  *flag = f;
  goto L_EXIT;
L_EXIT:
  /* NOP */;
}
