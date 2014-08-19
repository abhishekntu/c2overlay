void fir (int *out1) {
    signed int i;
    signed int j;
    static int v [10] = {0, 1, 0, 1, 2, 1, 0, 0, 1, 1};
    static int a [8] = {1, 2, 0, 1, 0, 2, 1, 1};
    int acc = 0;
    for (i = 9; i >= 0; i = i - 1) {
        for (j = 7; j >= 0; j = j - 1) {
            if (j <= i) {
                acc += v[i - j] * a[j];
            }
        }
    }
    *out1 = acc;
}

