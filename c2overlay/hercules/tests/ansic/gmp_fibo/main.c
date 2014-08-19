#include <stdio.h>
#include <math.h>
#include "fgmp.h"
#include "main.h"

int floatEqualComparison(float A, float B, float maxRelDiff)
{
  float largest, diff = fabs(A-B);
  A = fabs(A);
  B = fabs(B);
  largest = (B > A) ? B : A;
  if (diff <= largest * maxRelDiff) {
    return 1;
  }
  return 0;
}

int doubleEqualComparison(double A, double B, double maxRelDiff)
{
  double largest, diff = fabs(A-B);
  A = fabs(A);
  B = fabs(B);
  largest = (B > A) ? B : A;
  if (diff <= largest * maxRelDiff) {
    return 1;
  }
  return 0;
}

int main(void)
{
  FILE *gmp_fibo_data;
  int err_cnt = 0;
  int line_cnt = 0;
  unsigned int n;
  signed int D_2845;
  signed int D_2845_ref;
  gmp_fibo_data = fopen("gmp_fibo_test_data.txt", "r");
  while (!feof(gmp_fibo_data))
  {
    fscanf(gmp_fibo_data, "%08x %08x ", &n, &D_2845_ref);
    line_cnt++;
    gmp_fibo (n, &D_2845);
    if (D_2845 != D_2845_ref)
    {
      fprintf(stderr,"Error: (%04d) D_2845=%08x, instead of %08x.\n", line_cnt, D_2845, D_2845_ref);
      err_cnt++;
    }
  }
  if (err_cnt == 0) {
    fprintf(stderr,"gmp_fibo passed all tests.\n");
  } else {
    fprintf(stderr,"gmp_fibo FAILED. Number of errors: %d\n", err_cnt);
  }

  fclose(gmp_fibo_data);
  return 0;
}
