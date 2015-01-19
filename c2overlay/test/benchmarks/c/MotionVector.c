/****************************************************************/
/*   MotionVector		                                        */
/****************************************************************/

#ifdef TEST
#include <stdio.h>
#endif

#include<math.h>

#ifdef ALGO
void foo(int b0,int in11,int in12,int in13,int in14,int in15,int in16,int in21,int in22,int in23,int in24,int in25,int in26,int in31,int in32,int in33,int in34,int in35,int in36,int in41,int in42,int in43,int in44,int in45,int in46)
{	

int T1,T2,T3,T4,T5,T7,T8,T9,T10,T11,T13,T14,T15,T16,T17,T19,T20,T21,T22,T23;
int result[4];

T1 = in11 * in12;
T2 = in13 * in14;
T3 = T1 + b0;
T4 = in15 * in16;
T5 = T2 + T3;

T7 = in21 * in22;
T8 = in23 * in24;
T9 = T7 + b0;
T10 = in25 * in26;
T11 = T8 + T9;

T13 = in31 * in32;
T14 = in33 * in34;
T15 = T13 + b0;
T16 = in35 * in36;
T17 = T14 + T15;

T19 = in41 * in42;
T20 = in43 * in44;
T21 = T19 + b0;
T22 = in45 * in46;
T23 = T20 + T21;

result[0] = T4 + T5;
result[1] = T10 + T11;
result[2] = T16 + T17;
result[3] = T22 + T23;
}
#endif


#ifdef TEST
int main(void)
{
	int b0, in11, in12, in13, in14, in15, in16, in21, in22, in23, in24, in25, in26, in31, in32, in33, in34, in35, in36, in41, in42, in43, in44, in45, in46;
	foo(b0, in11, in12, in13, in14, in15, in16, in21, in22, in23, in24, in25, in26, in31, in32, in33, in34, in35, in36, in41, in42, in43, in44, in45, in46);
  	return 0;
}
#endif
