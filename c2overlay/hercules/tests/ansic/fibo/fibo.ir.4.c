unsigned fibo(unsigned);

unsigned fibo(unsigned x_2){unsigned f0_4;
unsigned f1_5;
unsigned k_6;
unsigned f_7;
unsigned t1;
unsigned t2;
unsigned t3;
int t7;
unsigned t4;
unsigned t5;
unsigned t6;
t1=(unsigned)0;
f0_4=t1;
t2=(unsigned)1;
f1_5=t2;
t3=(unsigned)2;
k_6=t3;
LL3:
t4=(unsigned)1;
t5=k_6+t4;
k_6=t5;
t6=f1_5+f0_4;
f_7=t6;
LL2:
t7=k_6<=x_2;
if(t7)goto LL3;
LL1:
return f_7;
}
