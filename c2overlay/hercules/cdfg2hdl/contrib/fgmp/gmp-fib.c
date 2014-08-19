#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "fgmp.h"

int main(int argc, char **argv)
{
  MP_INT f_1;
  MP_INT f_2;

  mpz_init(&f_1);
  mpz_init(&f_2);
  mpz_set_ui(&f_1,1);
  mpz_set_ui(&f_2,1);

  while (1)
  {
    mpz_add(&f_1,&f_2,&f_1);
    mpz_swap(&f_1,&f_2);
    char *res = mpz_get_str(NULL, 10, &f_2);
    printf("%s\n\n",res);
    free(res);
//    printf("%s\n", mpz_get_str(NULL,10,f_2));
  }
   
  mpz_clear(&f_1);
  mpz_clear(&f_2);   
}
