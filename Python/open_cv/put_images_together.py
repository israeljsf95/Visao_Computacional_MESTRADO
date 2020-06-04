# -*- coding: utf-8 -*-
"""
Created on Mon May 18 01:32:33 2020

@author: israe
"""

import numpy as np
import cv2


img = cv2.imread("resources/lena_color.tiff")
kernel = np.ones((5,5)).astype('uint8')

#opencv uses BGR
imGray = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)
imBlur = cv2.GaussianBlur(imGray, (9,9), sigmaX = 0)
imCanny = cv2.Canny(img, 100, 100)
#morpphology
imDilation = cv2.dilate(imCanny, kernel, iterations = 1)
imErode = cv2.erode(imDilation, kernel, iterations = 1)


imhor = np.hstack((imGray, imBlur))



cv2.imshow("Output_Gray", imhor)
cv2.waitKey(0)