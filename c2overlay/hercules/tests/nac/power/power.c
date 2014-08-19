/*
 * Filename: power.c
 * Purpose : C implementation of a powering function with some optimizations.
 * Author  : Nikolaos Kavvadias (C) 2011, 2012, 2013
 * Date    : 19-Apr-2011
 * Revision: 0.3.0 (19/04/11)
 *           Initial version.
 */ 
 
#ifdef TEST
#include <stdio.h>
#endif

int power(int base, int exponent)
{
  int r, b, e;
  b = base;
  e = exponent;
  if (e == 0) {
    r = 1;
  } else if (e == 1) {
    r = b;
  } else if (b == 2) {
    r = b << (e-1);
  } else {
    r = 1;
    while (e > 0) {
      if (e % 2 == 1) {
        r *= b;
      }
      b *= b;
      e /= 2;
    }
  }
  result = r;
  return (result);
}

#ifdef TEST
int main()
{
  int i, j;
  int result;

  for (i = 0; i < 10; i++)
  {
    for (j = 0; j < 10; j++)
    {
      result = power(i, j);
      printf("%08x %08x %08x\n", i, j, result);
//      printf("%d %d %d\n", i, j, result);
    }
  }  
  return 0;
}
#endif
