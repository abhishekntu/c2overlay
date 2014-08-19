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
  FILE *sierpinski_data;
  int err_cnt = 0;
  int line_cnt = 0;
  signed int tot;
  signed int tot_ref;
  sierpinski_data = fopen("sierpinski_test_data.txt", "r");
  while (!feof(sierpinski_data))
  {
    fscanf(sierpinski_data, "%08x ", &tot_ref);
    line_cnt++;
    sierpinski (&tot);
    if (tot != tot_ref)
    {
      fprintf(stderr,"Error: (%04d) tot=%08x, instead of %08x.\n", line_cnt, tot, tot_ref);
      err_cnt++;
    }
  }
  if (err_cnt == 0) {
    fprintf(stderr,"sierpinski passed all tests.\n");
  } else {
    fprintf(stderr,"sierpinski FAILED. Number of errors: %d\n", err_cnt);
  }

  fclose(sierpinski_data);
  return 0;
}
