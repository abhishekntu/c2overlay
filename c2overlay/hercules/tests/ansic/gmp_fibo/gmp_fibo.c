#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "fgmp.h"


#define  MAXARG      500

#ifdef ALGO
//#define print(s,k)  k = 0 ; do { putchar(s[k++]);} while (s[k] != 0);

int gmp_fibo(unsigned int n)
{
  MP_INT f0, f1, f;
  int i;
  unsigned int k, t=0, u=1;
  
  mpz_init(&f0);
  mpz_init(&f1);
  mpz_init(&f);
  mpz_set_ui(&f0, t);
  mpz_printh(&f0);
  mpz_set_ui(&f1, u);
  mpz_printh(&f1);
  k = 2;
  do {
    k = k + 1;
    mpz_add(&f, &f1, &f0);
    mpz_set(&f0, &f1);
    mpz_set(&f1, &f);
//    fputc(115, stderr);
//    fputc(61, stderr);
    mpz_printh(&f);
//    fputc(10, stderr);
  } while (k <= n);
  return 0;
}
#endif

#ifdef TEST
int main(void)
{
  int result;
  result = gmp_fibo(MAXARG);
  printf("%08x %08x\n", MAXARG, result);
  return 0;
}
#endif
