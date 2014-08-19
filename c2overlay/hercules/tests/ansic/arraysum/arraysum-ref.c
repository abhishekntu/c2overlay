void arraysum(int in1, int *out1)
{
  int i, sum = 0;
  static int arr[10]={2,3,5,7,11,13,17,19,23,27};
  for (i = 0; i < in1; i++)
  {
    sum += arr[i];
  }
  *out1 = sum;
}
