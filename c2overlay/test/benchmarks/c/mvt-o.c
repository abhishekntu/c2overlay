#ifdef TEST
int main(void)
{
        int A[9];
	int x1[3];
	int x2[3];
	int y_1[3];
	int y_2[3];

        int i;

        for(i=0;i<3;i++){
		x1[i] = (A[i*3]*y_1[0] + A[i*3+1]*y_1[1] + A[i*3+2]*y_1[2]);
        }

        for(i=0;i<3;i++){
                x2[i] = (A[i]*y_2[0] + A[i+3]*y_2[1] + A[i+6]*y_2[2]);
        }

        return 0;

}
#endif
