/*
 * Filename: mandel.c
 * Purpose : Mandelbrot ASCII fractal generator using integer arithmetic.
 * Author  : Nikolaos Kavvadias (C) 2012
 * Date    : 01-Jun-2012
 * Revision: 0.4.0 (01/06/12)
 *           Initial version.
 */ 
#ifdef TEST
#include <stdio.h>
#endif

#define ABS(x)              ((x) >  0 ? (x) : (-x))
#define SQFUNC(x)           (((x)*(x)+500)/1000)

#define write(x) printf("%d\n",x)
#define print(x) printf(x)

void checkpixel(int x, int y, int *flag)
{
  int real, imag, temp, iter;
  int f=1;
  real = 0;
  imag = 0;
  iter = 0;
  while (iter < 255)
  {
    temp = SQFUNC(real) - SQFUNC(imag) + x;
	imag = ((2 * real * imag + 500) / 1000) + y;
	real = temp;
	if (ABS(real) + ABS(imag) > 5000)
	{
      f = 0;
      break;
	}
	iter = iter + 1;
  }
  *flag = f;
}

void mandel(int *out1) 
{
  int x, y, on;
  int cnt=0;

  y = 950;
  while (y > -950)
  {
	x = -2100;
	while (x < 1000)
	{
      checkpixel(x, y, &on);
      if (1 == on)
      {
        cnt++;
#ifdef GRAPHIC      
		print("X");
#endif        
      }
      if (0 == on)
      {
#ifdef GRAPHIC   
        print(" ");
#endif        
      }
      x = x + 40;
	}
#ifdef GRAPHIC    
	print("\n");
#endif    
    y = y - 50;
  }
  *out1 = cnt;
}

#ifdef TEST
int main(void)
{
  int result;
  mandel(&result);
  printf("%08x\n", result);
  return 0;
}
#endif
