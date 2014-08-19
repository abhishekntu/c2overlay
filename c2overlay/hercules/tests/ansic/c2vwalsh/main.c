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
  FILE *c2vwalsh_data;
  int err_cnt = 0;
  int line_cnt = 0;
  unsigned int log2N;
  unsigned int y;
  unsigned int y_ref;
  c2vwalsh_data = fopen("c2vwalsh_test_data.txt", "r");
  while (!feof(c2vwalsh_data))
  {
    fscanf(c2vwalsh_data, "%08x %08x ", &log2N, &y_ref);
    line_cnt++;
    c2vwalsh (log2N, &y);
    if (y != y_ref)
    {
      fprintf(stderr,"Error: (%04d) y=%08x, instead of %08x.\n", line_cnt, y, y_ref);
      err_cnt++;
    }
  }
  if (err_cnt == 0) {
    fprintf(stderr,"c2vwalsh passed all tests.\n");
  } else {
    fprintf(stderr,"c2vwalsh FAILED. Number of errors: %d\n", err_cnt);
  }

  fclose(c2vwalsh_data);
  return 0;
}
