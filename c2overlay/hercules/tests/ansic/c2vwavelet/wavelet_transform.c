 int wavelet_transform(unsigned int* input, unsigned int* output,unsigned int length)  {
    //This function assumes input.length=2^n, n>1
    for (unsigned int len = length >> 1; len > 1 ; len >>= 1) {
        //length=2^n, WITH DECREASING n
        for (unsigned int i = 0; i < len; i++) {
            unsigned int sum = input[i*2]+input[i*2+1];
            unsigned int difference = input[i*2]-input[i*2+1];
            output[i] = sum;
            output[len+i] = difference;
        }
    }
}