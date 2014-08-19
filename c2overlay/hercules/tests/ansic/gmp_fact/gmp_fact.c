#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "fgmp.h"

#define  MAXARG      200

#ifdef ALGO
int gmp_fact(unsigned int n)
{
  MP_INT prod;
  int i, k, m=1;

  mpz_init(&prod); 
  mpz_set_ui(&prod, m);
  for (i = 2; i <= n; i++) {
    mpz_mul_ui(&prod, &prod, i);
//    fputc(115, stderr);
//    fputc(61, stderr);
    mpz_printh(&prod);
//    fputc(10, stderr);
  }
  return 0;
}
#endif

#ifdef TEST
int main(void)
{
  int result;
  result = gmp_fact(MAXARG);
  printf("%08x %08x\n", MAXARG, result);
  return 0;
}
#endif


