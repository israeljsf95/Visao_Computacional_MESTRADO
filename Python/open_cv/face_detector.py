# -*- coding: utf-8 -*-
"""
Created on Tue May 19 00:08:09 2020

@author: israe
"""

import cv2
import numpy as np


faceCascade = cv2.CascadeClassifier('resources\haarcascade_frontalface_default.xml')
eyeCascade = cv2.CascadeClassifier('resources\haarcascade_eye.xml')

lena = cv2.imread('resources/lena_color.tiff')
vd = cv2.imread('resources/vd.jpg')
vd = cv2.resize(vd, (lena.shape[0], lena.shape[1]))


lena_gray = cv2.cvtColor(lena, cv2.COLOR_BGR2GRAY)

lena_face = faceCascade.detectMultiScale(lena_gray, 1.1, 4)

vd_gray = cv2.cvtColor(vd, cv2.COLOR_BGR2GRAY)

vd_face = faceCascade.detectMultiScale(vd_gray, 1.1, 4)




for (x,y,w,h) in lena_face:
    lena = cv2.rectangle(lena, (x,y), (x+w,y+h), (255,0,0), 2)
    lena_roi_gray = lena_gray[y:y+h, x:x+w]
    lena_roi_color = lena[y:y+h, x:x+w]
    lena_eye = eyeCascade.detectMultiScale(lena_roi_gray, 1.1, 4)
    for (ex,ey,ew,eh) in lena_eye:
        cv2.rectangle(lena_roi_color, (ex,ey),(ex+ew,ey+eh),(0,255,0),2)

for (x,y,w,h) in vd_face:
    vd = cv2.rectangle(vd, (x,y), (x+w,y+h), (255,0,0), 2)
    vd_roi_gray = vd_gray[y:y+h, x:x+w]
    vd_roi_color = vd[y:y+h, x:x+w]
    vd_eye = eyeCascade.detectMultiScale(vd_roi_gray, 1.1, 4)
    for (ex,ey,ew,eh) in vd_eye:
        cv2.rectangle(vd_roi_color, (ex,ey),(ex+ew,ey+eh),(0,255,0),2)

im_final = np.hstack((lena, vd))


cv2.imshow('img_final',im_final)
cv2.waitKey(0)
cv2.destroyAllWindows()
