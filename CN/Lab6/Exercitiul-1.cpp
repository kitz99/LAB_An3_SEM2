#include<iostream>
#include<math.h>
using namespace std;

double a = -1.0;
double b = 1.0;
double h;
double sigman;
int n;
double x[1001];
double y[1001];
	
double functiaTema5Ex1(double x)
{
    return (pow(x,7) * sqrt(1-x*x)) / pow(2-x, 6.5);
}

void MetodaTrapezului()
{
    double suma = 0.0;
    for(int i = 0; i < n; i++){
        suma += functiaTema5Ex1(x[i]) + functiaTema5Ex1(x[i+1]);
    }
    sigman = (b-a) * suma /(2*n);
    cout<<"Metoda Trapezului : "<<sigman<<endl;
}

void MetodaSimpson()
{
    double suma = 0.0;
    for(int i = 0;i < n; i++){
        suma += (functiaTema5Ex1(x[i]) + 4*functiaTema5Ex1((x[i]+x[i+1])/2) + functiaTema5Ex1(x[i+1]));
    }
    sigman = (b-a) * suma / (6*n);
    cout<<"Metoda Simpson: "<<sigman<<endl;
}

void MetodaNewtonTema5Ex1()
{
    double suma = 0.0;
    for(int i = 0; i < n; i++){
        suma += (functiaTema5Ex1(x[i+1]) +3*functiaTema5Ex1((2*x[i+1]+x[i])/3) + 3*functiaTema5Ex1((x[i+1]+2*x[i])/3) + functiaTema5Ex1(x[i]));
    }
    sigman = (b-a) * suma / (8*n);
    cout<<"Metoda Newton: "<<sigman<<endl;
}

void MetodaBoole()
{
    double suma = 0.0;
    for(int i = 1;i <= n; i++){
        suma += 7*functiaTema5Ex1(x[i-1])+32*functiaTema5Ex1((3*x[i-1]+x[i])/4)+12*functiaTema5Ex1((x[i-1]+x[i])/2)+32*functiaTema5Ex1((x[i-1]+3*x[i])/4)+7*functiaTema5Ex1(x[i]);
    }
    sigman = ((b-a) * suma)/(90*n);
    cout<<"Metoda Boole: "<<sigman<<endl;
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
    
    sigman = h/2 * suma;
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
    
    sigman = h/18 * suma;
    cout<<"Metoda Gauss - 3 pcte: "<<sigman<<endl;
}

int main ()
{
	
	cout<<"n = ";
	cin>>n;
	
	h = (b-a)/n;
    for(int i = 0; i <= n; i++)
	{
        x[i] = a+i*h;
    }
    
    for(int i = 0; i <= n; i++)
	cout << x[i] << " "; 
    MetodaTrapezului();
    MetodaSimpson();
    MetodaNewtonTema5Ex1();
    MetodaBoole();
    MetodaGauss2Pcte();
    MetodaGauss3Pcte();
	return 0;
}
