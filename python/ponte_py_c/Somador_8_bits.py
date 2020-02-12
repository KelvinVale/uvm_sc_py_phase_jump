
from collections import deque

class Somador_8_bits:
	def __init__ (self):
		pass

	def set(self, data1_i, data2_i):
		self.data1_i 		= data1_i
		self.data2_i 		= data2_i
		pass


	def sum (self, data1_i, data2_i):
		self.data1_i 		= data1_i 
		self.data2_i 		= data2_i		
		return self.data1_i + self.data2_i

