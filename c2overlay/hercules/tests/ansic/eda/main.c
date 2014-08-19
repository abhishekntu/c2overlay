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
  FILE *eda_data;
  int err_cnt = 0;
  int line_cnt = 0;
  signed int in1_2;
  signed int in2_3;
  signed int out1_4;
  signed int out1_4_ref;
  eda_data = fopen("eda_test_data.txt", "r");
  while (!feof(eda_data))
  {
    fscanf(eda_data, "%08x %08x %08x ", &in1_2, &in2_3, &out1_4_ref);
    line_cnt++;
    eda (in1_2, in2_3, &out1_4);
    if (out1_4 != out1_4_ref)
    {
      fprintf(stderr,"Error: (%04d) out1_4=%08x, instead of %08x.\n", line_cnt, out1_4, out1_4_ref);
      err_cnt++;
    }
  }
  if (err_cnt == 0) {
    fprintf(stderr,"eda passed all tests.\n");
  } else {
    fprintf(stderr,"eda FAILED. Number of errors: %d\n", err_cnt);
  }

  fclose(eda_data);
  return 0;
}
