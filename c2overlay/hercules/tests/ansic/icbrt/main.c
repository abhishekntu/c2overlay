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
  FILE *icbrt_data;
  int err_cnt = 0;
  int line_cnt = 0;
  unsigned int x;
  signed int res;
  signed int res_ref;
  icbrt_data = fopen("icbrt_test_data.txt", "r");
  while (!feof(icbrt_data))
  {
    fscanf(icbrt_data, "%08x %08x ", &x, &res_ref);
    line_cnt++;
    icbrt (x, &res);
    if (res != res_ref)
    {
      fprintf(stderr,"Error: (%04d) res=%08x, instead of %08x.\n", line_cnt, res, res_ref);
      err_cnt++;
    }
  }
  if (err_cnt == 0) {
    fprintf(stderr,"icbrt passed all tests.\n");
  } else {
    fprintf(stderr,"icbrt FAILED. Number of errors: %d\n", err_cnt);
  }

  fclose(icbrt_data);
  return 0;
}
