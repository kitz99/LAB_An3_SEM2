# mesaj = [0x48, 0x40,0xDD,0xEB,0x8C,0x1C,0xBA,0xC7,0x21,0xF8,0x24,0x94,0x9F,0xCF,0x9A]
# key =   [0x29, 0x23,0xBE,0x84,0xE1,0x6C,0xD6,0xAE,0x52,0x90,0x49,0xF1,0xF1,0xBB,0xE9]
import random
import sys
import enchant
import multiprocessing

def worker():
	mesaj =  [0x89, 0x59, 0xCC, 0x8B, 0x97, 0xA9, 0x3A, 0xD9, 0x0D, 0xB2, 0x7B, 0x8B, 0x4E, 0x9E, 0x04]
	mesaj1 = [0x89, 0x59, 0xCC, 0x8B, 0x97, 0xA9, 0x3A, 0xD9, 0x09, 0xA5, 0x69, 0x95, 0x4A, 0x95, 0x11]
	mesaj2 = [0x89, 0x59, 0xC1, 0x90, 0x99, 0xAD, 0x3D, 0xC4, 0x03, 0xBA, 0x7B, 0x92, 0x4A, 0x94, 0x18]
	mesaj3 = [0x8B, 0x46, 0xCA, 0x8B, 0x8B, 0xB0, 0x25, 0xC6, 0x06, 0xA9, 0x7C, 0x9F, 0x4A, 0x95, 0x11]
	mesaj4 = [0x97, 0x44, 0xCE, 0x97, 0x9C, 0xB8, 0x3A, 0xD2, 0x03, 0xBA, 0x7B, 0x92, 0x4A, 0x94, 0x18]
	mesaj5 = [0x97, 0x59, 0xC1, 0x9E, 0x8D, 0xB5, 0x29, 0xC4, 0x03, 0xBA, 0x7B, 0x92, 0x4A, 0x94, 0x18]
	mesaj6 = [0x97, 0x59, 0xC2, 0x89, 0x94, 0xB0, 0x2E, 0xDF, 0x09, 0xA1, 0x6E, 0x8F, 0x4C, 0x95, 0x05]

	d = enchant.Dict("en_US")
	t = 0
	while True:
		key = []
		l = ""
		for i in range(0, len(mesaj)):
			nr = random.randint(0, 255)
			while((
				(nr ^ mesaj[i]) < 97 or (nr ^ mesaj[i]) > 122) or 
				((nr ^ mesaj1[i]) < 97 or (nr ^ mesaj1[i]) > 122) or 
				((nr ^ mesaj2[i]) < 97 or (nr ^ mesaj2[i]) > 122) or 
				((nr ^ mesaj3[i]) < 97 or (nr ^ mesaj3[i]) > 122) or 
				((nr ^ mesaj4[i]) < 97 or (nr ^ mesaj4[i]) > 122) or 
				((nr ^ mesaj5[i]) < 97 or (nr ^ mesaj5[i]) > 122) or 
				((nr ^ mesaj6[i]) < 97 or (nr ^ mesaj6[i]) > 122)):
				nr = random.randint(0, 255)
			key.append(nr)

		t = t + 1
		for i in range(0, len(mesaj)):
			l = l + chr((key[i] ^ mesaj[i])) 

		if t % 100000 == 0:
			print t
			print l

		if d.check(l):
			f = open('result.txt', 'a')
			f.write("key: \n")
			f.write(key)
			f.write(l)
			f.write("\n\n\n==============================================================")
			f.close()
			# print "\nKEY: "
			# print key,
			# print "CUVANT: "
			# print l
			# sys.stdin.read(1)


if __name__ == '__main__':
    jobs = []
    for i in range(4):
        p = multiprocessing.Process(target=worker)
        jobs.append(p)
        p.start()







