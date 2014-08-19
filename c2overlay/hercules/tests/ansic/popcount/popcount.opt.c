int popcount (int inp) {
    signed int data;
    signed int count;
    data = inp;
    count = 0;
    while (data != 0) {
        count = count + (data & 0x1);
        data = data >> 0x1;
    }
    return count;
}

