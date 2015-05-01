#include<iostream>
#include<math.h>
using namespace std;
int n, m, n0;
double a[101][101], eps = 1.0E-10, t, h, s, z[101], Q[101], q, b[101][101], x[101], y[101], bb[101], er;
int main(){
	cout << "m=";
	cin >> m;
	for (int i= 0; i < m; i++)
		a[i][i] = 2.0;
	for(int i = 0; i < m-1; i++)
		a[i][i+1] = a[i+1][i] = 1.0;

	int p = 5;
	for(int i = 0; i < m; i++){
		Q[i] = 0.0;
		for(int j = 0; j < m; j++)
			Q[i] += fabs(a[i][j]);
		if(q < Q[i])
			q = Q[i];
	}

	t = 2.0 / q;
	h = t / p;

	for(int k = 0; k < m; k++){
		s = k * h;
		for (int i = 0; i < m; i++){
			for(int j = 0; j < m; j++)
				if(i == j)
					b[i][j] = 1.0 - s * a[i][i];
				else
					b[i][j] = (-s * a[i][j]);
			bb[i] = s * 1.0;
		}
		n = 0.0;
		do {
			for(int i = 0; i < m; i++){
				y[i] = bb[i];
				for(int j = 0; j < m; j++)
					y[i] += b[i][j] * x[j];
			}
			er = 0.0;
			for(int i = 0; i < m; i++)
				er += a[i][i] * (x[i] - y[i]) * (x[i] - y[i]);
			er = sqrt(er);
			n = n + 1;
			for(int i = 0; i < m; i++)
				x[i] = y[i];
			if(k == 1){
				n0 = n;
				for(int i = 0; i < m; i++)
					z[i] = x[i];
			}

		}while(er > eps);
		if(n < n0){
			n0 = n;
			for(int i = 0; i < m; i++)
					z[i] = x[i];
		}
	}
	cout << "Pasi: " << n0 << "\n";
	for(int i = 0; i < m; i++)
		cout << z[i]<< "\n";
	cout << "\n";
	return 0;
}