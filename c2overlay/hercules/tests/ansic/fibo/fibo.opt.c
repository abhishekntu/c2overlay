unsigned int fibo (unsigned int x) {
    unsigned int f0;
    unsigned int f1;
    unsigned int k;
    unsigned int f;
    f0 = 0;
    f1 = 1;
    k = 2;
    do {
        k = k + 1;
        f = f1 + f0;
        f0 = f1;
        f1 = f;
    }
    while (k <= x);
    return f;
}

