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
  FILE *gcd_data;
  int err_cnt = 0;
  int line_cnt = 0;
  unsigned int a;
  unsigned int b;
  unsigned short outp;
  unsigned short outp_ref;
  gcd_data = fopen("gcd_test_data.txt", "r");
  while (!feof(gcd_data))
  {
    fscanf(gcd_data, "%04x %04x %04x ", &a, &b, &outp_ref);
    line_cnt++;
    gcd (a, b, &outp);
    if (outp != outp_ref)
    {
      fprintf(stderr,"Error: (%04d) outp=%04x, instead of %04x.\n", line_cnt, outp, outp_ref);
      err_cnt++;
    }
  }
  if (err_cnt == 0) {
    fprintf(stderr,"gcd passed all tests.\n");
  } else {
    fprintf(stderr,"gcd FAILED. Number of errors: %d\n", err_cnt);
  }

  fclose(gcd_data);
  return 0;
}
