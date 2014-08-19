#define BITSET(a, pos)       ((a) | (1L << (pos)))
#define BITCLR(a, pos)       ((a) & ~(1L << (pos)))
#define BITGET(a, pos)       (((a) >> (pos)) & 1L)
void eda (signed int in1_2, signed int in2_3, signed int *out1_4);
