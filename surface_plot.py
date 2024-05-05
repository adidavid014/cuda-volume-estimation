import numpy as np
import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import Axes3D

#reading data from histogram_data.txt -- output of ball_samp-cpu
data = np.loadtxt('histogram_data.txt')

#dimensions and bins
X = data[:, 0]
Y = np.arange(1, 101)
X, Y = np.meshgrid(X, Y)
