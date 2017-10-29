import numpy as np
import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import Axes3D
from sklearn.decomposition import PCA
from sklearn import preprocessing

plt.ion()

iris_data = np.loadtxt('data/fisher.csv', 
						delimiter=',', 
						skiprows=1)

X = iris_data[:, 1:4]
X_scaled = preprocessing.scale(X, with_mean=1, with_std=1)
Y = iris_data[:, 0]

pca2 = PCA(n_components=2)
X_proj = pca2.fit_transform(X_scaled)

fig = plt.figure()
ax = Axes3D(fig)
ax.scatter(X_scaled[:, 0], 
		   X_scaled[:, 1], 
		   X_scaled[:, 2], 
		   c=Y, 
		   cmap=plt.cm.Paired, 
		   alpha=0.8)

x_min = X_proj[:, 0].max()
x_max = X_proj[:, 0].min()
y_min = X_proj[:, 1].max()
y_max = X_proj[:, 1].min()

pc1, pc2 = pca2.components_
normal = np.cross(pc1, pc2)
xx, yy = np.meshgrid(np.linspace(y_min, y_max), 
					 np.linspace(x_min, x_max))
zz = -(normal[0]*xx + normal[1]*yy) / normal[2];
ax.plot_surface(xx, yy, zz, alpha=0.3)

plt.figure()
plt.scatter(X_proj[:, 0], 
		    X_proj[:, 1], 
		    c=Y, cmap=plt.cm.Paired, alpha=1.0)

ev = sum(pca2.explained_variance_)
vr = sum(pca2.explained_variance_ratio_)

print "Explained varaince\t\tRatio\n%f\t\t%f\n" % (ev, vr)

