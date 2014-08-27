#ifdef TEST
int main(void)
{
    	int a[9];
        int b[9];
	int tmp[9];
        int c[9];
	int d[9];
	int alpha=6;
	int beta=11;

        int i,j;

	for(i=0;i<3;i++){
                for(j=0;j<3;j++){
                        d[i*3+j] = (beta*tmp[i*3+j]) + ((alpha * (a[i*3+0]*b[0*3+0] + a[i*3+1]*b[1*3+0] + a[i*3+2]*b[2*3+0])) * c[0*3+j] 
				  	+ (alpha * (a[i*3+0]*b[0*3+1] + a[i*3+1]*b[1*3+1] + a[i*3+2]*b[2*3+1])) * c[1*3+j] 
				  	+ (alpha * (a[i*3+0]*b[0*3+2] + a[i*3+1]*b[1*3+2] + a[i*3+2]*b[2*3+2])) * c[2*3+j]);
                }
        }
	return 0;

}
#endif
