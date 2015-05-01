import math

def generate_matrix(n):
	A = [[0.0] * n for _ in range(n)]
	for i in range(n):
		A[i][i] = 2.0

	for i in range(n-1):
		A[i][i+1], A[i+1][i] = 1.0, 1.0

	return A

def mat_x_vect(p, q, a, b):
	c = [0.0 for _ in range(p)]
	for i in range(p):
		for j in range(q):
			c[i] += a[i][j] * b[j]
	return c

def mat_x_mat(p, q, r, a, b):
	c = [[0.0] * p for _ in range(r)]
	for i in range(p):
		for j in range(r):
			for k in range(q):
				c[i][j] += a[i][k] * b[k][j]

	return c

def vect_vect(p, q, a, b):
	c = [[0.0] * p for _ in range(q)]
	for i in range(p):
		for j in range(q):
			c[i][j] = a[i] * b[j]
	return c

def prod_sc(p, a, b):
	c = 0.0
	for i in range(p):
		c += a[i] * b[i]
	return c


def gradient(m, a, eps):
	x = [0.0 for _ in range(m)]
	r = [1.0 for _ in range(m)]
	r1 = [0.0 for _ in range(m)]
	v = [1.0 for _ in range(m)]

	for k in range(m):
		n1 = prod_sc(m, r, r)
		t1 = mat_x_vect(m, m, a, v)
		n2 = prod_sc(m, t1, v)
		aa = n1 / n2
		for i in range(m):
			x[i] = x[i] + aa * v[i]
		for i in range(m):
			r1[i] = r[i] - aa * t1[i]
		n1 = prod_sc(m, r1, r1)
		n2 = prod_sc(m, r, r)
		cc = n1 / n2
		for i in range(m):
			r[i] = r1[i]
		for i in range(m):
			v[i] = r[i] + cc * v[i]

	for i in range(m):
		print x[i]



if __name__ == '__main__':
	n = int(raw_input('n='))
	A = generate_matrix(n)
	eps = 1.0E-10
	gradient(n, A, eps)




