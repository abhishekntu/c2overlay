#include <stdio.h>
#include "fgmp.h" //The GNU MP library header

int main(int argc, char **argv)
{
  unsigned long int n;
  MP_INT fact;
  
  n = atoi(argv[1]);
  mpz_init(&fact);
  mpz_fac_ui(&fact, n); //Call the library function to find factorial
  printf("\n%s\n", mpz_get_str(NULL, 10, &fact));
  return 0;
}
