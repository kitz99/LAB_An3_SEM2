import numpy

def lu(m):
	A = numpy.zeros((m, m))

	for i in range(0,m):
		for j in range(0, m):
			A[i][j] = 1.0 / (i + j + 1) 

	L = numpy.zeros((m, m))
	U = numpy.zeros((m, m))
	Y = [0.0 for i in range(m)]
	X = [0.0 for i in range(m)]

	B = [1.0 for i in range(m)]

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

	for el in X:
		print "%.15f" % el   # prints 3.142

if __name__ == '__main__':
	x = raw_input('n=')
	lu(int(x))
