#include <stdio.h>
#include <math.h>
#include "fgmp.h"
#include "main.h"
void gmp_fibo (unsigned int n, signed int *D_2845)
{
  MP_INT f0;
  MP_INT f1;
  signed int i;
  unsigned int k;
  unsigned int t$11;
  unsigned int u$11;
  MP_INT f0$11;
  MP_INT f1$11;
  MP_INT f0$12;
  MP_INT f1$12;
  unsigned int k$11;
  unsigned int k$21;
  MP_INT f$21;
  MP_INT f0$21;
  MP_INT f1$21;

L0005:
  t$11 = 0;
  u$11 = 1;
  mpz_init(&f0$11);
  mpz_init(&f1$11);
  mpz_set_ui(&f0$12, t$11);
  mpz_printh(&f0$12);
  mpz_set_ui(&f1$12, u$11);
  mpz_printh(&f1$12);
  k$11 = 2;
  f0 = f0$12;
  f1 = f1$12;
  k = k$11;
  goto D_2842;
D_2842:
  k$21 = k + 1;
  mpz_add(&f$21, &f1, &f0);
  mpz_set(&f0$21, &f1);
  mpz_set(&f1$21, &f$21);
  mpz_printh(&f$21);
  f0 = f0$21;
  f1 = f1$21;
  k = k$21;
  if (k$21 <= n) {goto D_2842;} else {goto D_2843;}
D_2843:
  *D_2845 = 0;
  goto L_EXIT;
SC_00000:
  goto L_EXIT;
L_EXIT:
  /* NOP */;
}
