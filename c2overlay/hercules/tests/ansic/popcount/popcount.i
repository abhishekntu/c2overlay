int popcount(int inp)
{
  int data, count;
  data = inp;
  count = 0;
  while (data != 0)
  {
    count = count + (data & 0x1);
    data = data >> 0x1;
  }
  return count;
}
