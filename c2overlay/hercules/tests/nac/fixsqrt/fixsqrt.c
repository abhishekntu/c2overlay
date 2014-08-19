/*
 * Filename: fixsqrt.c
 * Purpose : C implementation for for an accurate fixed-point square root 
 *           proposed by Ken Turkowski. A technical report detailing the 
 *           algorithm can be found here: 
 *           http://www.worldserver.com/turk/computergraphics/FixedSqrt.pdf
 *           To compile use the following GCC options
 *             "-DTEST -O2".
 * Author  : Nikolaos Kavvadias (C) 2010, 2011, 2012, 2013
 * Date    : 29-Oct-2010
 * Revision: 0.3.0 (29/10/10)
 *           Initial version.
 */ 

#ifdef TEST
#include <stdio.h>
#endif

void fixsqrt(unsigned int x, unsigned int fracbits, unsigned int *root)
{
  unsigned int troot, remHi, remLo, testDiv, count;

  troot = 0;        /* Clear root */
  remHi = 0;        /* Clear high part of partial remainder */
  remLo = x;        /* Get argument into low part of partial remainder */
  count = 15 + (fracbits >> 1);    /* Load loop counter */

  do 
  {
    remHi = (remHi << 2) | (remLo >> fracbits); 
    remLo <<= 2;  /* get 2 bits of arg */
    troot <<= 1;   /* Get ready for the next bit in the root */
    testDiv = (troot << 1) + 1;    /* Test radical */
    if (remHi >= testDiv) {
      remHi -= testDiv;
      troot += 1;
    }
  } while (count-- != 0);
  *root = troot;
}

#ifdef TEST
int main()
{
  unsigned int i, fbits, result;

  for (i = 0; i <= 65535; i++)
  {
	fbits = 30;
    fixsqrt(i, fbits, &result);
    printf("%08x %08x %08x\n", i, fbits, result);
  }
  
  return 0;
}
#endif
