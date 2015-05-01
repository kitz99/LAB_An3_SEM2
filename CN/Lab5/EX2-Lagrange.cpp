#include<iostream>
#include<math.h>
using namespace std;
int main ()
{
	
	double z[102],x[10],y[10],P[101],f[101],suma,produs;
	int i,j,m;
	cout<<"m = ";
	cin>>m;
    
    for(i = 1; i <= m; i++)
    {
        z[i] = 0;
        P[i] = 0;
        f[i] = 0;
    }
    x[1] = -1.0;
    x[2] = (double)-1.0/3;
    x[3] = (double)-1.0/5;
    x[4] = (double)-1.0/10;
    x[5] = 0.0;
    x[6] = (double)1.0/10;
    x[7] = (double)1.0/5;
    x[8] = (double)1.0/3;
    x[9] = 1.0;
    for(i = 1; i<=9; i++)
    {
       y[i] = (double)1/(1 + x[i]*x[i]*100);
    }
   
    z[1] = (double)-3/2;
    f[1] = (double)1/(1 + z[0]*z[0]*100);
    double lungsub = 3.0 / (m-1);
    for(i = 2; i <= m; i++){
        z[i] = z[i-1] + lungsub;
        f[i] = (double)1/(1 + z[i]*z[i]*100);
    }
   
   
    for(int i = 1; i <= m; i++)
	{
        suma = 0;
        for(int k=1;k<=9;k++)
          {
           produs = 1;
		   for(j=1;j<=9;j++)
           {
           	if(j!=k)
              {
              	produs *= (z[i] - x[j]) / (x[k] - x[j]);
			  }
		   }
		   suma = suma + y[k] * produs;
          } 
        P[i] = suma;
    }
    
    
    for(int i = 1; i <= m; i++)
        cout<<"z["<<i<<"] = "<<z[i]<<"             P["<<i<<"] = "<<P[i]<<"   "<<endl;
    
	return 0;
	
}
