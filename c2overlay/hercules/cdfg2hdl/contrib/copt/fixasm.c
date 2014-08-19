#include <stdio.h>

int main(void)
{
  int c;
  int prev_char = '\n';

  while((c = getchar()) != EOF)
  {
    switch(c)
    {
      case '\t':
        if (prev_char != '\n')
          putchar(' ');
        break;
      default:
        putchar(c);
        break;
    }

    prev_char = c;
  }
  return 0;
}
