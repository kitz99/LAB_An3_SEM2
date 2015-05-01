import math

def generate_matrix(n):
	A = [[0.0] * n for _ in range(n)]
	for i in range(n):
		A[i][i] = 2.0

	for i in range(n-1):
		A[i][i+1], A[i+1][i] = 1.0, 1.0

	return A

def gauss(m, a, eps):
	n, no = 0, 0
	z = [0.0 for _ in range(m)]
	h = 2.0 / 5.0
	y = [0.0 for _ in range(m)]

	for k in range(1, 5):
		s = k * h
		n = 0.0
		x = [0.0 for _ in range(m)]
		while True:
			for i in range(m):
				y[i] = (1 - s) * x[i] + 1.0 * s / a[i][i]
				for j in range(i):
					y[i] -= a[i][j] * y[j] * s / a[i][i]
				for j in range(i+1, m):
					y[i] -= a[i][j] * x[j] * s / a[i][i]
			er = 0
			for i in range(m):
				for j in range(m):
					er += a[i][j] * (x[i] - y[i]) * (x[j] - y[j])
			er = math.sqrt(er)
			n = n + 1
			for i in range(m):
				x[i] = y[i]
			if k == 1:
				no = n
				for i in range(m):
					z[i] = x[i]
			if not (er > eps):
				break
		if n < no:
			no = n
			for i in range(m):
				z[i] = x[i]

	print "Numar de iteratii: " + str(no)
	for i in range(m):
		print z[i]



if __name__ == '__main__':
	n = int(raw_input('n='))
	A = generate_matrix(n)
	eps = 1.0E-10
	gauss(n, A, eps)




