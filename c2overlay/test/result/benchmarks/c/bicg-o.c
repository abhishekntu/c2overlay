#ifdef TEST
int main(void)
{
    	int A[9];
        int p[3];
	int q[3];
        int r[3];
	int s[3];

	for(i=0;i<3;i++){	
		q[i] = A[i*3]*p[0] + A[i*3+1]*p[1] + A[i*3+2]*p[2]; 
        }
	for(i=0;i<3;i++){
		s[i] = A[i]*r[0] + A[3+i]*r[1] + A[6+i]*r[2]; 
        }

	return 0;

}
#endif
