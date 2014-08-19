/*
 * Filename: fibo.c
 * Purpose : Iterative approach to computing the Fibonacci series up to the N-th 
 *           member, written in ANSI C.
 * Author  : Nikolaos Kavvadias (C) 2009, 2010, 2011, 2012, 2013
 * Date    : 29-May-2013
 * Revision: 0.2.0 (17/09/09)
 *           Initial version.
 *           0.4.0 (29/05/13)
 *           Initial version.
 */ 

#ifdef TEST
#include <stdio.h>
#endif

#define MAX_NUM  47

#ifdef ALGO
unsigned int fibo(unsigned int x)
{
  unsigned int f0, f1, k;  
  unsigned int f;
  f0 = 0;
  f1 = 1; 
  k = 2;
  do {
    k = k + 1;
    f = f1 + f0;
    f0 = f1;
    f1 = f;
  } while (k <= x);
  return (f);
}
#endif

#ifdef TEST
int main(void)
{
  int i;
  int result;
  for (i = 1; i <= MAX_NUM; i++)
  {
    result = fibo(i);
    printf("%08x %08x\n", i, result);
  }  
  return 0;
}
#endif
