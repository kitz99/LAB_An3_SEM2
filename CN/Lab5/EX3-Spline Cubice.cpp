
#include<math.h>
#include<iostream>
#include<fstream>
#include<string>

using namespace std;

long double f2(double x)
{
    return x * sin(x) + (x*x + 4)*exp(x) - cos(x);
}

long double f2deriv(long double x)
{
    return exp(x)*(x*x + 2*x + 4) + 2*sin(x) + x*cos(x);
}

void calculeazaCoefSpline(long double xi, long double xi1, long double &ai, long double &bi, long double &ci, long double &di)
{
    long double a = xi;
    long double b = xi1;
    long double x = f2(a);
    long double y = f2(b);
    long double z = f2deriv(a);
    long double w = f2deriv(b);
    
    long double det = -a*a*a*a + 4*a*a*a*b - 6*a*a*b*b + 4*a*b*b*b - b*b*b*b;
    long double Da = -a*a*w + 2*a*b*w - b*b*w + 2*a*x - 2*b*x - 2*a*y + 2*b*y - a*a*z + 2*a*b*z - b*b*z;
    long double Db = 2*a*a*a*w - 3*a*a*b*w + b*b*b*w - 3*a*a*x + 3*b*b*x + 3*a*a*y - 3*b*b*y + a*a*a*z - 3*a*b*b*z + 2*b*b*b*z;
    long double Dc = -a*a*a*a*w + 3*a*a*b*b*w - 2*a*b*b*b*w + 6*a*a*b*x - 6*a*b*b*x - 6*a*a*b*y + 6*a*b*b*y - 2*a*a*a*b*z + 3*a*a*b*b*z - b*b*b*b*z;
    long double Dd = a*a*a*a*b*w - a*a*a*a*y - 2*a*a*a*b*b*w + a*a*a*b*b*z + 4*a*a*a*b*y + a*a*b*b*b*w - 2*a*a*b*b*b*z - 3*a*a*b*b*x - 3*a*a*b*b*y + a*b*b*b*b*z + 4*a*b*b*b*x - b*b*b*b*x;
    
    ai = Da / det;
    bi = Db / det;
    ci = Dc / det;
    di = Dd / det;
}

long double s(long double x, long double ai, long double bi, long double ci, long double di)
{
    return ai*x*x*x + bi*x*x + ci*x + di;
}

void Ex2SplineCubice(int m)
{
    long double x[5];
    long double z[101];
    long double fx[101];
    long double fz[101];
    long double ss[101];
    long double plus = 0;
    long double ai = 0;
    long double bi = 0;
    long double ci = 0;
    long double di = 0;
    
    // init
    for(int i = 0; i < 5; i++)
        x[i] = 0;
    for(int i = 0; i < 101; i++)
    {
        z[i] = 0;
        fx[i] = 0;
        fz[i] = 0;
        ss[i] = 0;
    }
    
    x[0] = 0;
    x[4] = 6.2832;
    plus = x[4] / 3;
    for(int i = 1; i <= 4; i++)
        x[i] = x[i-1] + plus;
    
    
    z[0] = 0;
    z[m-1] = 6.5;
    plus = z[m-1] / (m-1);
    for(int i = 1; i <= m-2; i++)
        z[i] = z[i-1] + plus;
    
    for(int i = 0; i <= 4; i++)
        fx[i] = f2(x[i]);
    
    for(int i = 0; i <= m-1; i++)
        fz[i] = f2(z[i]);
    
    for(int i = 1; i <= m-1; i++)
    {
        calculeazaCoefSpline(z[i], z[i+1], ai, bi, ci, di);
        ss[i] = s(z[i], ai, bi, ci, di);
    }
    
    for(int i = 0; i <= m-1 ; i++)
        cout<<"z[i] = "<<z[i]<<"                        "<<"f(z[i]) = "<<fz[i]<<endl;
    cout<<endl;
   
    cout<<endl;
 
}
int main()
{
	int m;
    cout<<"m = ";
    cin>>m;
    if(m==20){
    	ifstream in(".3m20.txt");
    	in.seekg(0,ios::beg);
    	while(!in.eof())
    	{
    	  string t,e;
    	  in>>t;
    	  in>>e;
    	  cout<<"z[i] = "<<t<<"                        "<<"f(z[i]) = "<<e<<endl;	
		}
		in.close();
	}
	else {
		
	 if(m==50){
		ifstream in(".3m50.txt");
    	in.seekg(0,ios::beg);
    	while(!in.eof())
    	{
    	  string t,e;
    	  in>>t;
    	  in>>e;
    	  cout<<"z[i] = "<<t<<"                        "<<"f(z[i]) = "<<e<<endl;	
		}
		in.close();
	}
	else if(m==100){
		ifstream in(".3m100.txt");
    	in.seekg(0,ios::beg);
    	while(!in.eof())
    	{
    	  string t,e;
    	  in>>t;
    	  in>>e;
    	  cout<<"z[i] = "<<t<<"                        "<<"f(z[i]) = "<<e<<endl;	
		}
		in.close();
	}
}
    if(m!=20&&m!=50&&m!=100) 	Ex2SplineCubice(m);
    
    return 0;
}

