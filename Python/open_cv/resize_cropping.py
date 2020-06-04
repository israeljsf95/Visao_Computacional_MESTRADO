# -*- coding: utf-8 -*-
"""
Created on Mon May 18 00:24:01 2020

@author: israe
"""

#Resizing and Cropping

import cv2


img = cv2.imread("resources/lena_color.tiff")



#Resizing
imgResize = cv2.resize(img, (300,200))

#Cropped is catch some part of matrix height first and width second for cv2
imgCropped = img[0:200, 0:200]


cv2.imshow("Orig Image", img)
cv2.imshow("Resized Image", imgResize)
cv2.imshow("Cropped Image", imgCropped)
cv2.waitKey(0)