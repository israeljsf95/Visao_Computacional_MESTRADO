# -*- coding: utf-8 -*-
"""
Created on Mon May 18 00:11:45 2020

@author: israe
"""
import cv2
import numpy as np
#funoes basicas




img = cv2.imread("resources/lena_color.tiff")
kernel = np.ones((5,5)).astype('uint8')

#opencv uses BGR
imGray = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)
imBlur = cv2.GaussianBlur(imGray, (9,9), sigmaX = 0)
imCanny = cv2.Canny(img, 100, 100)
#morpphology
imDilation = cv2.dilate(imCanny, kernel, iterations = 1)
imErode = cv2.erode(imDilation, kernel, iterations = 1)

cv2.imshow("Output_Gray", imGray)
cv2.imshow("Output_Blur", imBlur)
cv2.imshow("Output_Canny", imCanny)
cv2.imshow("Output_Dilation", imDilation)
cv2.imshow("Output_Erode", imErode)
cv2.waitKey(0)



