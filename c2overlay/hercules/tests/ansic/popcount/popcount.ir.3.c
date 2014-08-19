int popcount(int);

int popcount(int inp_2){int data_4;
int count_5;
int t1;
int t5;
int t2;
int t3;
int t4;
data_4=inp_2;
count_5=0;
LL3:
t1=data_4!=0;
t5=!t1;
if(t5)goto LL1;
t2=data_4&1;
t3=count_5+t2;
count_5=t3;
t4=data_4>>1;
data_4=t4;
LL2:
goto LL3;
LL1:
return count_5;
}
