/*
 * Filename: gcd.c
 * Purpose : C implementation for the greatest common divisor (GCD) algorithm.
 *           To compile the low-level C version use the following GCC options
 *             "-DTEST -DLOWLEVEL -O2".
 *           To compile the algorithmic version use
 *             "-DTEST -DALGORITHMIC -O2".
 * Author  : Nikolaos Kavvadias (C) 2009, 2010, 2011, 2012, 2013
 * Date    : 29-Dec-2010
 * Revision: 0.1.0 (13/08/09)
 *           Initial version.
 *           0.3.0 (29/12/10)
 *           Added normative main() implementation. Kept previous version
 *           under ifndef TEST for conditional compilation.
 */ 

#ifdef TEST
#include <stdio.h>
#endif

short unsigned int gcd(short unsigned int a, short unsigned int b)
{
  short unsigned int result = 0;
  short unsigned int x, y;
  
  x = a;
  y = b;
  
  if ((x!=0) && (y!=0))
  {
    while (x != y)
    {
      if (x >= y)
      {
        x = x - y;
      }
      else
      {
        y = y - x;
      }
    }
    result = x;
  }
  else
  {
    result = 0;
  }
  
  return (result);
}

#ifdef TEST
int main()
{
  int i, j;
  int result;
  for (i = 1; i <= 64; i++)
  {
    for (j = 1; j <= i; j++)
    {	  
      result = gcd(i, j);
      printf("%04x %04x %04x\n", i, j, result);
    }    
  }  
  return 0;
}
#endif
