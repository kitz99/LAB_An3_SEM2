import decimal

def cholesky(m):
	A = [[decimal.Decimal(0.0)] * m for _ in range(m)]
	for i in range(m):
		for j in range(m):
			A[i][j] = decimal.Decimal(1.0) / (decimal.Decimal(i * 1.0) + decimal.Decimal(j * 1.0) + decimal.Decimal(1.0)) 


	B = [decimal.Decimal(1.0) for _ in range(m)]

	L = [[decimal.Decimal(0.0)] * m for _ in range(m)]
	Y = [decimal.Decimal(0.0) for _ in range(m)]
	X = [decimal.Decimal(0.0) for _ in range(m)]

	L[0][0] = A[0][0].sqrt()
	for i in range(1, m):
		L[i][0] = A[i][0] / L[0][0]

	for j in range(1, m):
		L[j][j] = A[j][j]
		for k in range(0, j):
			L[j][j] -= L[j][k] * L[j][k]
		L[j][j] = L[j][j].sqrt()
		for i in range(j+1, m):
			L[i][j] = A[i][j]
			for k in range(0, j):
				L[i][j] -= L[i][k] * L[j][k]
			L[i][j] /= L[j][j]

	for i in range(0, m):
		Y[i] = B[i]
		for k in range(0, i):
			Y[i] -= L[i][k] * Y[k]
		Y[i] /= L[i][i]

	for i in range(m-1, -1, -1):
		X[i] = Y[i]
		for k in range(i+1, m):
			X[i] -= L[k][i] * X[k]
		X[i] /= L[i][i]


	for el in X:
		print el

if __name__ == '__main__':
	x = int(raw_input('n='))
	if x == 5:
		p = 40
	elif x == 10:
		p = 60
	else:
		p = 100

	decimal.getcontext().prec = p
	cholesky(x)
