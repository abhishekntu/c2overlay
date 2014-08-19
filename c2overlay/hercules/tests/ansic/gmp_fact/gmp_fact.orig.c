#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "fgmp.h"


#define  MAXARG      100

#ifdef ALGO
MP_INT gmp_fact(unsigned int n)
{
  MP_INT prod;
  int i;

  mpz_init(&prod);
  mpz_set_si(&prod, 1);
  for (i = 2; i <= n; i++) {
    mpz_mul_ui(&prod, &prod, i);
  }
  return (prod);
}
#endif

#ifdef TEST
int main(int argc, char **argv)
{
  MP_INT factres;
  char *res;
  int i;
  
  mpz_init(&factres);
  for (i = 0; i < MAXARG; i++) {
    factres = gmp_fact(i);
    res = mpz_get_str(NULL, 10, &factres);
    printf("fact(%d) = %s\n", i, res);
    free(res);
  }
  mpz_clear(&factres);
}
#endif
