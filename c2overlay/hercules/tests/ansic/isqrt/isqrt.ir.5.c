void isqrt(unsigned,unsigned*);

void isqrt(unsigned x_2,unsigned*outp_3){unsigned m_5;
unsigned y_6;
unsigned b_7;
unsigned x0_8;
int t1;
int t2;
unsigned t3;
unsigned t4;
unsigned t5;
int t6;
int t14;
unsigned t7;
unsigned t8;
int t9;
int t12;
unsigned t13;
unsigned t10;
unsigned t11;
t1=32-2;
t2=1<<t1;
t3=(unsigned)t2;
m_5=t3;
t4=(unsigned)0;
y_6=t4;
x0_8=x_2;
LL4:
t5=(unsigned)0;
t6=m_5!=t5;
t14=!t6;
if(t14)goto LL1;
t7=y_6|m_5;
b_7=t7;
t8=y_6>>1;
y_6=t8;
t9=x0_8>=b_7;
t12=!t9;
if(t12)goto LL3;
t10=x0_8-b_7;
x0_8=t10;
t11=y_6|m_5;
y_6=t11;
LL3:
t13=m_5>>2;
m_5=t13;
LL2:
goto LL4;
LL1:
*outp_3=y_6;
return;
}
