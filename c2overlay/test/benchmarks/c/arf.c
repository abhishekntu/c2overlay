/****************************************************************/
/*   arf		                                        */
/****************************************************************/

#ifdef TEST
#include <stdio.h>
#endif

#include<math.h>

#ifdef ALGO
void foo(int in1,int in2,int in3,int in4,int in5,int in6,int in7,int in8,int in9,int in10,int in11,int in12,int in13,int in14,int in15,int in16,int in17,int in18,int in19,int in20,int in21,int in22,int in23,int in24,int in25,int in26)
{	

int T1,T2,T3,T4,T5,T6,T7,T8,T9,T10,T11,T12,T13,T14,T15,T16,T17,T18,T19,T20,T21,T22,T23,T24,T25,T26;
int put[2];

T1 = in1*in2;
T2 = in3*in4;
T3 = in5*in6;
T4 = in7*in8;

T5 = T1 + T2;
T6 = T3 + T4;

T7 = T5 + in9;
T8 = T6 + in10;

T9 = T7*in11;
T10 = T7*in12;
T11 = T8*in13;
T12 = T8*in14;

T13 = T9 + T10;
T14 = T11 + T12;

T15 = in15*in16;
T16 = in17*in18;
T17 = in19*T13;
T18 = in20*T14;
T19 = in21*in22;
T20 = in23*in24;
T21 = in25*T13;
T22 = in26*T14;

T23 = T15 + T16;
T24 = T17 + T18;
T25 = T19 + T20;
T26 = T21 + T22;

put[0] = T23 + T24;
put[1] = T25 + T26;

}
#endif


#ifdef TEST
int main(void)
{
	int in1, in2, in3, in4, in5, in6, in7, in8, in9, in10, in11, in12, in13, in14, in15, in16, in17, in18, in19, in20, in21, in22, in23, in24, in25, in26;
	foo(in1, in2, in3, in4, in5, in6, in7, in8, in9, in10, in11, in12, in13, in14, in15, in16, in17, in18, in19, in20, in21, in22, in23, in24, in25, in26);
  	return 0;
}
#endif
