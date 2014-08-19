/*
 * Filename: arraysum.c
 * Purpose : Sum the contents of an integer array. 
 * Author  : Nikolaos Kavvadias (C) 2012, 2013
 * Date    : 01-Jun-2012
 * Revision: 0.4.0 (06/01/12)
 *           Initial version.
 */ 
#ifdef TEST
#include <stdio.h>
#endif

void arraysum(int in1, int *out1)
{
  int i, sum = 0;
  static int arr[10]={2,3,5,7,11,13,17,19,23,27};
  for (i = 0; i < in1; i++)
  {
    sum += arr[i];
  }
  *out1 = sum;
}

#ifdef TEST
int main(void)
{
  int res;
  int i;  
  for (i = 0; i < 10; i++)
  {
    arraysum(i, &res);
    printf("%08x %08x\n", i, res);
  }
  return 0;
}
#endif
