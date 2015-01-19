#ifdef TEST
int main(void)
{
        int A[9];
        int B[9];
	int x[3];
	int y[3];
        int alpha=6;
        int beta=11;

        int i,j;

        for(i=0;i<3;i++){
		y[i] = (alpha * (A[i*3]*x[0] + A[i*3+1]*x[1] + A[i*3+2]*x[2])) + (beta * (B[i*3]*x[0] + B[i*3+1]*x[1] + B[i*3+2]*x[2]));
        }
        return 0;

}
#endif
