#include <stdio.h>
#include <math.h>
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
  FILE *fibo_data;
  int err_cnt = 0;
  int line_cnt = 0;
  unsigned int n;
  unsigned int outp;
  unsigned int outp_ref;
  fibo_data = fopen("fibo_test_data.txt", "r");
  while (!feof(fibo_data))
  {
    fscanf(fibo_data, "%08x %08x ", &n, &outp_ref);
    line_cnt++;
    fibo (n, &outp);
    if (outp != outp_ref)
    {
      fprintf(stderr,"Error: (%04d) outp=%08x, instead of %08x.\n", line_cnt, outp, outp_ref);
      err_cnt++;
    }
  }
  if (err_cnt == 0) {
    fprintf(stderr,"fibo passed all tests.\n");
  } else {
    fprintf(stderr,"fibo FAILED. Number of errors: %d\n", err_cnt);
  }

  fclose(fibo_data);
  return 0;
}
