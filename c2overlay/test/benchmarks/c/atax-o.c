#ifdef TEST
int main(void)
{
    	int A[9];
        int x[3];
	int y[3];
        int i;

	for(i=0;i<3;i++){
		y[i] = ( A[i] * (A[0]*x[0] + A[1]*x[1] + A[2]*x[2]) 
		        + A[i+3] * (A[3]*x[0] + A[4]*x[1] + A[5]*x[2]) 
			+ A[i+6] * (A[6]*x[0] + A[7]*x[1] + A[8]*x[2])); 
        }
	return 0;

}
#endif
