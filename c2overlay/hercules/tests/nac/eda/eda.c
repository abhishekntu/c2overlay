/*
 * Filename: eda.c
 * Purpose : C implementation for a 2D Euclidean distance approximation 
 *           algorithm. Described in Daniel D. Gasjki, "Principles of Digital 
 *           Design".
 * Author  : Nikolaos Kavvadias (C) 2009, 2010, 2011, 2012
 * Date    : 08-Aug-2009
 * Revision: 0.1.0 (08/08/09)
 *           Initial version.
 */ 

#ifdef TEST
#include <stdio.h>
#include <math.h>
#endif

#define XMAX  16 //1024
#define YMAX  16 //1024

#define ABS(x)            ((x) >  0 ? (x) : (-x))
#define MAX(x, y)         ((x) >  (y) ? (x) : (y))
#define MIN(x, y)         ((x) <  (y) ? (x) : (y))


void eda(int in1, int in2, int *out1)
{
  int t1, t2, t3, t4, t5, t6, t7;
  int a, b, x, y;

  a = in1;
  b = in2;

  t1 = ABS(a);
  t2 = ABS(b);

  x = MAX(t1, t2);
  y = MIN(t1, t2);

  t3 = x >> 3;
  t4 = y >> 1;
  t5 = x - t3;
  t6 = t4 + t5;
  t7 = MAX(t6, x);
    
  *out1 = t7;
}

#ifdef PROFILE
double minsqr(int approx_val, double ref_val)
{
  double temp_minsqr;

  if (approx_val == 0)
  {
    temp_minsqr = 0.0;
  }
  else
  {
    temp_minsqr = 100*(double)(fabs((double)approx_val - ref_val))/ref_val;
  }

  return (temp_minsqr);
}
#endif

#ifdef TEST
int main()
{
  int i,j;
  int edapprox;
#ifdef PROFILE
  double edaccur;
  double minsqr_val=0.0;
  double edapprox_err=0.0, edapprox_err_max = 0.0;
#endif

  edapprox = 0;
  for (i=0; i<XMAX; i+=2)
  {
    for (j=0; j<YMAX; j+=YMAX/4)
    {
      eda(i, j, &edapprox);
#ifdef PROFILE
      edaccur  = pow(i*i+j*j,0.5);
      printf("euclid2d(%d,%d) -> approx = %d, exact = %lf\n",
      i, j, edapprox, edaccur);
      edapprox_err = minsqr(edapprox,edaccur);
      minsqr_val += edapprox_err;

      if (edapprox_err > edapprox_err_max)
      {
        edapprox_err_max = edapprox_err;
      }
#else
//      printf("%d %d %d\n", i, j, edapprox);
      printf("%08x %08x %08x\n", i, j, edapprox);
#endif
    }
  }

#ifdef PROFILE
  printf("Average error = %lf\n", minsqr_val/((double)XMAX*YMAX));
  printf("Maximum error = %lf\n", edapprox_err_max);
#endif

  return 0;
}
#endif
