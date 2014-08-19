/*
 * Filename: isqrt.c
 * Purpose : C implementation for an integer square root approximation 
 *           algorithm as found in "Hacker's Delight".
 * Author  : Nikolaos Kavvadias (C) 2009, 2010, 2011, 2012
 * Date    : 27-Oct-2009
 * Revision: 0.3.0 (27/10/09)
 *           Initial version.
 */ 

#ifdef TEST
#include <stdio.h>
#endif

#define  MAXBITS    32

void isqrt(unsigned int x, unsigned int *outp)
{
  unsigned int m, y, b, x0; 
  
  m = 0x1 << (MAXBITS-2);
  y = 0;
  x0 = x;
  
  while (m != 0)
  {
    b = y | m; 
    y = y >> 1; 
    
    if (x0 >= b) 
    {
      x0 = x0 - b; 
      y = y | m; 
    } 
    m = m >> 2; 
  } 
  
  *outp = y;
}

#ifdef TEST
int main(void)
{
  unsigned int i, result;
//  for (i = 0; i <= 65535; i++)
  for (i = 0; i <= 2048; i++)
  {
    isqrt(i, &result);
    printf("%08x %08x\n", i, result);
  }  
  return 0;
}
#endif
