# -*- coding: utf-8 -*-
"""
Created on Tue May 19 00:56:27 2020

@author: israe
"""

import cv2
import numpy as np

#Pintura Virtual


cores = [[5,   107,  0,   19, 255, 255]] #laranja
         #[155,  25,  0,  179, 255, 255], #vermelho
#         [110,  50, 50,  130, 255, 255], #azul
         #[133,  56,  0,  159, 156, 255], #purple
         #[57,   76,  0,  100, 255, 255]] #verde

cores_bgr =[[0, 165, 255]]
            #[0,   0, 255],
#            [255, 0,   0],
            #[255, 0, 255],
            #[0, 255,   0]]

meus_pontos = []

def findColor(img, cores, cores_bgr):    
    imHSV = cv2.cvtColor(img, cv2.COLOR_BGR2HSV)
    cor_cont = 0
    novos_pontos = []
    for cor in cores:
        limite_inferior = np.array(cor[0:3])
        limite_superior = np.array(cor[3:6])
        mascara = cv2.inRange(imHSV, limite_inferior, limite_superior)
        x, y = getContour(mascara)
        cv2.circle(img_res, (x,y), 10, cores_bgr[cor_cont], cv2.FILLED)
        if x != 0 and y != 0:
            novos_pontos.append([x, y, cor_cont])
        cor_cont += 1
    
    return novos_pontos 


def getContour(img):
    _, contorno, hierarquia = cv2.findContours(img, cv2.RETR_EXTERNAL, cv2.CHAIN_APPROX_SIMPLE) #pegando a informacao externa
    x, y, w, h = 0,0,0,0
    for cnt in contorno:
        area = cv2.contourArea(cnt)
        if area > 500:
            #cv2.drawContours(imgContour, cnt, -1, (255, 0, 0), 3)
            peri = cv2.arcLength(cnt, True)
            approx = cv2.approxPolyDP(cnt, 0.02*peri, True)
            x, y, w, h = cv2.boundingRect(approx)
    return x + w//2, y



def draw_CAM(meus_pontos, cores_bgr):
    for ponto in meus_pontos:
        cv2.circle(img_res, (ponto[0], ponto[1]), 10, cores_bgr[ponto[2]], cv2.FILLED)


cap = cv2.VideoCapture(0)#criando o objeto webcam
cap.set(3,640)
cap.set(4,480)

while True:
    success, img = cap.read()
    img_res = img.copy()
    novos_pontos = findColor(img, cores, cores_bgr)
    if len(novos_pontos) != 0:
        for novo_ponto in novos_pontos:
            meus_pontos.append(novo_ponto)
    if len(meus_pontos) != 0:
        draw_CAM(meus_pontos, cores_bgr)
    
    cv2.imshow("Video", img_res)
    if cv2.waitKey(1) and 0xFF == ord('q'):
        break