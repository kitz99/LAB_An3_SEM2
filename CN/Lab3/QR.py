import decimal
import numpy

    
def QR(A, B, n):
    r = [[decimal.Decimal(0.0)] * n for _ in range(n)]
    q = [[decimal.Decimal(0.0)] * n for _ in range(n)]
    y = [decimal.Decimal(0.0) for _ in range(n)]
    x = [decimal.Decimal(0.0) for _ in range(n)]
    
    r[0][0] = decimal.Decimal(0.0)
    for i in range(n):
        r[0][0] += A[i][0] ** 2
        
    r[0][0] = r[0][0].sqrt()
    
    for i in range(n):
        q[i][0] = A[i][0] / r[0][0]
        
    for k in range(1, n):
        for j in range(k):
            r[j][k] = decimal.Decimal(0.0)
            for i in range(n):
                r[j][k] += A[i][k] * q[i][j]
        
        r[k][k] = decimal.Decimal(0.0)
        for i in range(n):
            r[k][k] += A[i][k] ** 2
        
        for i in range(k):
            r[k][k] -= r[i][k] ** 2
        
        r[k][k] = r[k][k].sqrt()
        
        for i in range(n):
            q[i][k] = A[i][k]
            for j in range(k):
                q[i][k] -= r[j][k] * q[i][j]
            q[i][k] /= r[k][k]
            
    for i in range(n):
        y[i] = decimal.Decimal(0.0)
        for j in range(n):
            y[i] += q[j][i] * B[j]
            
    x[-1] = y[-1] / r[-1][-1]
    
    for i in reversed(range(n - 1)):
        x[i] = y[i]
        for k in range(i + 1, n):
            x[i] -= r[i][k] * x[k]
        x[i] /= r[i][i]
        
    for elem in x:
        print(elem)

if __name__ == '__main__':
	n = int(input('n='))
	if n == 5:
		p = 60
	elif n == 10:
		p = 100
	else:
		p = 180
	decimal.getcontext().prec = p

	A = [[decimal.Decimal(0.0)] * n for _ in range(n)]
	for i in range(n):
		for j in range(n):
			A[i][j] = decimal.Decimal(1.0) / (decimal.Decimal(i * 1.0) + decimal.Decimal(j * 1.0) + decimal.Decimal(1.0))
	
	B = [decimal.Decimal(1.0) for _ in range(n)]
	QR(A, B, n)