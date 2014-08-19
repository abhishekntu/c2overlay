 unsigned int fastWalshTransform(unsigned int *h_Output, unsigned int *h_Input, unsigned int log2N){
    const unsigned int N = 1 << log2N;
    for(unsigned int pos = 0; pos < N; pos++) h_Output[pos] = h_Input[pos];

    //Cycle through stages with different butterfly strides
    for(unsigned int stride = N / 2; stride >= 1; stride >>= 1){
        //Cycle through subvectors of (2 * stride) elements
        for(unsigned int base = 0; base < N; base += 2 * stride)
            //Butterfly index within subvector of (2 * stride) size
            for(unsigned int j = 0; j < stride; j++){
                unsigned int i0 = base + j +      0;
                unsigned int i1 = base + j + stride;
                unsigned int T1 = h_Output[i0];
                unsigned int T2 = h_Output[i1];
                h_Output[i1] = T1 - T2;
                h_Output[i0] = T1 + T2;
            }
    }
    return 0;
} 
