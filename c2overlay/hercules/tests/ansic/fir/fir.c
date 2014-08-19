/****************************************************************/
/*   FIR Filter                                                 */
/*   Expected Result  out = 0x23                                */
/*   Required Cycles  728                                       */
/****************************************************************/

#ifdef TEST
#include <stdio.h>
#endif

#define DIM 10
#define TAPS 8


#ifdef ALGO
void fir(int *out1)
{
  static int v[DIM]  = {0,1,0,1,2,1,0,0,1,1};
  static int a[TAPS] = {1,2,0,1,0,2,1,1};
  int i,j,acc=0;

  for (i=DIM-1; i>=0; i--)
  {
    for (j=TAPS-1; j>=0; j--)
    {
      if (j<=i)
      {
        acc += v[i-j]*a[j];
      }
    }
  }
  *out1 = acc;
}
#endif

#ifdef TEST
int main(void)
{
  int result;
  fir(&result);
  printf("%08x\n", result);
  return 0;
}
#endif
