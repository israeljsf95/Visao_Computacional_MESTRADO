"""
Criado por : Micaelle Oliveira de Souza
Disciplina : Visão Computacional
2018.1

"""
import sys
import cv2 as cv2
import numpy as np
import matplotlib.pyplot as plt
import scipy.stats as st

from PyQt5.QtWidgets import QMainWindow, QApplication, qApp, QFileDialog, QMessageBox, QLineEdit, QDialog, QCheckBox
from PyQt5.QtGui import QPixmap, QImage, qRgb, QIcon
from PyQt5.uic import loadUi
from PyQt5.QtCore import Qt, pyqtSlot
        
        
class MyApp(QMainWindow):
    def __init__(self):
        super(MyApp, self).__init__()
        loadUi('Interface.ui',self )
        self.setWindowTitle('Visão Computacional')
        self.menubar.setNativeMenuBar(False)

        #Variáveis onde estarão guardada as imagens
        self.im1 = None
        self.im2 = None
        self.im_res = None #img resultado
        self.im_aux = None #img auxiliar

        #Botões
        self.Button_abrirIm1.clicked.connect(self.abrir_imagem_1)
        self.Button_abrirIm2.clicked.connect(self.abrir_imagem_2)
        self.Button_Usar_Resultado.clicked.connect(self.usar_res)
        


        
        #Funções do menu
        self.actionAbrir_Imagem_1.triggered.connect(self.abrir_imagem_1)
        self.actionAbrir_Imagem_2.triggered.connect(self.abrir_imagem_2)
        self.actionSalvar_Resultado.triggered.connect(self.salvar)
        self.actionSair.triggered.connect(self.fechar)
    


    def abrir_imagem_1(self):
        #abre e salva a imagem em self.im1
        filename = QFileDialog.getOpenFileName(self)
        if filename[0] is not '':
            self.im1 = cv2.imread(filename[0]) 
            self.atualizarIm('im1') 
            
    def abrir_imagem_2(self):
        #abre e salva a imagem em self.im2
        filename = QFileDialog.getOpenFileName(self)
        if filename[0] is not '': 
            self.im2 = cv2.imread(filename[0]) 
            self.atualizarIm('im2')
        
    def usar_res(self):
        #Atualiza a imagem im1 com a imagem resultado.
        if self.im_res is None:
            QMessageBox.about(self,"Erro", "Imagem resultado não encontrado.")
        else:
            self.im1 = self.im_res.copy()
            self.atualizarIm('im1')


    def fechar(self): # fecha programa
        sys.exit()

    def salvar(self): # salva a imagem im1.
        filename = QFileDialog.getSaveFileName(self)
        cv2.imwrite(filename[0],self.im_res)

    def atualizarIm(self,tipo):
        #tipo 1: imagem original, senão é a processada
        if tipo == 'im1':
            im = self.im1
            label = self.label_1
        elif tipo == 'im_res':
            im = self.im_res
            label = self.label_3
        elif tipo == 'im2':
            im = self.im2
            label = self.label_2
        else: 
            im = self.im_aux
            label = self.label_4
        #pega os canais e dimensões
        
        if len(im.shape) == 3:
            b,g,r = cv2.split(im) #BGR no openCV
            #cria uma QImage com os canais RGB
            qim = QImage(cv2.merge((r,g,b)), im.shape[1], im.shape[0], im.strides[0], QImage.Format_RGB888)
        else:
            qim = QImage(im, im.shape[1], im.shape[0], im.strides[0], QImage.Format_Indexed8)
            qim.setColorTable([qRgb(i,i,i) for i in range(256)])
        #cria um Pixmap a partir do QImage
        pixmap = QPixmap.fromImage(qim)
        #redimensiona o pixmap pra o tamanho do label
        pixmap = pixmap.scaled(label.size(), Qt.KeepAspectRatio, Qt.SmoothTransformation) 
        #atualiza o label
        label.setPixmap(pixmap)


        
app = QApplication(sys.argv)
window = MyApp()
window.show()
sys.exit(app.exec_())
    
