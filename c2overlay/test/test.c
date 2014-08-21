/****************************************************************/
/*   chebyshev		                                        */
/****************************************************************/

#ifdef TEST
#include <stdio.h>
#endif

#include<math.h>

#ifdef ALGO
int foo(int a, int b, int q, int u, int v, int w, int z)
{
	int temp_1 = u*u;
	int temp_2 = temp_1*u;
  	int temp_3 = temp_2*u;
	int temp_4 = v*v;
  	int temp_5 = temp_4*v;
  	int temp_6 = temp_5*v;
 	return (z*(temp_3) + 4*a*v*(temp_2) + 6*b*(temp_1)*(temp_4) + 4*u*(temp_5)*w +q*(temp_6));	
}
#endif


#ifdef TEST
int main(void)
{
	int a,b,q,u,v,w,z;
 	int result;
  	result = foo(a,b,q,u,v,w,z);
  	return 0;
}
#endif
