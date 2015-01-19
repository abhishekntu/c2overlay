/****************************************************************/
/*   SmoothTriangle		                                        */
/****************************************************************/

#ifdef TEST
#include <stdio.h>
#endif

#include<math.h>

#ifdef ALGO
void foo(int b00,int b11,int addra11,int addrb11,int addrc11,int addrd11,int addri11,int addrj11,int addrk11,int addrl11,int data1size,int data2size,int data3size,int data4size,int in1,int in2,int in3,int a1,int e1,int b1,int f1,int c1,int g1,int d1,int h1,int i1,int j1,int k1,int l1)
{	

int T1,T2,T3,T4,T5,T6,T7,T8,T9,T10,T11,T12,T13,T14,T15,T16,T17,T18,T19,T20,T21,T22,T23,T24,T29,T30,T31,T32,T33,T34,T35;
int result[14];

T2 = b00 * data1size;
T3 = T2 + a1;
T4 = b11 * data1size;

T7 = b00 * data2size;
T8 = T7 + b1;
T9 = b11 * data2size;

T11 = e1 - f1;
T12 = T11 * b00;

T14 = b00 * data3size;
T15 = T14 + c1;
T16 = b11 * data3size;
T19 = b00 * data4size;
T20 = T19 + d1;
T21 = b11 * data4size;

T23 = g1 - h1;
T24 = T23 * b00;

T29 = T12 * i1;
T30 = T24 * j1;
T31 = T12 * k1;
T32 = T24 * l1;

T33 = T29 - T30;
T34 = T31 - T32;

T35 = T33 * in1;

result[0] = addra11 + b00;
result[1] = T4 + T3;
result[2] = addrb11 + b00;
result[3] = T9 + T8;
result[4] = addrc11 + b00;
result[5] = T16 + T15;
result[6] = addrd11 + b00;
result[7] = T21 + T20;
result[8] = addri11 + b00;
result[9] = addrj11 + b00;
result[10] = addrk11 + b00;
result[11] = addrl11 + b00;
result[12] = T34 * in2;
result[13] = T35 * in3;

}
#endif


#ifdef TEST
int main(void)
{
	int b00, b11, addra11, addrb11, addrc11, addrd11, addri11, addrj11, addrk11, addrl11, data1size, data2size, data3size, data4size, in1, in2, in3, a1, e1, b1, f1, c1, g1, d1, h1, i1, j1, k1, l1;
	foo(b00, b11, addra11, addrb11, addrc11, addrd11, addri11, addrj11, addrk11, addrl11, data1size, data2size, data3size, data4size, in1, in2, in3, a1, e1, b1, f1, c1, g1, d1, h1, i1, j1, k1, l1);
  	return 0;
}
#endif
