#ifdef TEST
int main(void)
{
        int a[9];
        int b[9];
	int c[9];
	int tmp[9];
        int alpha=6;
        int beta=11;

        int i,j;

        for(i=0;i<3;i++){
                for(j=0;j<3;j++){
                        c[i*3+j] = (beta*tmp[i*3+j]) + ((alpha * (a[i*3+0]*b[0*3+j] + a[i*3+1]*b[1*3+j] + a[i*3+2]*b[2*3+j])));
                }
        }
        return 0;

}
#endif
