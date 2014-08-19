/*
 * Filename: c2vwalsh.c
 * Purpose : 1D Walsh tranform.
 * Author  : Nikolaos Kavvadias (C) 2011, 2012, 2013
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
void c2vwalsh(unsigned int log2N, unsigned int *y){
    static unsigned int h_Input[MAX]={1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16};
    static unsigned int h_Output[MAX];
    unsigned int pos, stride, base, j, i0, i1, T1, T2, k = 1;
    unsigned int N = k << log2N;
    for(pos = 0; pos < N; pos++) h_Output[pos] = h_Input[pos];

    //Cycle through stages with different butterfly strides
    for(stride = N / 2; stride >= 1; stride >>= 1){
        //Cycle through subvectors of (2 * stride) elements
        for(base = 0; base < N; base += 2 * stride)
            //Butterfly index within subvector of (2 * stride) size
            for(j = 0; j < stride; j++){
                i0 = base + j +      0;
                i1 = base + j + stride;
                T1 = h_Output[i0];
                T2 = h_Output[i1];
                h_Output[i1] = T1 - T2;
                h_Output[i0] = T1 + T2;
            }
    }
   *y = 1;
} 
#endif

#ifdef TEST
int main(void)
{
  unsigned int result;
  c2vwalsh(4, &result);
  printf("%08x %08x\n", 4, result);
  return 0;
}
#endif
