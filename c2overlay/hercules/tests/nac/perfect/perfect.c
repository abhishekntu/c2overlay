/*
 * Filename: perfect.c
 * Purpose : C implementation of a naive algorithm for detecting perfect 
 *           numbers. A perfect (positive integer) number is equal to the sum of 
 *           its divisors. The first members of this sequence are: 
 *           6, 28, 496, 8128.
 *           To compile the low-level C version use the following GCC options
 *             "-DTEST -DLOWLEVEL -O2".
 *           To compile the algorithmic version use
 *             "-DTEST -DALGORITHMIC -O2".
 * Author  : Nikolaos Kavvadias (C) 2010, 2011, 2012, 2013
 * Date    : 17-Apr-2010
 * Revision: 0.3.0 (17/04/10)
 *           Initial version.
 */ 

#ifdef TEST
#include <stdio.h>
#endif


unsigned short int perfect(unsigned short int value)
{
  unsigned short int factorsum = 1, i, isperfect;
  
  for (i = 2; i <= value/2; i++)
  {
    if (value % i == 0)
    {
      factorsum += i;
    }
  }
  
  if (factorsum == value)
  {
    isperfect = 1;
  }
  else
  {
    isperfect = 0;
  }
  return (isperfect);
}

#ifdef TEST
int main()
{
  int i;
  int result;

  for (i = 2; i <= 65535; i++)
  {
    result = perfect(i);
//    if (result == 1) {
      printf("%04x %04x\n", i, result);
//    }
  }
  
  return 0;
}
#endif
