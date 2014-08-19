/*
 * Filename: bitrev.c
 * Purpose : C implementation for a bit-reversal operation on unsigned chars.
 *           To compile the low-level C version use the following GCC options
 *             "-DTEST -DLOWLEVEL -O2".
 *           To compile the algorithmic version use
 *             "-DTEST -DALGORITHMIC -O2".
 * Author  : Nikolaos Kavvadias (C) 2009
 * Date    : 30-Sep-2009
 * Revision: 0.2.0 (30/09/09)
 *           Initial version.
 */ 

#ifdef TEST
#include <stdio.h>
#endif

#ifdef ALGO
unsigned char bitrev(unsigned char inp)
{
  unsigned char i, temp = 0;  
  for (i = 0; i < 8; i++) {
    temp |= (((inp>>i)&1) << (7-i));
  }  
  return temp;
}
#endif

#ifdef TEST
int main()
{
  int i;
  unsigned char result;

  for (i = 0; i <= 255; i++)
  {
    result = bitrev((unsigned char)i);
    printf("%02x %02x\n", i, result);
  }
  
  return 0;
}
#endif
