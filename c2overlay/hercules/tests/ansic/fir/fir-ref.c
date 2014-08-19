void fir(int *out1)
{
  static int v[10] = {0,1,0,1,2,1,0,0,1,1};
  static int a[8] = {1,2,0,1,0,2,1,1};
  int i,j,acc=0;
  for (i=10 -1; i>=0; i--)
  {
    for (j=8 -1; j>=0; j--)
    {
      if (j<=i)
      {
        acc += v[i-j]*a[j];
      }
    }
  }
  *out1 = acc;
}
