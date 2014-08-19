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
  FILE *gmp_fact_data;
  int err_cnt = 0;
  int line_cnt = 0;
  unsigned int n;
  signed int D_2846;
  signed int D_2846_ref;
  gmp_fact_data = fopen("gmp_fact_test_data.txt", "r");
  while (!feof(gmp_fact_data))
  {
    fscanf(gmp_fact_data, "%08x %08x ", &n, &D_2846_ref);
    line_cnt++;
    gmp_fact (n, &D_2846);
    if (D_2846 != D_2846_ref)
    {
      fprintf(stderr,"Error: (%04d) D_2846=%08x, instead of %08x.\n", line_cnt, D_2846, D_2846_ref);
      err_cnt++;
    }
  }
  if (err_cnt == 0) {
    fprintf(stderr,"gmp_fact passed all tests.\n");
  } else {
    fprintf(stderr,"gmp_fact FAILED. Number of errors: %d\n", err_cnt);
  }

  fclose(gmp_fact_data);
  return 0;
}
