/****************************************************************/
/*   ewf		                                        */
/****************************************************************/

#ifdef TEST
#include <stdio.h>
#endif

#include<math.h>

#ifdef ALGO
void foo(int in1,int in2,int in3,int in4,int in5,int in6,int in7,int in8,int in9,int in10,int in11,int in12,int in13,int in14,int in15,int in16,int in17,int in18,int in19,int in20,int in21)
{	

int T1,T2,T3,T4,T5,T6,T7,T8,T9,T10,T11,T12,T13,T14,T15,T16,T17,T18,T19,T20,T21,T22,T23,T24,T25,T26,T27,T28,T29,T30,T31,T32;
int result[5];

T1 = in1 + in2;

T2 = T1 + in3;

T3 = T2 + in4;
T4 = in5 + in6;

T5 = T3 + T4;

T6 = T5 * in7;
T7 = T5 * in8;

T8 = T2 + T6;
T9 = T4 + T7;

T10 = T2 + T8;
T11 = T8 + T5;
T12 = T9 + T4;

T13 = T10 * in9;

T15 = T12 * in10;

T16 = T1 + T13;
T17 = in11 + T15;

T18 = T1 + T16;
T19 = T16 + T8;
T20 = T9 + T17;
T21 = T17 + in12;

T22 = T18 * in13;
T23 = T19 + in14;
T24 = T20 + in15;
T25 = T21 * in16;

T26 = T22 + in17;
T27 = T23 * in18;
T28 = T24 * in19;
T31 = T27 + in20;
T32 = T28 + in21;

result[0]= T11 + T9;
result[1] = T25 + T17;
result[2] = T26 + T16;
result[3] = T23 + T31;
result[4] = T32 + T24;


}
#endif


#ifdef TEST
int main(void)
{
	int in1, in2, in3, in4, in5, in6, in7, in8, in9, in10, in11, in12, in13, in14, in15, in16, in17, in18, in19, in20, in21;
	foo(in1, in2, in3, in4, in5, in6, in7, in8, in9, in10, in11, in12, in13, in14, in15, in16, in17, in18, in19, in20, in21);
  	return 0;
}
#endif
