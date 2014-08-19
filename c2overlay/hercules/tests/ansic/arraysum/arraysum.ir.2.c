void arraysum(int,int*);

static int lance_static_arr_7[10]={2,3,5,7,11,13,17,19,23,27};

void arraysum(int in1_2,int*out1_3){int i_5;
int sum_6;
int t1;
int t2;
int t3;
int t9;
char*t4;
int t5;
char*t6;
int*t7;
int t8;
sum_6=0;
i_5=0;
t1=i_5<in1_2;
t9=!t1;
if(t9)goto LL1;
LL3:
t7=lance_static_arr_7[i_5];
t8=sum_6+t7;
sum_6=t8;
LL2:
t2=i_5;
t3=t2+1;
i_5=t3;
t1=i_5<in1_2;
if(t1)goto LL3;
LL1:
*out1_3=sum_6;
return;
}
