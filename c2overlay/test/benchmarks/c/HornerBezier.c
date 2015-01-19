/****************************************************************/
/*   HornerBezier		                                        */
/****************************************************************/

#ifdef TEST
#include <stdio.h>
#endif

#include<math.h>

#ifdef ALGO
void foo(int datasize0,int datasize1,int datasize2,int in0,int in1,int in2,int in3,int in4,int in5,int b1,int mem1out,int mem2out)
{	

int T1,T2,T3,T4,T7,T8,T9,T10,T11,T12;
int result[4];

T1 = datasize0 * in0;
T2 = T1 + b1;
T3 = b1 * T2;
T4 = datasize1 * in1;
T7 = datasize2 * in2;
T8 = in3 * in4;
T9 = T7 + b1;
T10 = in5 * mem1out;
T11 = T8 * mem2out;
T12 = b1 * T9;

result[0] = b1 + T3;
result[1] = b1 + T4;
result[2] = T10 + T11;
result[3] = b1 + T12;

}
#endif


#ifdef TEST
int main(void)
{
	int datasize0, datasize1, datasize2, in0, in1, in2, in3, in4, in5, b1, mem1out, mem2out;
	foo(datasize0, datasize1, datasize2, in0, in1, in2, in3, in4, in5, b1, mem1out, mem2out);
  	return 0;
}
#endif
