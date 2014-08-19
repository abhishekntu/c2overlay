#define BITSET(a, pos)       ((a) | (1L << (pos)))
#define BITCLR(a, pos)       ((a) & ~(1L << (pos)))
#define BITGET(a, pos)       (((a) >> (pos)) & 1L)
void gmp_fact (unsigned int n, signed int *D_2846);
