#include<iostream>
#include<math.h>
using namespace std;

double a = 0.0;
double b,z;
double h;
double e= 2.7182818284;
double sigman;
int n;
double x[1001];
double y[1001];
	
double functiaTema5Ex1(double x)
{
    return (pow(x,3)/(pow(e,x) - 1));
}

void MetodaDreptunghi()
{
    double suma = 0.0;
    
    for(int i = 0; i < n; i++)
    {
        suma +=  functiaTema5Ex1((x[i]+x[i+1])/2);
    }
    sigman = 3*pow(z,-3)*(b-a) * suma /n;
    cout<<"Metoda Dreptunghiului: "<<sigman<<endl;
}

void MetodaNewtonCotes2Pcte()
{
    double suma = 0.0;
    for(int i = 0; i < n; i++){
        suma += functiaTema5Ex1((2*x[i]+x[i+1])/3)+functiaTema5Ex1((x[i]+2*x[i+1])/3);
    }
    sigman = 3*pow(z,-3)*(b-a) * suma /(2*n);
    cout<<"Metoda Newton Cotes - 2 puncte : "<<sigman<<endl;
}

void MetodaNewtonCotes3Pcte()
{
    double suma = 0.0;
    for(int i = 0; i < n; i++){
        suma += 2*functiaTema5Ex1((3*x[i]+x[i+1])/4)-functiaTema5Ex1((x[i]+x[i+1])/2) + 2*functiaTema5Ex1((x[i]+3*x[i+1])/4);
    }
    sigman = 3*pow(z,-3)*(b-a) * suma /(3*n);
    cout<<"Metoda Newton Cotes - 3 puncte : "<<sigman<<endl;
}

void MetodaGauss2Pcte()
{
    double suma = 0.0;
    double aj[1001];
    double bj[1001];
    double radical3 = sqrt(3);
    
    for(int i = 0; i < 1001; i++)
    {
        aj[i] = 0.0;
        bj[i] = 0.0;
    }
    
    for(int i = 1; i <= n; i++)
    {
        aj[i] = (double)(x[i-1] + x[i]) / 2 - (b-a)/(2*n*radical3);
        bj[i] = (double)(x[i-1] + x[i]) / 2 + (b-a)/(2*n*radical3);
    }
    
    for(int i = 1; i <= n; i++)
        suma += functiaTema5Ex1(aj[i]) + functiaTema5Ex1(bj[i]);
    
    sigman = 3*pow(z,-3)*h/2 * suma;
    cout<<"Metoda Gauss - 2 puncte: "<<sigman<<endl;
}

void MetodaGauss3Pcte()
{
    double suma = 0.0;
    double aj[1001];
    double bj[1001];
    double cj[1001];
    double radical15 = sqrt(15);
    
    for(int i = 0; i < 1001; i++)
    {
        aj[i] = 0.0;
        bj[i] = 0.0;
        cj[i] = 0.0;
    }
    
    for(int i = 1; i <= n; i++)
    {
        aj[i] = (double)(x[i-1] + x[i]) / 2 - ((b-a)*radical15)/(10*n);
        bj[i] = (double)(x[i-1] + x[i]) / 2;
        cj[i] = (double)(x[i-1] + x[i]) / 2 + ((b-a)*radical15)/(10*n);
    }
    
    for(int i = 1; i <= n; i++)
        suma += 5 * functiaTema5Ex1(aj[i]) + 8 * functiaTema5Ex1(bj[i]) + 5 * functiaTema5Ex1(cj[i]);
    
    sigman = 3*pow(z,-3)*h/18 * suma;
    cout<<"Metoda Gauss - 3 pcte: "<<sigman<<endl;
}

int main ()
{
	
	cout<<"n = ";
	cin>>n;
	
	cout<<"x = ";
	cin>>z; 
	b=z;
	
	h = (b-a)/n;
    for(int i = 0; i <= n; i++)
	{
        x[i] = a+i*h;
    }
    
    MetodaDreptunghi();    
    MetodaNewtonCotes2Pcte();
    MetodaNewtonCotes3Pcte();
    MetodaGauss2Pcte();
    MetodaGauss3Pcte();
	return 0;
}
