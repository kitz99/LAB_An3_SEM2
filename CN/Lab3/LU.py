import decimal

def lu(m):
	A = [[decimal.Decimal(0.0)] * m for _ in range(m)]
	for i in range(m):
		for j in range(m):
			A[i][j] = decimal.Decimal(1.0) / (decimal.Decimal(i * 1.0) + decimal.Decimal(j * 1.0) + decimal.Decimal(1.0)) 

	L = [[decimal.Decimal(0.0)] * m for _ in range(m)]
	U = [[decimal.Decimal(0.0)] * m for _ in range(m)]
	Y = [decimal.Decimal(0.0) for _ in range(m)]
	X = [decimal.Decimal(0.0) for _ in range(m)]

	B = [decimal.Decimal(1.0) for _ in range(m)]

	for i in range(0, m):
		L[i][0] = A[i][0]

	for j in range(0, m):
		U[0][j] = A[0][j] / A[0][0]

	for k in range(1, m):
		for i in range(k, m):
			L[i][k] = A[i][k]
			for p in range(0, k):
				L[i][k] -= L[i][p] * U[p][k]
		U[k][k] = 1
		for j in range(k + 1, m):
			U[k][j] = A[k][j]
			for p in range(0, k):
				U[k][j] -= L[k][p] * U[p][j]
			U[k][j] /= L[k][k]


	for i in range(0, m):
		Y[i] = B[i]
		for k in range(0, i):
			Y[i] -= L[i][k] * Y[k]
		Y[i] /= L[i][i]

	for i in range(m-1, -1, -1):
		X[i] = Y[i]
		for k in range(i+1, m):
			X[i] -= U[i][k] * X[k]

	for elem in X:
		print elem

if __name__ == '__main__':
	x = int(raw_input('n='))
	if x == 5:
		p = 40
	elif x == 10:
		p = 60
	else:
		p = 100

	decimal.getcontext().prec = p
	lu(x)
