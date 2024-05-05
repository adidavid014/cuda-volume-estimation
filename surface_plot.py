import numpy as np
import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import Axes3D

#reading data from histogram_data.txt -- output of ball_samp-cpu
data = np.loadtxt('histogram_data.txt')

#dimensions and bins
X = data[:, 0]
Y = np.arange(1, 101)
X, Y = np.meshgrid(X, Y)

Z = np.transpose(data[:,1:])
fig = plt.figure()
ax = fig.add_subplot(111, projection='3d') #3-d surface plot

surf = ax.plot_surface(X, Y, Z, cmap='viridis') #needed to add color
ax.set_xlabel('Dimension')
ax.set_ylabel('Bin')
ax.set_zlabel('Normal Count')

fig.colorbar(surf)

plt.savefig('3-d_surface_plot.png')
