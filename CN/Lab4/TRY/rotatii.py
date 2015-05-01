import decimal
import math

def dd(f):
	return decimal.Decimal(f)

def generate_matrix(n):
	A = [[dd(0.0)] * n for _ in range(n)]
	for i in range(n):
		A[i][i] = dd(2.0)

	for i in range(n-1):
		A[i][i+1], A[i+1][i] = dd(1.0), dd(1.0)

	return A

def rotatii(m, a, eps):
	p, q, n = 0, 0, 0
	x = [[dd(0.0)] * m for _ in range(m)]
	y = [[dd(0.0)] * m for _ in range(m)]
	qq = [[dd(0.0)] * m for _ in range(m)]
	rr = [[dd(0.0)] * m for _ in range(m)]
	z = [dd(0.0) for _ in range(m)]
	zz = [dd(0.0) for _ in range(m)]
	w = [dd(0.0) for _ in range(m)]
	ww = [dd(0.0) for _ in range(m)]
	xx = [dd(0.0) for _ in range(m)]
	mx = dd(-999999.0)
	s, modul, c, theta = dd(0.0), dd(0.0), dd(0.0), dd(0.0)

	x = a # copiere matrice a in matricea x

	n = 0
	while True:
		n += 1
		mx = dd(0.0)
		for i in range(m):
			for j in range(i+1, m):
				if mx < abs(x[i][j]):
					p, q = i, j
					mx = dd(abs(x[i][j]))
		if x[p][p] == x[q][q]:
			theta = dd(math.pi) / dd(4.0)
		else:
			theta = dd(0.5) * dd(math.atan(dd(2.0) * x[p][q] / (x[p][p] - x[q][q])))

		c = dd(math.cos(theta))
		s = dd(math.sin(theta))

		y = x

		for j in range(m):
			if (j != p) and (j != q):
				y[p][j] = y[j][p] = c * x[p][j] + s * x[q][j]
				y[q][j] = y[j][q] = -s * x[p][j] + c * x[q][j]

		y[p][p] = c * c * x[p][p] + dd(2.0) * c * s * x[p][q] + s * s * x[q][q]
		y[q][q] = s * s * x[p][p] - dd(2.0) * c * s * x[p][q] + c * c * x[q][q]
		y[p][q] = y[q][p] = dd(0.0)

		x = y

		modul = dd(0.0)
		for i in range(m):
			for j in range(m):
				if i != j:
					modul += x[i][j] * x[i][j]

		modul = modul.sqrt()

		if not (modul > eps):
			break

	for i in range(m):
		print x[i][i]


if __name__ == '__main__':
	n = int(raw_input('n='))
	A = generate_matrix(n)
	decimal.getcontext().prec = 15

	eps = dd(1.0E-10)
	rotatii(n, A, eps)




