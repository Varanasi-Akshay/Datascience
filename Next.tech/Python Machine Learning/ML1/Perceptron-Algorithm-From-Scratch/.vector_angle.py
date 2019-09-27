import numpy as np

v1 = np.array([1, 2, 3])
v2 = 0.5 * v1
print(np.arccos(v1.dot(v2) / (np.linalg.norm(v1) * np.linalg.norm(v2))))
