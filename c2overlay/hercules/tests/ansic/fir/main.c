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
  FILE *fir_data;
  int err_cnt = 0;
  int line_cnt = 0;
  signed int out1;
  signed int out1_ref;
  fir_data = fopen("fir_test_data.txt", "r");
  while (!feof(fir_data))
  {
    fscanf(fir_data, "%08x ", &out1_ref);
    line_cnt++;
    fir (&out1);
    if (out1 != out1_ref)
    {
      fprintf(stderr,"Error: (%04d) out1=%08x, instead of %08x.\n", line_cnt, out1, out1_ref);
      err_cnt++;
    }
  }
  if (err_cnt == 0) {
    fprintf(stderr,"fir passed all tests.\n");
  } else {
    fprintf(stderr,"fir FAILED. Number of errors: %d\n", err_cnt);
  }

  fclose(fir_data);
  return 0;
}
