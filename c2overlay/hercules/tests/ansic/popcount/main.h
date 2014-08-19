#define BITSET(a, pos)       ((a) | (1L << (pos)))
#define BITCLR(a, pos)       ((a) & ~(1L << (pos)))
#define BITGET(a, pos)       (((a) >> (pos)) & 1L)
void popcount (signed int inp_2, signed int *retarg);
