void arraysum (int in1, int *out1) {
    signed int i;
    int sum = 0;
    static int arr [10] = {2, 3, 5, 7, 11, 13, 17, 19, 23, 27};
    for (i = 0; i < in1; i = i + 1) {
        sum += arr[i];
    }
    *out1 = sum;
}

