/****************************************************************/
/*   chebyshev		                                        */
/****************************************************************/

#ifdef TEST
#include <stdio.h>
#endif

#include<math.h>

#ifdef ALGO
void foo()
{
    int a [9];
    int b [9];
    int c [9];
    int d [9];
    int g [9];
    int i, j;
    {
        {
            g[0] = ((a[0] * b[0] + a[1] * b[3] + a[2] * b[6]) * (c[0] * d[0] + c[1] * d[3] + c[2] * d[6]) + (a[0] * b[1] + a[1] * b[4] + a[2] * b[7]) * (c[3] * d[0] + c[4] * d[3] + c[5] * d[6]) + (a[0] * b[2] + a[1] * b[5] + a[2] * b[8]) * (c[6] * d[0] + c[7] * d[3] + c[8] * d[6]));
            g[1] = ((a[0] * b[0] + a[1] * b[3] + a[2] * b[6]) * (c[0] * d[1] + c[1] * d[4] + c[2] * d[7]) + (a[0] * b[1] + a[1] * b[4] + a[2] * b[7]) * (c[3] * d[1] + c[4] * d[4] + c[5] * d[7]) + (a[0] * b[2] + a[1] * b[5] + a[2] * b[8]) * (c[6] * d[1] + c[7] * d[4] + c[8] * d[7]));
            g[2] = ((a[0] * b[0] + a[1] * b[3] + a[2] * b[6]) * (c[0] * d[2] + c[1] * d[5] + c[2] * d[8]) + (a[0] * b[1] + a[1] * b[4] + a[2] * b[7]) * (c[3] * d[2] + c[4] * d[5] + c[5] * d[8]) + (a[0] * b[2] + a[1] * b[5] + a[2] * b[8]) * (c[6] * d[2] + c[7] * d[5] + c[8] * d[8]));
        }
        {
            g[3] = ((a[3] * b[0] + a[4] * b[3] + a[5] * b[6]) * (c[0] * d[0] + c[1] * d[3] + c[2] * d[6]) + (a[3] * b[1] + a[4] * b[4] + a[5] * b[7]) * (c[3] * d[0] + c[4] * d[3] + c[5] * d[6]) + (a[3] * b[2] + a[4] * b[5] + a[5] * b[8]) * (c[6] * d[0] + c[7] * d[3] + c[8] * d[6]));
            g[4] = ((a[3] * b[0] + a[4] * b[3] + a[5] * b[6]) * (c[0] * d[1] + c[1] * d[4] + c[2] * d[7]) + (a[3] * b[1] + a[4] * b[4] + a[5] * b[7]) * (c[3] * d[1] + c[4] * d[4] + c[5] * d[7]) + (a[3] * b[2] + a[4] * b[5] + a[5] * b[8]) * (c[6] * d[1] + c[7] * d[4] + c[8] * d[7]));
            g[5] = ((a[3] * b[0] + a[4] * b[3] + a[5] * b[6]) * (c[0] * d[2] + c[1] * d[5] + c[2] * d[8]) + (a[3] * b[1] + a[4] * b[4] + a[5] * b[7]) * (c[3] * d[2] + c[4] * d[5] + c[5] * d[8]) + (a[3] * b[2] + a[4] * b[5] + a[5] * b[8]) * (c[6] * d[2] + c[7] * d[5] + c[8] * d[8]));
        }
        {
            g[6] = ((a[6] * b[0] + a[7] * b[3] + a[8] * b[6]) * (c[0] * d[0] + c[1] * d[3] + c[2] * d[6]) + (a[6] * b[1] + a[7] * b[4] + a[8] * b[7]) * (c[3] * d[0] + c[4] * d[3] + c[5] * d[6]) + (a[6] * b[2] + a[7] * b[5] + a[8] * b[8]) * (c[6] * d[0] + c[7] * d[3] + c[8] * d[6]));
            g[7] = ((a[6] * b[0] + a[7] * b[3] + a[8] * b[6]) * (c[0] * d[1] + c[1] * d[4] + c[2] * d[7]) + (a[6] * b[1] + a[7] * b[4] + a[8] * b[7]) * (c[3] * d[1] + c[4] * d[4] + c[5] * d[7]) + (a[6] * b[2] + a[7] * b[5] + a[8] * b[8]) * (c[6] * d[1] + c[7] * d[4] + c[8] * d[7]));
            g[8] = ((a[6] * b[0] + a[7] * b[3] + a[8] * b[6]) * (c[0] * d[2] + c[1] * d[5] + c[2] * d[8]) + (a[6] * b[1] + a[7] * b[4] + a[8] * b[7]) * (c[3] * d[2] + c[4] * d[5] + c[5] * d[8]) + (a[6] * b[2] + a[7] * b[5] + a[8] * b[8]) * (c[6] * d[2] + c[7] * d[5] + c[8] * d[8]));
        }
    }

}
#endif


#ifdef TEST
int main(void)
{
	int x;
 	int result;
  	foo();
  	return 0;
}
#endif