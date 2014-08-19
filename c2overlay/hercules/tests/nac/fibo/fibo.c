/*
 * Filename: fibo.c
 * Purpose : Iterative approach to computing the Fibonacci series up to the N-th 
 *           member, written in ANSI C.
 * Author  : Nikolaos Kavvadias (C) 2009, 2010, 2011, 2012, 2013
 * Date    : 17-Sep-2009
 * Revision: 0.2.0 (17/09/09)
 *           Initial version.
 */ 

#ifdef TEST
#include <stdio.h>
#endif

#define MAX_NUM  32


int fibo(int x)
{
  int f0, f1, f, k;
  int outp;
  
  f0 = 0;
  f1 = 1;
  
  if (x <= 0) {
    outp = f0;
  } else if (x == 1) {
    outp = f1;
  } else {
    for (k = 2; k <= x; k++) {
      f = f1 + f0;
      f0 = f1;
      f1 = f;
    }
    outp = f;
  }
  return outp;
}

#ifdef TEST
int main(void)
{
  int i;
  int result;
  for (i = 0; i <= MAX_NUM; i++) {
    result = fibo(i);
    printf("%08x %08x\n", i, result);
  }  
  return 0;
}
#endif
