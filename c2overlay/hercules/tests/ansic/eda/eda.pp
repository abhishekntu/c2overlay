# 1 "eda.i"
# 1 "<command-line>"
# 1 "eda.i"
void eda(int in1, int in2, int *out1)
{
  int t1, t2, t3, t4, t5, t6, t7;
  int a, b, x, y;
  a = in1;
  b = in2;
  t1 = ((a) > 0 ? (a) : (-a));
  t2 = ((b) > 0 ? (b) : (-b));
  x = ((t1) > (t2) ? (t1) : (t2));
  y = ((t1) < (t2) ? (t1) : (t2));
  t3 = x >> 3;
  t4 = y >> 1;
  t5 = x - t3;
  t6 = t4 + t5;
  t7 = ((t6) > (x) ? (t6) : (x));
  *out1 = t7;
}
