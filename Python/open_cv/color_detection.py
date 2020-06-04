# -*- coding: utf-8 -*-
"""
Created on Mon May 18 01:44:14 2020

@author: israe
"""

#Deteccao Baseada No Espectro HSV (Cilindro de Tonalidade De Cor)
#H - Hue -> Cor propriamente dita
#S - Saturação -> Algo mais proximo da tonalidade da cor escolhida
#V - Valor -> Valor associado a opacidade 



import cv2
import numpy as np

def vazio(a):
    pass

kernel = np.ones((3,3))

#Criando a Janela que armazenara as trackbars para deteccao da Cor

cv2.namedWindow('TrackBar')
cv2.resizeWindow('TrackBar', 480, 240)
cv2.createTrackbar("HUE Min", "TrackBar", 0,   179, vazio)
cv2.createTrackbar("HUE Max", "TrackBar", 179, 179, vazio)
cv2.createTrackbar("Sat Min", "TrackBar", 0,   255, vazio)
cv2.createTrackbar("Sat Max", "TrackBar", 255, 255, vazio)
cv2.createTrackbar("Val Min", "TrackBar", 0,   255, vazio)
cv2.createTrackbar("Val Max", "TrackBar", 255, 255, vazio)

#Laço Infinito para visualização dos efeitos dos numeros

while True:
    img = cv2.imread("resources/lambo.png")
#    for chan in range(3):
#        imgg = cv2.GaussianBlur(img[:,:, chan], (7,7), sigmaX = 1) 
#        imgb = cv2.Canny(imgg, 50, 200)
#        img[:,:, chan] *= imgb
#    
    imHSV = cv2.cvtColor(img, cv2.COLOR_BGR2HSV)
   
    h_min = cv2.getTrackbarPos("HUE Min", "TrackBar") 
    h_max = cv2.getTrackbarPos("HUE Max", "TrackBar") 
    s_min = cv2.getTrackbarPos("Sat Min", "TrackBar") 
    s_max = cv2.getTrackbarPos("Sat Max", "TrackBar") 
    v_min = cv2.getTrackbarPos("Val Min", "TrackBar") 
    v_max = cv2.getTrackbarPos("Val Max", "TrackBar") 
    
    limite_inferior = np.array([h_min, s_min, v_min])
    limite_superior = np.array([h_max, s_max, v_max])
    print(h_min, s_min, v_min, h_max, s_max, v_max)
    
    mascara = cv2.inRange(imHSV, limite_inferior, limite_superior)  
#   Testes envolvendo Transgformações morfológicas       
#    mascara = cv2.dilate(mascara, kernel, iterations = 1)
#    mascara = cv2.erode(mascara,  kernel, iterations = 1)
    filtrada = cv2.bitwise_and(img, img, mask = mascara)
    
    mascara = cv2.cvtColor(mascara, cv2.COLOR_GRAY2BGR)
    
    img_r = cv2.resize(img, (300,300))
    imHSV_r = cv2.resize(imHSV, (300, 300))
    mascara_r = cv2.resize(mascara, (300, 300))
    filtrada_r = cv2.resize(filtrada, (300, 300))
    
    im_aux1 = np.hstack((img_r, imHSV_r))
    im_aux2 = np.hstack((mascara_r, filtrada_r))
    im_final = np.vstack((im_aux1, im_aux2))
    
    
    cv2.imshow('TESTE', im_final)
    cv2.waitKey(1)






