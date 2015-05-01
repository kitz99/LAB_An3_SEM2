import math

def generate_matrix(n):
	A = [[0.0] * n for _ in range(n)]
	for i in range(n):
		A[i][i] = 2.0

	for i in range(n-1):
		A[i][i+1], A[i+1][i] = 1.0, 1.0

	return A

def jacobi(m, A, eps):
	n, n0 = 0.0, 0.0
	t, h, s = 0.0, 0.0, 0.0
	z = [0.0 for _ in range(m)]
	Q = [0.0 for _ in range(m)]
	q = 0.0
	p = 5

	b = [[0.0] * m for _ in range(m)]

	x = [0.0 for _ in range(1000)]
	y = [0.0 for _ in range(1000)]
	bb = [0.0 for _ in range(1000)]

	for i in range(m):
		Q[i] = 0.0
		for j in range(m):
			Q[i] += abs(A[i][j])
		if q < Q[i]:
			q = Q[i]

	t = 2.0 / q
	h = t / p

	for k in range(p):
		s = k * h
		for i in range(m):
			for j in range(m):
				if i == j:
					b[i][j] = 1.0 - s * A[i][i]
				else:
					b[i][j] = (-s * A[i][j])
			bb[i] = s * 1.0 # Aici cred ca tre bagata solutia

		n = 0.0
		for i in range(m):
			x[i] = 0.0

		while True:
			for i in range(m):
				y[i] = bb[i]
				for j in range(m):
					y[i] += b[i][j] * x[j]
			er = 0.0
			for i in range(m):
				er += A[i][i] * (x[i] - y[i]) * (x[i] - y[i])
			er = math.sqrt(er)
			n = n + 1
			for i in range(m):
				x[i] = y[i]
			if k == 1:
				n0 = n
				for i in range(m):
					z[i] = x[i]

			if not (er > eps):
				break

		if n < n0:
			n0 = n
			for i in range(m):
				z[i] = x[i]

	print "Numar de iteratii: " + str(n0)
	for i in range(m):
		print z[i]


if __name__ == '__main__':
	n = int(raw_input('n='))
	A = generate_matrix(n)
	eps = 1.0E-13
	jacobi(n, A, eps)




