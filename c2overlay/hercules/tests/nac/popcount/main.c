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
  FILE *popcount_data;
  int err_cnt = 0;
  int line_cnt = 0;
  unsigned int inp;
  unsigned int outp;
  unsigned int outp_ref;
  popcount_data = fopen("popcount_test_data.txt", "r");
  while (!feof(popcount_data))
  {
    fscanf(popcount_data, "%08x %08x ", &inp, &outp_ref);
    line_cnt++;
    popcount (inp, &outp);
    if (outp != outp_ref)
    {
      fprintf(stderr,"Error: (%04d) outp=%08x, instead of %08x.\n", line_cnt, outp, outp_ref);
      err_cnt++;
    }
  }
  if (err_cnt == 0) {
    fprintf(stderr,"popcount passed all tests.\n");
  } else {
    fprintf(stderr,"popcount FAILED. Number of errors: %d\n", err_cnt);
  }

  fclose(popcount_data);
  return 0;
}
