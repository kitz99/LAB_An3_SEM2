#include<iostream>
#include<math.h>
#include<fstream>
#include<string>
using namespace std;
int main ()
{
	
	long double f[2][1],xo1,xo2,eps,x[2],A[2][2];
	long double f1x1,f1x2,f2x1,f2x2,Aminus[2][2],detA,y[2],max=0,norma,suma;
	int i,j,n;
	eps = pow(10,(-1)*10);
	xo1 = -2, xo2 = -2;
	x[1] = xo1, x[2] = xo2;
	n = 1;
	n++;
	f1x1 = 21.0 * x[1] * x[1] - 10.0;
	f1x2 = -1.0;
	f2x1 = 1.0;
	f2x2 = 24.0 * x[2] * x[2] - 11.0;
	A[1][1] = f1x1;
	A[1][2] = f1x2;
	A[2][1] = f2x1;
	A[2][2] = f2x2;

	detA = A[1][1] * A[2][2] - A[1][2] * A[2][1];
	Aminus[1][1] = (double)A[2][2]/detA;
	Aminus[1][2] = (double)A[1][2]*(-1)/detA;
	Aminus[2][1] = (double)A[2][1]*(-1)/detA;
	Aminus[2][2] = (double)A[2][2]/detA;

	for(i=1;i<=2;i++)
	{
		suma=0;
		f[1][1] = 7 * pow(x[1],3) - 10 * x[1] - x[2] + 1;
		f[2][1] = 8 * pow(x[2],3) - 11 * x[2] + x[1] - 1;
		for(j=1;j<=2;j++)
		{
			suma = suma + Aminus[i][j] * f[j][1];
		}
		y[i] = x[i] - suma;
	}
	for(i=1;i<=2;i++)
	{ 
		norma = fabs(y[i] - x[i]);
		if(norma > max) max=norma;  
	}
	x[1]=y[1];
	x[2]=y[2];	   	 	
	ifstream in(".1.txt");
	while(!in.eof())
	{
		string x1,x2;
		in>>x1;
		in>>x2;
		cout<<"x = "<<x1<<"    |    "<<"y = "<<x2<<endl;	
	}
	in.close();
	return 0;
	
}
