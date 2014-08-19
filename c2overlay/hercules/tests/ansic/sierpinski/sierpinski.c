/*
 * Filename: sierpinski.c
 * Purpose : C implementation of the ASCII-version of a Sierpinski gasket 
 *           generation algorithm.
 * Author  : Nikolaos Kavvadias (C) 2011, 2012, 2013
 * Date    : 19-Nov-2011
 * Revision: 0.4.0 (19/11/2011)
 *           Initial version.
 */ 

#ifdef TEST
#include <stdio.h>
#endif

#define MAX   32

#ifdef ALGO
// ASCII Sierpinski gasket
void sierpinski(int *tot)
{
  /* the image is of MAX * MAX characters */
  int col, row;
  int table[MAX*MAX];
  int temp, sum=0;
#if 0  
  for (row = 0; row < MAX; row++)
  {
    for (col = 0; col < MAX; col++)
    {
      table[row*MAX+col] = 0x00;
    }
  }  
#endif  
  col = 0;
  row = 0;
  do {
    if (col >= row) {
      temp = (~col & row) ? '.' : '@';
      table[row*MAX+col] = temp;
      sum += temp;
#ifdef GRAPHIC
      printf("%c", temp);
#endif      
    }
    col++;
    if (col >= MAX) {
      col = 0; // reset col to start again
      row++;   // go to next line
#ifdef GRAPHIC      
      printf("\n");
#endif      
    }
  } while (row != MAX);
  *tot = sum;
#ifdef DIAGNOSTICS
  printf("Output image:\n");
  for (col = MAX-1; col >= 0; col--)
  {
    for (row = 0; row < MAX; row++)
    {
      printf("%02x ", table[row*MAX+col]);
      if (row == MAX-1)
      {
        printf("\n");
      }
    }
  }
#endif    
}
#endif

#ifdef TEST
int main(void)
{
  int res;
  sierpinski(&res);
#ifndef GRAPHIC  
  printf("%08x\n", res); 
#endif  
  return 0;
}
#endif
