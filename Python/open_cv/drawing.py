# -*- coding: utf-8 -*-
"""
Created on Mon May 18 00:37:14 2020

@author: israe
"""

#how to put draw and text in images
import cv2
import numpy as np
import matplotlib.pyplot as plt
import matplotlib.animation as animation


img = np.zeros((256,256)).astype('uint8')
fig = plt.figure()


ims = []
for i in range(256):
    if i >= 256 // 2:
        cv2.line(img, (256 // 2, 256 // 2), (128 - (i - 128), i), (80, 20, 10))
    else:    
        cv2.line(img, (0,0), (i,i), (80, 20, 10))
    
    im = plt.imshow(img, animated=True)
    ims.append([im])

ani = animation.ArtistAnimation(fig, ims, interval=50, blit=True,
                                repeat_delay=1000)

plt.show()



#cv.imshow("Image", im)