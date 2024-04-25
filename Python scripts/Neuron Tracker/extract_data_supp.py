# -*- coding: utf-8 -*-
"""
Created on Sat Jan 23 15:15:47 2016

@author: matt
"""

# show movement of a particular trajectory, time color coded
tra = traj[0,:,:]
x = plt.scatter(tra[:,1],tra[:,0],c = xs)
cbar = plt.colorbar(x)
cbar.set_label('Time (d)', rotation=90)
plt.show()

# zoom out to the entire image
x = plt.scatter(tra[:,1],tra[:,0],c = xs)
plt.xlim(0,1000)
plt.ylim(1000,0)
cbar = plt.colorbar(x)
cbar.set_label('Time (d)', rotation=90)

# show all trajectories in 2D space
for tra in traj:
    x = plt.scatter(tra[:,1],tra[:,0],c = xs)
cbar = plt.colorbar(x)
plt.xlim(0,2000)
plt.ylim(2000,0)
cbar.set_label('Time (d)', rotation=90)
plt.show()


# show particular frame of the filtered image
b = plt.imshow(ims[12])
cbar = plt.colorbar(b)
cbar.set_label('Bioluminescence', rotation=90)
plt.show()

# transform lines to data readily readable in Chronostar == traces
traces = numpy.array(xs)/24
for line in lines:
    xs, ys = zip(*line)
    traces = numpy.column_stack((traces,ys))
    

traces = numpy.asarray(traces)
numpy.savetxt("traces.csv", traces, delimiter=",")

# save roi
roi = numpy.asarray(com)
roi = numpy.column_stack((roi[:,1],roi[:,0]))
numpy.savetxt("roi.csv",roi,delimiter = ',')
