#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "fgmp.h"

// This version would yield: 0^0 = 0, though this is defined as "indeterminate".
void mp_tetration(unsigned int val, MP_INT *res)
{
  int i;
  mpz_add_ui(res, res, val); // res = 1;
  for (i = 1; i < val; i++)
  {
    mpz_mul_ui(res, res, val);  
  }  
}

int main(int argc, char **argv)
{
  MP_INT prod;
  int i;

  for (i = 1; i <= 100; i++)
  {
    mpz_init(&prod);     
    mp_tetration(i, &prod);
    char *res = mpz_get_str(NULL, 10, &prod);
    printf("%d %s\n", i, res);
    free(res);
  }
  mpz_clear(&prod);
  return (0);
}
