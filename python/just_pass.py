
from collections import deque

class just_pass:
	def __init__ (self):
		pass

	def set(self, data1_i, data2_i):
		self.data1_i 		= data1_i
		self.data2_i 		= data2_i
		pass


	def pass_val (self, data1_i):
		self.data1_i 		= data1_i
		return self.data1_i

	def pass_bool (self, data1_i):
		# print("Hello World, I'm here mf, at pass_bool function in python bool_val before   ", self.data2_i)
		if (self.data2_i == 1):
			self.data2_i = 0
		else:
			self.data2_i = 1
			pass
		# print("Hello World, I'm here mf, at pass_bool function in python bool_val after   ", self.data2_i)
		return self.data2_i