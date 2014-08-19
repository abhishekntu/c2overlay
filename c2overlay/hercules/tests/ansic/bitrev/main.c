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
  FILE *bitrev_data;
  int err_cnt = 0;
  int line_cnt = 0;
  unsigned int inp;
  unsigned char D_1377;
  unsigned char D_1377_ref;
  bitrev_data = fopen("bitrev_test_data.txt", "r");
  while (!feof(bitrev_data))
  {
    fscanf(bitrev_data, "%02x %02x ", &inp, &D_1377_ref);
    line_cnt++;
    bitrev (inp, &D_1377);
    if (D_1377 != D_1377_ref)
    {
      fprintf(stderr,"Error: (%04d) D_1377=%02x, instead of %02x.\n", line_cnt, D_1377, D_1377_ref);
      err_cnt++;
    }
  }
  if (err_cnt == 0) {
    fprintf(stderr,"bitrev passed all tests.\n");
  } else {
    fprintf(stderr,"bitrev FAILED. Number of errors: %d\n", err_cnt);
  }

  fclose(bitrev_data);
  return 0;
}
