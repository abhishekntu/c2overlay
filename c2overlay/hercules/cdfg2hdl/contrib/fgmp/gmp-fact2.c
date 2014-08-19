#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "fgmp.h"


int main(int argc, char **argv)
{
  MP_INT prod;
  int sum = 0;
  int i;

  mpz_init(&prod);
  mpz_set_si(&prod,1);

  for (i = 2; i <= 100; i++)
  {
    mpz_mul_ui(&prod, &prod, i);
  }

  char *res = mpz_get_str(NULL, 10, &prod);
  printf("%s\n",res);
  for (i = 0; i < strlen(res); i++)
  {
    sum += (res[i] - '0');
  }
  free(res);
  mpz_clear(&prod);
  printf("%d\n", sum);
}
