# -*- coding: utf-8 -*-
"""
Created on Sun May 17 23:51:57 2020

@author: israe
"""

import cv2

#img = cv2.imread("resources/lua.tif")
#
#cv2.imshow("Output", img)
#cv2.waitKey(0)#in miliseconds

##Isto pega o video dentro de uma pasta
#cap = cv2.VideoCapture("resources/test_video.mp4")
#while True:
#    success, img = cap.read()
#    cv2.imshow("Video", img)
#    if cv2.waitKey(1) and 0xFF == ord('q'):
#        break

cap = cv2.VideoCapture(0)#criando o objeto webcam
cap.set(3,640)
cap.set(4,480)
while True:
    success, img = cap.read()
    cv2.imshow("Video", img)
    if cv2.waitKey(1) and 0xFF == ord('q'):
        break

