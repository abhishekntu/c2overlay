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
  FILE *c2vwavelet_data;
  int err_cnt = 0;
  int line_cnt = 0;
  unsigned int length;
  unsigned int y;
  unsigned int y_ref;
  c2vwavelet_data = fopen("c2vwavelet_test_data.txt", "r");
  while (!feof(c2vwavelet_data))
  {
    fscanf(c2vwavelet_data, "%08x %08x ", &length, &y_ref);
    line_cnt++;
    c2vwavelet (length, &y);
    if (y != y_ref)
    {
      fprintf(stderr,"Error: (%04d) y=%08x, instead of %08x.\n", line_cnt, y, y_ref);
      err_cnt++;
    }
  }
  if (err_cnt == 0) {
    fprintf(stderr,"c2vwavelet passed all tests.\n");
  } else {
    fprintf(stderr,"c2vwavelet FAILED. Number of errors: %d\n", err_cnt);
  }

  fclose(c2vwavelet_data);
  return 0;
}
