import math


def generate_matrix(n):
	A = [[(0.0)] * n for _ in range(n)]
	for i in range(n):
		A[i][i] = (2.0)

	for i in range(n-1):
		A[i][i+1], A[i+1][i] = (1.0), (1.0)

	return A

def rotatii(m, a, eps):
	p, q, n = 0, 0, 0
	x = [[(0.0)] * m for _ in range(m)]
	y = [[(0.0)] * m for _ in range(m)]
	mx = (0.0)
	s, modul, c, theta = (0.0), (0.0), (0.0), (0.0)

	for i in range(m):
		for j in range(m):
			x[i][j] = a[i][j]

	n = 0
	while True:
		n += 1
		mx = (0.0)
		for i in range(m):
			for j in range(i+1, m):
				if mx < abs(x[i][j]):
					p, q = i, j
					mx = (abs(x[i][j]))
		if x[p][p] == x[q][q]:
			theta = (math.pi) / (4.0)
		else:
			theta = (0.5) * (math.atan((2.0) * x[p][q] / (x[p][p] - x[q][q])))

		c = (math.cos(theta))
		s = (math.sin(theta))

		for i in range(m):
			for j in range(m):
				y[i][j] = x[i][j]

		for j in range(m):
			if (j != p) and (j != q):
				y[p][j] = y[j][p] = c * x[p][j] + s * x[q][j]
				y[q][j] = y[j][q] = -s * x[p][j] + c * x[q][j]

		y[p][p] = c * c * x[p][p] + (2.0) * c * s * x[p][q] + s * s * x[q][q]
		y[q][q] = s * s * x[p][p] - (2.0) * c * s * x[p][q] + c * c * x[q][q]
		y[p][q] = y[q][p] = (0.0)

		for i in range(m):
			for j in range(m):
				x[i][j] = y[i][j]

		modul = (0.0)
		for i in range(m):
			for j in range(m):
				if i != j:
					modul += x[i][j] * x[i][j]

		modul = math.sqrt(modul)

		if not (modul > eps):
			break

	for i in range(m):
		print x[i][i]


if __name__ == '__main__':
	n = int(raw_input('n='))
	A = generate_matrix(n)
	eps = (1.0E-20)
	rotatii(n, A, eps)




