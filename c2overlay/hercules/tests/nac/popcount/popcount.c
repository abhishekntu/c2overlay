/*
 * Filename: popcount.c
 * Purpose : C implementation for the "ones' count" (also known as population
 *           count) algorithm. This algorithm computes the number of 1's present 
 *           in the given input word.
 * Author  : Nikolaos Kavvadias (C) 2009, 2010, 2011, 2012, 2013
 * Date    : 30-Aug-2009
 * Revision: 0.1.0 (13/08/09)
 *           Initial version.
 *           0.1.1 (30/08/09)
 *           Added the ALGORITHMIC version of the population count algorithm.
 */ 

#ifdef TEST
#include <stdio.h>
#endif

int popcount(int inp)
{
  int data, count;
  data = inp;
  count = 0;
  while (data != 0)
  {
    count = count + (data & 0x1);
    data = data >> 0x1;
  }  
  return count;
}

#ifdef TEST
int main()
{
  int i;
  int result;
  for (i = 0; i <= 255; i++)
  {
    result = popcount(i);
    printf("%08x %08x\n", i, result);
  }  
  return 0;
}
#endif
