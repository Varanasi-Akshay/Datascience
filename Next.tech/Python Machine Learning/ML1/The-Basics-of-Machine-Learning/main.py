import numpy as np

x = np.array([1, 2, 3, 4])		                # vector x
X = np.array([[1, 2], [3, 4], [5, 6], [7, 8]])  # matrix X
dot = x.dot(X)					                # vector-matrix multiplication
xT = X.transpose()				                # transpose matrix X

print('Vector: \n', x)
print('\nMatrix: \n', X)
print('\nMultiplication: \n', dot)
print('\nTranspose: \n', xT)
