/*
 * Filename: c2vsumarray.c
 * Purpose : 1D wavelet transform.
 * Author  : Nikolaos Kavvadias (C) 2011, 2012
 *           Original source: http://www.c-to-verilog.com
 * Date    : 17-Apr-2011
 * Revision: 0.3.0 (17/04/11)
 *           Initial version.
 */
#ifdef TEST
#include <stdio.h>
#endif

#define MAX 16

#ifdef ALGO
void c2vwavelet(unsigned int length, unsigned int *y)  {
    static unsigned int input[MAX]={1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16};
    static unsigned int output[MAX];
    unsigned int len, i, sum, difference;
    //This function assumes input.length=2^n, n>1
    for (len = length >> 1; len > 1 ; len >>= 1) {
        //length=2^n, WITH DECREASING n
        for (i = 0; i < len; i++) {
            sum = input[i*2]+input[i*2+1];
            difference = input[i*2]-input[i*2+1];
            output[i] = sum;
            output[len+i] = difference;
        }
    }
    *y = 1;
}
#endif

#ifdef TEST
int main(void)
{
  unsigned int result;
  c2vwavelet(MAX, &result);
  printf("%08x %08x\n", MAX, result);
  return 0;
}
#endif
