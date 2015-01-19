#ifdef TEST
int main(void)
{
        int A[9];
	int B[9];
	int C[9];
	int alpha = 9;

        int i,j;

        for(i=0;i<3;i++){
		for(j=0;j<3;j++){
			C[i*3+j] = (alpha * (A[i*3+0]*B[j*3+0] + A[i*3+1]*B[j*3+1] + A[i*3+2]*B[j*3+2]));
		}
        }

        return 0;

}
#endif
