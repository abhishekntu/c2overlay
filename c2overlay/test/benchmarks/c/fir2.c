/****************************************************************/
/*   fir2		                                        */
/****************************************************************/

#ifdef TEST
#include <stdio.h>
#endif

#include<math.h>

#ifdef ALGO
int foo(int in1,int in2,int in3,int in4,int in5,int in6,int in7,int in8,int in9,int in10,int in11,int in12,int in13,int in14,int in15,int in16,int b01)
{	

int T1,T2,T3,T4,T5,T6,T7,T8,T9,T10,T11,T12,T13,T14,T15,T16,T17,T18,T19,T20,T21,T22,T23;

T1 = in1 + in2;
T2 = in3 + in4;

T3 = in5 + in6;
T4 = T1 * b01;
T5 = T2 * b01;

T6 = in7 + in8;
T7 = T3 * b01;
T8 = T4 + T5;

T9 = T6 * b01;
T10 = T7 + T8;
T11 = in9 + in10;

T12 = T9 + T10;
T13 = T11 * b01;
T14 = in11 + in12;

T15 = in13 + in14;
T16 = T12 + T13;
T17 = T14 * b01;

T18 = in15 + in16;
T19 = T15 * b01;
T20 = T16 + T17;

T21 = T18 * b01;
T22 = T19 + T20;

T23 = T21 + T22;

return(T23);

}
#endif


#ifdef TEST
int main(void)
{
	int in1, in2, in3, in4, in5, in6, in7, in8, in9, in10, in11, in12, in13, in14, in15, in16, b01;
	int return;
	return = foo(in1, in2, in3, in4, in5, in6, in7, in8, in9, in10, in11, in12, in13, in14, in15, in16, b01);
  	return 0;
}
#endif
