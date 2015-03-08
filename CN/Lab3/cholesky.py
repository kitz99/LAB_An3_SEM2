import numpy
import math

def cholesky(m):
	A = numpy.zeros((m, m))

	for i in range(0,m):
		for j in range(0, m):
			A[i][j] = 1.0 / (i + j + 1) 

	B = [1.0 for i in range(m)]

	L = numpy.zeros((m, m))
	Y = [0.0 for i in range(m)]
	X = [0.0 for i in range(m)]

	L[0][0] = math.sqrt(A[0][0])
	for i in range(1, m):
		L[i][0] = A[i][0] / L[0][0]

	for j in range(1, m):
		L[j][j] = A[j][j]
		for k in range(0, j):
			L[j][j] -= L[j][k] * L[j][k]
		L[j][j] = math.sqrt(L[j][j])
		for i in range(j+1, m):
			L[i][j] = A[i, j]
			for k in range(0, j):
				L[i, j] -= L[i, k] * L[j, k]
			L[i, j] /= L[j, j]

	for i in range(0, m):
		Y[i] = B[i]
		for k in range(0, i):
			Y[i] -= L[i, k] * Y[k]
		Y[i] /= L[i, i]

	for i in range(m-1, -1, -1):
		X[i] = Y[i]
		for k in range(i+1, m):
			X[i] -= L[k, i] * X[k]
		X[i] /= L[i, i]


	for el in X:
		print "%.15f" % el   # prints 3.142

if __name__ == '__main__':
	x = raw_input('n=')
	cholesky(int(x))
