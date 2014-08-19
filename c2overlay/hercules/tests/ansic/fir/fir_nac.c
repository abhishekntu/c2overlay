#include <stdio.h>
#include <math.h>
#include "main.h"
signed int v[10] = {
  0,
  1,
  0,
  1,
  2,
  1,
  0,
  0,
  1,
  1
};
signed int a[8] = {
  1,
  2,
  0,
  1,
  0,
  2,
  1,
  1
};
void fir (signed int *out1)
{
  signed int i;
  signed int j;
  signed int acc;
  signed int acc$11;
  signed int i$11;
  signed int j$21;
  signed int D_1376$41;
  signed int D_1377$41;
  signed int D_1378$41;
  signed int D_1379$41;
  signed int acc$41;
  signed int j$51;
  signed int i$71;

L0005:
  acc$11 = 0;
  i$11 = 9;
  i = i$11;
  acc = acc$11;
  goto D_1371;
D_1370:
  j$21 = 7;
  j = j$21;
  goto D_1368;
D_1367:
  if (j <= i) {goto D_1374;} else {goto D_1375;}
D_1374:
  D_1376$41 = i - j;
  D_1377$41 = v[D_1376$41];
  D_1378$41 = a[j];
  D_1379$41 = (signed int)D_1377$41 * (signed int)D_1378$41;
  acc$41 = D_1379$41 + acc;
  acc = acc$41;
  goto D_1375;
D_1375:
  j$51 = j - 1;
  j = j$51;
  goto D_1368;
D_1368:
  if (j >= 0) {goto D_1367;} else {goto D_1369;}
D_1369:
  i$71 = i - 1;
  i = i$71;
  goto D_1371;
D_1371:
  if (i >= 0) {goto D_1370;} else {goto D_1372;}
D_1372:
  *out1 = acc;
  goto L_EXIT;
L_EXIT:
  /* NOP */;
}
