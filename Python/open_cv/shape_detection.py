# -*- coding: utf-8 -*-
"""
Created on Mon May 18 23:12:47 2020

@author: israe
"""

import cv2
import numpy as np



def getContour(img, imgContour):
    
    _, contorno, hierarquia = cv2.findContours(img, cv2.RETR_EXTERNAL, cv2.CHAIN_APPROX_SIMPLE) #pegando a informacao externa
    for cnt in contorno:
        area = cv2.contourArea(cnt)
        cv2.drawContours(imgContour, cnt, -1, (255, 0, 0), 3)
        if area > 500:
            cv2.drawContours(imgContour, cnt, -1, (255, 0, 0), 3)
            peri = cv2.arcLength(cnt, True)
            approx= cv2.approxPolyDP(cnt, 0.02*peri, True)
            objCor  = len(approx)
            x, y, w, h = cv2.boundingRect(approx)
            if objCor == 3:
                objeto_tipo = 'TRI'
            elif objCor == 4:
                objeto_tipo = 'QUAD'
            else:
                objeto_tipo = 'CIRC'
            
            cv2.rectangle(imgContour, (x,y), (x+w, y+h), (0, 255, 0), 2)
            cv2.putText(imgContour, 
                        objeto_tipo,
                        (x + (w//2) - 10, y + (h//2)),
                        cv2.FONT_HERSHEY_COMPLEX,
                        0.7,
                        (0,255,0), 2
                        )
    return imgContour

img = cv2.imread('resources/shapes.png')

imgray = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)

img_blur = cv2.GaussianBlur(imgray, (7,7), 1)

img_canny = cv2.Canny(img_blur, 50, 50)

img_contour = getContour(img_canny, img.copy())



imgray = cv2.cvtColor(imgray, cv2.COLOR_GRAY2BGR)
    
img_canny = cv2.cvtColor(img_canny, cv2.COLOR_GRAY2BGR)
    
img_r = cv2.resize(img, (350,350))
imgray_r = cv2.resize(imgray, (350, 350))
imgcanny_r = cv2.resize(img_canny, (350, 350))
imgcontour_r = cv2.resize(img_contour, (350, 350))
    


im_aux1 = np.hstack((img_r, imgray_r))
im_aux2 = np.hstack((imgcanny_r, imgcontour_r))
im_final = np.vstack((im_aux1, im_aux2))


cv2.imshow('FINAL', im_final)
cv2.waitKey(0)


