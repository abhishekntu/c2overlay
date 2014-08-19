void eda(int,int,int*);

void eda(int in1_2,int in2_3,int*out1_4){int t1_6;
int t2_7;
int t3_8;
int t4_9;
int t5_10;
int t6_11;
int t7_12;
int a_13;
int b_14;
int x_15;
int y_16;
int t8;
int t9;
int t10;
int t11;
int t12;
int t13;
int t14;
int t15;
int t16;
int t17;
int t18;
int t19;
int t20;
int t21;
int t22;
int t23;
a_13=in1_2;
b_14=in2_3;
t8=a_13>0;
if(t8)goto LL1;
t9=-a_13;
t10=t9;
goto LL2;
LL1:
t10=a_13;
LL2:
t1_6=t10;
t11=b_14>0;
if(t11)goto LL3;
t12=-b_14;
t13=t12;
goto LL4;
LL3:
t13=b_14;
LL4:
t2_7=t13;
t14=t1_6>t2_7;
if(t14)goto LL5;
t15=t2_7;
goto LL6;
LL5:
t15=t1_6;
LL6:
x_15=t15;
t16=t1_6<t2_7;
if(t16)goto LL7;
t17=t2_7;
goto LL8;
LL7:
t17=t1_6;
LL8:
y_16=t17;
t18=x_15>>3;
t3_8=t18;
t19=y_16>>1;
t4_9=t19;
t20=x_15-t3_8;
t5_10=t20;
t21=t4_9+t5_10;
t6_11=t21;
t22=t6_11>x_15;
if(t22)goto LL9;
t23=x_15;
goto LL10;
LL9:
t23=t6_11;
LL10:
t7_12=t23;
*out1_4=t7_12;
return;
}
