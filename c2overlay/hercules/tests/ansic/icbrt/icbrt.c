/*
 * Filename: icbrt.c
 * Purpose : C implementation for an integer cubic root approximation algorithm.
 *           To compile use the following GCC options
 *             "-DTEST -O2".
 * Author  : Nikolaos Kavvadias (C) 2011, 2012, 2013
 * Date    : 24-Sep-2011
 * Revision: 0.3.0 (24/09/11)
 *           Initial version.
 */ 

#ifdef TEST
#include <stdio.h>
#endif

#ifdef ALGO
void icbrt(unsigned int x, int *res) 
{
  int s; 
  unsigned int y, b, x0; 
 
  s = 30; 
  y = 0; 
  x0 = x;
  while (s >= 0) {              // Do 11 times. 
    y = 2*y; 
    b = (3*y*(y + 1) + 1) << s; 
    s = s - 3; 
    if (x0 >= b) {
      x0 = x0 - b; 
      y = y + 1; 
    } 
  } 
  *res = y; 
} 
#endif

#ifdef TEST
int main(void)
{
  unsigned int i;
  int result;

//  for (i = 0; i <= 65535; i++)
  for (i = 0; i <= 2048; i++)
  {
    icbrt(i, &result);
    printf("%08x %08x\n", i, result);
  }
  
  return 0;
}
#endif
