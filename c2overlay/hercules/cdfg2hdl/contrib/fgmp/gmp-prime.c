#include <stdio.h>
#include "fgmp.h" //The GNU MP library header

int mpz_is_prime(MP_INT *n)
{
  MP_INT iterator;
  MP_INT maxIterator;
  MP_INT remainder;

  if (mpz_cmp_ui(n, 1) <= 0) // negatives, zero, 1 : not prime
    return 0;

  if (mpz_cmp_ui(n, 2) == 0) // 2 : prime
    return 1;

  mpz_init(&remainder);
  mpz_init(&iterator);
  mpz_init(&maxIterator);
  mpz_sqrt(&maxIterator, n);
  mpz_add_ui(&maxIterator, &maxIterator, 1UL); // round up

  for (mpz_set_ui(&iterator, 2); mpz_cmp(&iterator, &maxIterator) <= 0; mpz_add_ui(&iterator, &iterator, 1UL))
  {
    mpz_mod(&remainder, n, &iterator);
    if (mpz_cmp_ui(&remainder, 0UL) == 0)
      return 0;
  }
  return 1;
}

int main(int argc, char **argv)
{
  MP_INT limitnum, iter;
  
  mpz_init(&limitnum);
  mpz_set_str(&limitnum, argv[1], 10);
  mpz_init(&iter);
  for (mpz_set_ui(&iter, 1); mpz_cmp(&iter, &limitnum) <= 0; mpz_add_ui(&iter, &iter, 1UL))
  {
    if (mpz_is_prime(&iter) == 1)
    {
      printf("\n%s\n", mpz_get_str(NULL, 10, &iter));
    }
  }
  return 0;
}
