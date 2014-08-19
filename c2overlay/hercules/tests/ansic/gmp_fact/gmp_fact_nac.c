#include <stdio.h>
#include <math.h>
#include "fgmp.h"
#include "main.h"
void gmp_fact (unsigned int n, signed int *D_2846)
{
  MP_INT prod;
  signed int i;
  signed int k;
  signed int m$11;
  MP_INT prod$11;
  unsigned int m_0$11;
  MP_INT prod$12;
  signed int i$11;
  unsigned int i_1$21;
  MP_INT prod$21;
  signed int i$21;
  unsigned int i_2$31;

L0005:
  m$11 = 1;
  mpz_init(&prod$11);
  m_0$11 = (unsigned int)(m$11);
  mpz_set_ui(&prod$12, m_0$11);
  i$11 = 2;
  prod = prod$12;
  i = i$11;
  goto D_2840;
D_2839:
  i_1$21 = (unsigned int)(i);
  mpz_mul_ui(&prod$21, &prod, i_1$21);
  mpz_printh(&prod$21);
  i$21 = i + 1;
  prod = prod$21;
  i = i$21;
  goto D_2840;
D_2840:
  i_2$31 = (unsigned int)(i);
  if (i_2$31 <= n) {goto D_2839;} else {goto D_2841;}
D_2841:
  *D_2846 = 0;
  goto L_EXIT;
SC_00000:
  goto L_EXIT;
L_EXIT:
  /* NOP */;
}
