# Autor: Jônatas Cruz Santos

import sys
import cv2
import numpy as np
from numpy import cos, sin, pi
from PyQt5.QtWidgets import QApplication,QMainWindow, qApp, QFileDialog, QMessageBox, QDialog, QWidget, QPushButton, QGridLayout, QSizePolicy, QCheckBox
from PyQt5.QtCore import pyqtSlot,Qt
from PyQt5.uic import loadUi
from PyQt5.QtGui import QPixmap, QImage, qRgb
from matplotlib.pyplot import *
from menuElemento import elemento # Carrega a classe elemento, responsável por gerar a janela para definir o elemento estruturante
import time

class dialogoFiltros(QDialog): # Caixa de Dialogo para o detector de bordas Laplaciano
	def __init__(self):
		super(dialogoFiltros,self).__init__()
		loadUi('dialogoFiltros.ui',self) # Carrega a UI
		self.cancelButton.clicked.connect(self.close) # Fecha caixa de dialogo com o cancelar

class dialogoLaplaciano(QDialog): # Caixa de Dialogo para o detector de bordas Laplaciano
	def __init__(self):
		super(dialogoLaplaciano,self).__init__()
		loadUi('dialogoLaplaciano.ui',self) # Carrega a UI
		self.cancelButton.clicked.connect(self.close) # Fecha caixa de dialogo com o cancelar
		self.setWindowTitle('Detector de Bordas Laplaciano')

class dialogoTrans(QDialog): # Caixa de Dialogo Escalonamento
	def __init__(self):
		super(dialogoTrans,self).__init__()
		loadUi('dialogoTrans.ui',self) # Carrega a UI
		self.cancelButton.clicked.connect(self.close) # Fecha caixa de dialogo com o cancelar
		self.checkBox.stateChanged.connect(self.isOrigem) # "Em torno da origem" foi selecionado
		self.checkBox_2.stateChanged.connect(self.isCentro) # "Em torno do centro" foi selecionado
	def isOrigem(self): # Em torno da origem
		if self.checkBox.isChecked():
			self.checkBox_2.setChecked(not self.checkBox.isChecked()) # Desmarca "Em torno do centro"
		self.isOrigemCentro()
	def isCentro(self): # Em torno do centro
		if self.checkBox_2.isChecked():
			self.checkBox.setChecked(not self.checkBox_2.isChecked()) # Desmarca "Em torno da origem"
		self.isOrigemCentro()
	def isOrigemCentro(self): # Desabilita campos, caso uma das caixas esteja marcada
		if self.checkBox.isChecked() or self.checkBox_2.isChecked():
			self.lineEdit_3.setEnabled(False)
			self.lineEdit_4.setEnabled(False)
		else:
			self.lineEdit_3.setEnabled(True)
			self.lineEdit_4.setEnabled(True)
		
class dialogoTrans2(QDialog): # Caixa de Dialogo Rotação
	def __init__(self):
		super(dialogoTrans2,self).__init__()
		loadUi('dialogoTrans2.ui',self) # Carrega a UI
		self.cancelButton.clicked.connect(self.close) # Fecha caixa de dialogo com o cancelar
		self.checkBox.stateChanged.connect(self.isOrigem) # "Em torno da origem" foi selecionado
		self.checkBox_2.stateChanged.connect(self.isCentro) # "Em torno do centro" foi selecionado
	def isOrigem(self): # Em torno da origem
		if self.checkBox.isChecked():
			self.checkBox_2.setChecked(not self.checkBox.isChecked()) # Desmarca "Em torno do centro"
		self.isOrigemCentro()
	def isCentro(self): # Em torno do centro
		if self.checkBox_2.isChecked():
			self.checkBox.setChecked(not self.checkBox_2.isChecked()) # Desmarca "Em torno da origem"
		self.isOrigemCentro()
	def isOrigemCentro(self): # Desabilita campos, caso uma das caixas esteja marcada
		if self.checkBox.isChecked() or self.checkBox_2.isChecked():
			self.lineEdit_3.setEnabled(False)
			self.lineEdit_4.setEnabled(False)
		else:
			self.lineEdit_3.setEnabled(True)
			self.lineEdit_4.setEnabled(True)

class dialogoTrans3(QDialog): # Caixa de Dialogo Translação
	def __init__(self):
		super(dialogoTrans3,self).__init__()
		loadUi('dialogoTrans3.ui',self) # Carrega a UI
		self.cancelButton.clicked.connect(self.close) # Fecha caixa de dialogo com o cancelar

class dialogoArit(QDialog): # Caixa de Dialogo Soma e Subtração
	def __init__(self):
		super(dialogoArit,self).__init__()
		loadUi('dialogoArit.ui',self) # Carrega a UI
		self.pushButton.clicked.connect(self.close) # Fecha caixa de dialogo com o cancelar
		
class dialogoArit2(QDialog): # Caixa de Dialogo Multiplicação e Divisão
	def __init__(self):
		super(dialogoArit2,self).__init__()
		loadUi('dialogoArit2.ui',self) # Carrega a UI
		self.pushButton.clicked.connect(self.close) # Fecha caixa de dialogo com o cancelar

class interfaceApp(QMainWindow):
	def __init__(self):
		super(interfaceApp,self).__init__()
		loadUi('interface.ui',self) # Carrega a UI
		self.menubar.setNativeMenuBar(False)
		# Dialogo Dilatação
		self.dilataSize=dialogoFiltros()
		self.dilataSize.okButton.clicked.connect(self.fazDilatacao)
		self.dilataSize.setWindowTitle('Dilatação')
		self.dilataSize.label.setText('Tamanho do Elemento\nEstruturante')
		# Dialogo Erosão
		self.erodeSize=dialogoFiltros()
		self.erodeSize.okButton.clicked.connect(self.fazErosao)
		self.erodeSize.setWindowTitle('Erosão')
		self.erodeSize.label.setText('Tamanho do Elemento\nEstruturante')
		# Dialogo Abertura
		self.abreSize=dialogoFiltros()
		self.abreSize.okButton.clicked.connect(self.fazAbertura)
		self.abreSize.setWindowTitle('Abertura')
		self.abreSize.label.setText('Tamanho do Elemento\nEstruturante')
		# Dialogo Fechamento
		self.fechaSize=dialogoFiltros()
		self.fechaSize.okButton.clicked.connect(self.fazFechamento)
		self.fechaSize.setWindowTitle('Fechamento')
		self.fechaSize.label.setText('Tamanho do Elemento\nEstruturante')
		# Dialogo Filtro Laplaciano
		self.laplaceFilt=dialogoLaplaciano()
		self.laplaceFilt.okButton.clicked.connect(self.filtroLaplaciano)
		self.laplaceFilt.setWindowTitle('Filtro Laplaciano')
		# Dialogo Filtro Média
		self.mediaFilt=dialogoFiltros()
		self.mediaFilt.okButton.clicked.connect(self.filtroMedia)
		self.mediaFilt.setWindowTitle('Filtro Passa-Baixas (Média)')
		# Dialogo Filtro Mediana
		self.medianaFilt=dialogoFiltros()
		self.medianaFilt.okButton.clicked.connect(self.filtroMediana)
		self.medianaFilt.setWindowTitle('Filtro Passa-Baixas (Mediana)')
		self.medianaFilt.label.setText(' Tamanho do Filtro')
		# Dialogo Detector de Bordas Laplaciano
		self.laplace=dialogoLaplaciano()
		self.laplace.okButton.clicked.connect(self.laplaciano)
		# Dialogo Transformações
		self.dEsc=dialogoTrans()
		self.dEsc.setWindowTitle('Escalonamento')
		self.dEsc.okButton.clicked.connect(self.escalonamento)
		self.dRot=dialogoTrans2()
		self.dRot.setWindowTitle('Rotação')
		self.dRot.okButton.clicked.connect(self.rotacao)
		self.dTrans=dialogoTrans3()
		self.dTrans.setWindowTitle('Translação')
		self.dTrans.okButton.clicked.connect(self.translacao)
		# Dialogo Operações Aritmeticas
		self.dAdd=dialogoArit()
		self.dAdd.setWindowTitle('Adição de Imagens')
		self.dAdd.pushButton_2.clicked.connect(self.adicaoImagens)
		self.dSub=dialogoArit()
		self.dSub.setWindowTitle('Subtração de Imagens')
		self.dSub.pushButton_2.clicked.connect(self.subtracaoImagens)
		self.dSub.checkBox_2.setText('Subtrai por:')
		self.dMult=dialogoArit2()
		self.dMult.setWindowTitle('Multiplicação de Imagens')
		self.dMult.label.setText('Fator de Multiplicação')
		self.dMult.pushButton_2.clicked.connect(self.multiplicacaoImagens)
		self.dDiv=dialogoArit2()
		self.dDiv.setWindowTitle('Divisão de Imagens')
		self.dDiv.label.setText('Fator de Divisão')
		self.dDiv.pushButton_2.clicked.connect(self.divisaoImagens)
		# Principal
		self.setWindowTitle('App Visão Computacional')
		self.pushButton.clicked.connect(self.usarResultado) # Botão usar resultado
		self.pushButton_2.clicked.connect(self.imagem1to2) # Botão imagem 1 <---> imagem 2
		self.actionAbrir_Imagem_1.triggered.connect(self.abreImagem1) # Abre imagem 1
		self.actionAbrir_Imagem_2.triggered.connect(self.abreImagem2) # Abre imagem 2
		self.actionSalvar.triggered.connect(self.salvaResultado) # Salva imagem resultado
		self.actionTons_de_Cinza.triggered.connect(self.converteToCinza) # Converte em tons de cinza 
		self.actionPreto_e_Branco.triggered.connect(self.converteBinaria) # Converte em preto e branco
		self.verticalSlider.valueChanged.connect(self.mudouLimiar) # Detecta mudança no slider
		self.actionSair.triggered.connect(self.sairPrograma) # Fecha o app
		self.actionAdd.triggered.connect(self.dAdd.show) # Operação de Adição
		self.actionSub.triggered.connect(self.dSub.show) # Operação de Subtração
		self.actionMult.triggered.connect(self.dMult.show) # Operação de Multiplicação
		self.actionDiv.triggered.connect(self.dDiv.show) # Operação de Divisão
		self.actionAND.triggered.connect(self.imagensAND) # Lógica - AND
		self.actionOR.triggered.connect(self.imagensOR) # Lógica - OR
		self.actionNOT.triggered.connect(self.imagemNOT) # Lógica - NOT
		self.actionXOR.triggered.connect(self.imagensXOR) # Lógica - XOR
		self.actionEscalonamento.triggered.connect(self.dEsc.show) # Transformação - Escalonamento
		self.actionRotacao.triggered.connect(self.dRot.show) # Transformação - Rotação
		self.actionTranslacao.triggered.connect(self.dTrans.show) # Transformação - Translação
		self.actionDerivativo_1.triggered.connect(self.derivativo1) # Bordas - Derivativo 1
		self.actionDerivativo_2.triggered.connect(self.derivativo2) # Bordas - Derivativo 2
		self.actionSobel.triggered.connect(self.sobel) # Bordas - Sobel
		self.actionKirsch.triggered.connect(self.kirsch) # Bordas - Kirsch
		self.actionLaplaciano.triggered.connect(self.laplace.show) # Bordas - Laplaciano
		self.actionGerar_Histograma.triggered.connect(self.geraHistograma) # Histograma - Gerar Histograma
		self.actionAutoescala.triggered.connect(self.autoEscala) # Histograma - Autoescala
		self.actionEqualizar.triggered.connect(self.equaliza)# Histograma - Equalizar
		self.actionGlobal.triggered.connect(self.limiarizaGlobal) # Histograma - Limiarização - Global
		self.actionOtsu.triggered.connect(self.limiarizaOtsu) # Histograma - Limiarização - Otsu
		self.actionLaplacianoFilt.triggered.connect(self.laplaceFilt.show) # Filtros - Laplaciano
		self.actionMedia.triggered.connect(self.mediaFilt.show) # Filtros - Passa-Baixas -Media
		self.actionMediana.triggered.connect(self.medianaFilt.show) # Filtros - Passa-Baixas -Mediana
		self.actionBasico_3x3.triggered.connect(self.filtroPA) # Filtros - Passa-Altas - Basico 3x3
		self.actionDilatacao.triggered.connect(self.dilataSize.show) # Morfologia - Dilatação
		self.actionErosao.triggered.connect(self.erodeSize.show) # Morfologia - Erosão
		self.actionAbertura.triggered.connect(self.abreSize.show) # Morfologia - Abertura
		self.actionFechamento.triggered.connect(self.fechaSize.show) # Morfologia - Fechamento
		self.actionSegmentacao.triggered.connect(self.segmentacao) # Segmentação - Segmentação
		self.actionCompleta.triggered.connect(self.caracCompleta) # Extração de Características - Extração Completa
		self.actionArea.triggered.connect(self.area) # Extração de Características - Área
		self.actionPosicao.triggered.connect(self.posicao) # Extração de Características - Posição
		self.actionOrientacao.triggered.connect(self.orientacao) # Extração de Características - Orientação
		self.actionLargura_Comprimento.triggered.connect(self.largComp) # Extração de Características - Largura e Comprimento
		# Trabalho Final:
		self.actionK_Means.triggered.connect(self.segmentaK_Means) # Segmentação - K-Means
		# Cria campo para as imagens:
		self.imagem1=None
		self.imagem2=None
		self.resultado=None
		self.auxiliar=None
		# Inicializa valor do display do slider:
		self.lcdNumber.display(self.verticalSlider.value())
		# Define a função atribuida para o slider:
		self.modoSlider='pb' # pb = preto e branco
		self.eps = np.finfo(float).eps # Utilizado para evitar divisões por zero
	
		
	#@pyqtSlot()
	
	## Início do Código do Projeto Final
	
	def segmentaK_Means(self):
		if self.verificaImagem(self.imagem1): # Verifica se existe imagem
			sh=np.shape(self.imagem1) # Calcula shape da imagem
			H,S,V=self.rgb2hsv(self.imagem1,len(sh)) # Converte imagem de RGB para HSV
			h,s,v=self.quantizaHSV(H,S,V) # Faz a quantização do histograma
			histColor,histCinza=self.histogramaHSV(h,s,v,len(sh)) # Gera os dois hisogramas (colorido e cinza)
			cent,K,hInd=self.inicializaCentroides(histColor) # Inicializa os centroides no histograma colorido
			usaCinza=True 
			if sum(histCinza!=0)!=0 and usaCinza:
					print("Tem Cinza")
					centG,KG,hIndG=self.inicializaCentroides(histCinza) # Inicializa os centroides no hisogrmas cinza
			continua=True 
			it=1 # Inicializa contador de iterações
			while continua: # Loop até que seja atingido algum criterio de parada 
				# Histograma COLORIDO:
				for i in range(K):
					dist=hInd-cent[i,:] # Diferença entre as coordenada de cada píxel com a do centróide
					dHue=self.distanciaHue(dist[:,0]) # Distancia para H 
					dSquare=np.concatenate((dHue,np.square(dist[:,1:3])),axis=1) # Distancia entre os píxels e o centróide
					if i==0: # Para a primeira iteração, cria a variável com a distância
						dEuc=np.transpose(np.array([np.sum(dSquare,1)])) 
					else: # Para as demais iterações, concatena os valores da distância 
						dEuc=np.concatenate((dEuc,np.transpose(np.array([np.sum(dSquare,1)]))),axis=1)
				wMin=np.argmin(dEuc,1) # Encontra posição da menor distancia -> Isto indicará qual o centróide mais próximo
				# Inicializa as regioes de segmentação
				hSeg=np.zeros(np.shape(h))
				sSeg=np.zeros(np.shape(s))
				vSeg=np.zeros(np.shape(v))
				for k in range(len(hInd)):
					# Atribui a cada combinação de h,s,v a cor do centróide mais próximo
					local=np.logical_and(np.logical_and(h==hInd[k,0],s==(hInd[k,1]+1)),v==(hInd[k,2]+1))
					hSeg[local]=cent[wMin[k],0]
					sSeg[local]=cent[wMin[k],1]+1
					vSeg[local]=cent[wMin[k],2]+1
				
				newCent=np.zeros(np.shape(cent)) # Inicializa variavel para receber os novos centroides
				for j in range(K):
					# Utiliza o indíce das variáveis atribuídas ao centróide atual
					ind=hInd[wMin==j]
					# Inicializa variaveis para o calculo
					pesos=np.zeros((len(ind),3))
					caso1=np.zeros((len(ind),),dtype='bool')
					caso2=np.zeros((len(ind),),dtype='bool')
					for l in range(len(ind)):
						# Para cada indice, o seu valor no histograma será utilizado como peso
						pesos[l]=np.array([histColor[ind[l,0],ind[l,1],ind[l,2]]])
						# Verifica casos especificos para os valores de H (Observação: esqueci de colocar isso na apresentação - O ajuste de H no centróide é proposto com uma diferença, dependendo desse valor ser maior ou menor que 180 graus)
						caso1[l]=np.array([np.logical_and(np.abs(ind[l,0]-cent[j,0])>15,cent[j,0]<15)])
						caso2[l]=np.array([np.logical_and(np.abs(ind[l,0]-cent[j,0])>15,cent[j,0]>15)])
					ind[caso1,0]-=29
					ind[caso2,0]+=29
					# Calcula a media ponderada, de acordo com os ajustes, para obter o novo centróide
					newCent[j,:]=np.divide(np.sum(np.multiply(ind,pesos),0),np.sum(pesos,0)+self.eps)
					# Após os ajustes, valores negativos de H são possíveis, assim, é feito o reajuste onde isso ocorre:
					if newCent[j,0]<0:
						newCent[j,0]+=29
				
				print(cent)
				print(newCent)
				
				d=np.abs(cent-newCent) # Diferença entre os valores dos centroides
				md=np.max(d,0) # Maior variação dos centróides
				cent=newCent.astype('int') # Atualiza centro - mantendo inteiro o valor
				
				# Histograma CINZA:
				# Mesmo procedimento usado para o colorido - não são necessários ajustes, por não utilizar H
				if sum(histCinza!=0)!=0 and usaCinza: # Caso tenha cinza
					for i in range(KG):
						distG=hIndG-centG[i]
						dSquareG=np.square(distG)
						if i==0:
							dEucG=dSquareG
						else:
							dEucG=np.concatenate((dEucG,dSquareG),axis=1)
					wMinG=np.argmin(dEucG,1)
					vSegG=np.zeros(np.shape(v))
					
					for k in range(len(hIndG)):
						vSegG[v==hIndG[k]]=centG[wMinG[k]]
					newCentG=np.zeros(np.shape(centG))
					for j in range(KG):
						indG=hIndG[wMinG==j]
						pesosG=np.zeros((len(indG),1))
						for l in range(len(indG)):
							pesosG[l,0]=np.array([histCinza[indG[l,0]]])
						newCentG[j]=np.divide(np.sum(np.multiply(indG,pesosG),0),np.sum(pesosG,0)+self.eps)
				
					print(centG)
					print(newCentG)
					dG=np.abs(centG-newCentG) # Diferença entre os valores dos centroides
					mdG=np.max(dG,0) # Maior variação dos centróides
					centG=newCentG.astype('int') # Atualiza centro - mantendo inteiro o valor
				
				itMax=25 # Número maximo de iterações
				if sum(histCinza!=0)!=0 and usaCinza: # Caso tenha cinza
					if it==itMax or (np.sum(md<=1)==3 and np.unique(mdG<1)): # Criteŕio de parada						
						continua=False # Encerra o loop
						print('\n----------------------------')
						print('Nº Iterações:',it)
				else:
					if it==itMax or (np.sum(md<=1)==3):	# Criteŕio de parada					
						continua=False # Encerra o loop
						print('\n----------------------------')
						print('Nº Iterações:',it)
				it+=1
			print('K (Cores):',K)
			if sum(histCinza!=0)!=0 and usaCinza: # Caso tenha cinza
				vSeg[vSeg==0]=vSegG[vSeg==0] # Atribui os ajustes do valor de cinza na imagem colorida
				print('K (Cinza):',KG)
			imagemRGB=self.hsv2rgb(self.imagem1,hSeg,sSeg,vSeg,len(sh)) # Converte para RGB
			self.resultado=imagemRGB.astype('uint8') # Atribui imagem RGB para o resultado
			self.atualizarImagem('resultado') # Atualiza imagem
			
			print('----------------------------\n')
			
			 
	def hsv2rgb(self,imagem,H,S,V,cores): # Converte de HSV para RGB
		if cores==3: # Se a imagem original tiver 3 cores
			# Utiliza os procedimentos de conversão
			H=12*H 
			S=0.125*S
			V=0.125*V
			bgrIm=np.zeros(np.shape(imagem))
			C=np.multiply(V,S)
			A=1-np.abs(np.mod(H/60,2)-1)
			X=np.multiply(C,A)
			m=V-C
			r=np.zeros(np.shape(H))
			g=np.zeros(np.shape(H))
			b=np.zeros(np.shape(H))
			# Define os casos pra os diferente valores e H
			caso1=np.logical_and(H>=0,H<60)
			caso2=np.logical_and(H>=60,H<120)
			caso3=np.logical_and(H>=120,H<180)
			caso4=np.logical_and(H>=180,H<240)
			caso5=np.logical_and(H>=240,H<300)
			caso6=np.logical_and(H>=300,H<360)
			r[caso1]=C[caso1]
			r[caso2]=X[caso2]
			r[caso3]=0
			r[caso4]=0
			r[caso5]=X[caso5]
			r[caso6]=C[caso6]
			g[caso1]=X[caso1]
			g[caso2]=C[caso2]
			g[caso3]=C[caso3]
			g[caso4]=X[caso4]
			g[caso5]=0
			g[caso6]=0
			b[caso1]=0
			b[caso2]=0
			b[caso3]=X[caso3]
			b[caso4]=C[caso4]
			b[caso5]=C[caso5]
			b[caso6]=X[caso6]
			R=255*(r+m)
			G=255*(g+m)
			B=255*(b+m)
			bgrIm[:,:,0]=B
			bgrIm[:,:,1]=G
			bgrIm[:,:,2]=R
			return bgrIm
			
	def inicializaCentroides(self,histograma): # Inicializa os centroides
		K=1
		sh=np.shape(histograma) 
		if len(sh)==3: # Se histograma colorido
			hInd=np.array([[None,None,None]])
			Kmax=10 # Maximo de K 
			thM=25 # Limiar
		else: # Se histograma cinza
			hInd=np.array([[None]])
			Kmax=8 #Maximo de K
			thM=5 # Limiar
		for j in np.ndindex(histograma.shape):
			if histograma[j]!=0:
				hInd=np.concatenate((hInd,np.array([j]))) # Agrupa valores dos indices em que existe, pelo menos, um pixel na imgem
		hInd=hInd[1::] # Elimina o primeiro ponto
		cent,_=self.addCentroide(histograma,0,K,hInd) # Adiciona o primeiro centroide
		continua=True
		while continua:
			K+=1
			cent,maximin=self.addCentroide(histograma,cent,K,hInd) # Adiciona um novo centroide
			if K==Kmax or maximin<thM: # Se atingir critério de parada, impede que o loop se repita
				continua=False
			if maximin==0: # Se maximin for igual a zero, um centróide foi repetido
				cent=cent[0:-1] # Remove-se então o centróide
				K-=1 # Reduz-se o valor de K
				continua=False
		print(maximin)
		return cent, K, hInd
	
	def addCentroide(self,histograma,centroides,nC,hInd):
		if nC==1: # Encontra valor maximo do histograma e utiliza como primeiro centróide
			pos=np.unravel_index(np.argmax(histograma, axis=None), histograma.shape)
			centroides=np.array([pos]) 
			maximin=None
		else: # Para os demais centróides
			for i in range(nC-1): # Encontra as distâncias
				dist=centroides[i]-hInd
				dHue=self.distanciaHue(dist[:,0])
				dSquare=np.concatenate((dHue,np.square(dist[:,1:3])),axis=1)
				if i==0:
					dEuc=np.transpose(np.array([np.sum(dSquare,1)]))
				else:
					dEuc=np.concatenate((dEuc,np.transpose(np.array([np.sum(dSquare,1)]))),axis=1)
			mini=np.amin(dEuc,1) # Encontra minimo da distancia
			maximin=np.amax(mini) # Encontra maior mínimo das distancias
			novoCentroide=np.argmax(mini) # Utiliza argumento como ponto para o novoCentroide
			centroides=np.concatenate((centroides,[hInd[novoCentroide]])) # Para isso, atribui-se seu indice
		return centroides, maximin
	
	def distanciaHue(self,dist): # Calcula distancia Hue, de acordo com o apresentado 
		distHue=np.zeros(np.shape(dist))
		distHue[np.abs(dist)>15]=np.square(29-np.abs(dist[np.abs(dist)>15]))
		distHue[np.abs(dist)<=15]=np.square(dist[np.abs(dist)<=15])
		return np.transpose([distHue])
		
	def histogramaHSV(self,h,s,v,cores): # Calcula os histogramas HSV
		# Inicializa os histogramas
		histColor = np.zeros((30,7,7))
		histCinza = np.zeros(8)
		if cores==3:
			histCinza[0]=sum(sum(v==0)) # Faz a soma para v=0
			for k in range(1,8):
				histCinza[k]=sum(sum(np.logical_and(s==0,v==k))) # Para onde s=0, faz a soma para cada valor de v
			for H in range(0,30):
				for S in range(1,8):
					for V in range(1,8):
						histColor[H,S-1,V-1]=sum(sum(np.logical_and(np.logical_and(h==H,s==S),v==V))) # Faz a soma para cada combinação de h,s,v
		return histColor, histCinza
							
	
	def quantizaHSV(self,H,S,V): # Quantiza o valor de HSV
		# Garante que H=360, S=1 e V=1 sejam quantizados para 29, 7 e 7m respectivamente
		H[H==360]-=self.eps
		S[S==1]-=self.eps
		V[V==1]-=self.eps
		# Quantiza os valores
		h=np.floor(H/12)
		s=np.floor(S/0.125)
		v=np.floor(V/0.125)
		return h,s,v
	
	def rgb2hsv(self,imagem,cores): # Converte de RGB para HSV, de acordo com o apresentado
		if cores==3:
			B,G,R=imagem[:,:,0]/255,imagem[:,:,1]/255,imagem[:,:,2]/255
			H,S,V=np.zeros(np.shape(G)),np.zeros(np.shape(G)),np.zeros(np.shape(G))
			auxMax=np.maximum(G,B)
			cMax=np.maximum(auxMax,R)
			auxMin=np.minimum(G,B)
			cMin=np.minimum(auxMin,R)
			delta=cMax-cMin
			H[cMax==R]=60*(np.divide(G[cMax==R]-B[cMax==R],delta[cMax==R]+self.eps)) # Foi feito um ajuste que foi equivalente a fazer mod 6
			H[H<0]=H[H<0]+360 ## Obs: Esse ajuste equivale a fazer mod 6
			H[cMax==G]=60*(np.divide(B[cMax==G]-R[cMax==G],delta[cMax==G]+self.eps)+2)
			H[cMax==B]=60*(np.divide(R[cMax==B]-G[cMax==B],delta[cMax==B]+self.eps)+4)
			H[delta==0]=0
			H[H>360]=0 ## Obs: Esse ajuste equivale a fazer mod 6
			S[cMax!=0]=np.divide(delta[cMax!=0],cMax[cMax!=0])
			V=cMax
			return H,S,V
	
	## Fim do código do Projeto Final
	
	################################################################################################################
	
	## Atividades (abaixo)
	
	def caracCompleta(self): # Faz a caracterização completa
		if self.verificaImagem(self.imagem1): # Verifica se existe imagem
			self.preBinariza() # Converte a imagem em binaria, utilizando limiarização de Otsu
			segmentada,nRegioes = self.segmenta(self.imagem1)
			self.resultado=segmentada.astype('uint8') # Converte a imagem segmentada para uint8 e atribui à imagem resultado
			self.atualizarImagem('resultado') # Atualiza a imagem resultado
			mensagem='' # Inicializa mensagem a ser exibida
			for k in range(1,int(nRegioes)+1): # Itera entre as regioes da imagem segmentada
				cx,cy,area,L,C,rad=self.fazTudo(self.resultado,int(k*255/(nRegioes+1))) # Estima os parâmetros
				graus=180*rad/pi # Converte inclinação em radianos
				# Demarca o centro de massa
				self.resultado[cx-3:cx+4,cy-3:cy+4]=0 
				self.resultado[cx-2:cx+3,cy-2:cy+3]=255
				self.resultado[cx-1:cx+2,cy-1:cy+2]=0
				#
				mensagem=mensagem+"Segmento "+str(k)+":\t\t\n"+"\tCentro de Massa x = "+str(cx)+"\t\t\n\tCentro de Massa y = "+str(cy)+"\t\t\n\tInclinação = "+str(graus)+"\t\t\n\tÁrea = "+str(area)+"\t\t\n\tLargura = "+str(L)+"\t\t\n\tComprimento = "+str(C)+"\t\t\n" # Escreve na mensagem os valores das características
			self.atualizarImagem('resultado') # Atualiza a imagem resultado
			QMessageBox.about(self,"Características (1=Mais Escuro; "+str(k)+"=Mais Claro)",mensagem) # Imprime mensagem
				
			
	def fazTudo(self,imagem,regiao): # Extrai todas as características
		sh=np.shape(imagem)
		cx,cy=self.centroMassa(imagem,regiao) # Calcula centro de massa
		area=self.calculaArea(imagem,regiao) # Calcula area
		sx,sy,sxy=0,0,0 # Inicializa variaveis para calculo da orientação
		# Inicializa variaveis para calculo da largura e comprimento
		iMax=0
		iMin=sh[0]
		jMax=0
		jMin=sh[1]
		for i in range(sh[0]):
			for j in range(sh[1]):
				if imagem[i,j]==regiao: # Verifica se pixel faz parte da regiao
					iL=i-cx
					jL=j-cy
					sx=sx+iL**2
					sy=sy+jL**2
					sxy=sxy+iL*jL
					if iMax<i:
						iMax=i
					if iMin>i:
						iMin=i
					if jMax<j:
						jMax=j
					if jMin>j:
						jMin=j
		sxy=2*sxy
		angulo=np.arctan2(sxy,(sx-sy))/2 # Calculo da orientação 
		# Calculo da largura e do comprimento
		largura=jMax-jMin+1
		comprimento=iMax-iMin+1
		return cx,cy,area,largura,comprimento,angulo
		
	def orientacao(self): # Calcula somente a orientação
		if self.verificaImagem(self.imagem1): # Verifica se existe imagem
			self.preBinariza() # Converte a imagem em binaria, utilizando limiarização de Otsu
			segmentada,nRegioes = self.segmenta(self.imagem1)
			self.resultado=segmentada.astype('uint8') # Converte a imagem segmentada para uint8 e atribui à imagem resultado
			self.atualizarImagem('resultado') # Atualiza a imagem resultado
			mensagem='' # Inicializa mensagem a ser exibida
			for k in range(1,int(nRegioes)+1): # Itera entre as regioes da imagem segmentada
				radianos=self.findInclina(self.resultado,int(k*255/(nRegioes+1)))
				graus=180*radianos/pi # Converte inclinação em radianos
				mensagem=mensagem+"\tSegmento "+str(k)+":\t\t\n"+"\t\tInclinação = "+str(graus)+"\t\t\n"
			self.atualizarImagem('resultado') # Atualiza a imagem resultado
			QMessageBox.about(self,"Posição (1=Mais Escuro; "+str(k)+"=Mais Claro)",mensagem)
	
	def findInclina(self,imagem,regiao):
		sh=np.shape(imagem)
		cx,cy=self.centroMassa(imagem,regiao) # Encontra centro de massa
		sx,sy,sxy=0,0,0
		for i in range(sh[0]):
			for j in range(sh[1]):
				if imagem[i,j]==regiao: # Verifica se pixel faz parte da regiao
					# Desloca para o centro de massa:
					iL=i-cx
					jL=j-cy
					# Calcula sx, sy e sxy
					sx=sx+iL**2
					sy=sy+jL**2
					sxy=sxy+iL*jL
		sxy=2*sxy
		angulo=np.arctan2(sxy,(sx-sy))/2 
		return angulo
	
	def posicao(self):
		if self.verificaImagem(self.imagem1): # Verifica se existe imagem
			self.preBinariza() # Converte a imagem em binaria, utilizando limiarização de Otsu
			segmentada,nRegioes = self.segmenta(self.imagem1)
			self.resultado=segmentada.astype('uint8') # Converte a imagem segmentada para uint8 e atribui à imagem resultado
			self.atualizarImagem('resultado') # Atualiza a imagem resultado
			mensagem='' # Inicializa mensagem a ser exibida
			for k in range(1,int(nRegioes)+1): # Itera entre as regioes da imagem segmentada
				cx,cy=self.centroMassa(self.resultado,int(k*255/(nRegioes+1)))
				mensagem=mensagem+"\tSegmento "+str(k)+":\t\t\n"+"\t\tCentro de Massa x = "+str(cx)+"\t\t\n\t\tCentro de Massa y = "+str(cy)+"\t\t\n"
				# Demarca o centro de massa
				self.resultado[cx-3:cx+4,cy-3:cy+4]=0
				self.resultado[cx-2:cx+3,cy-2:cy+3]=255
				self.resultado[cx-1:cx+2,cy-1:cy+2]=0
			self.atualizarImagem('resultado') # Atualiza a imagem resultado
			QMessageBox.about(self,"Posição (1=Mais Escuro; "+str(k)+"=Mais Claro)",mensagem)
				
	def centroMassa(self,imagem,regiao):
		area=self.calculaArea(imagem,regiao) # Calcula a area
		sh=np.shape(imagem)
		ci=0
		cj=0
		for i in range(sh[0]):
			for j in range(sh[1]):
				if imagem[i,j]==regiao: # Verifica se pixel faz parte da regiao
					# Incrementa as posições dos pixels da imagem
					ci=ci+i
					cj=cj+j
		
		# Calcula o centro de massa
		cx=int(ci/area)
		cy=int(cj/area)
		return cx,cy
	
	def largComp(self):
		if self.verificaImagem(self.imagem1): # Verifica se existe imagem
			self.preBinariza() # Converte a imagem em binaria, utilizando limiarização de Otsu
			segmentada,nRegioes = self.segmenta(self.imagem1)
			self.resultado=segmentada.astype('uint8') # Converte a imagem segmentada para uint8 e atribui à imagem resultado
			self.atualizarImagem('resultado') # Atualiza a imagem resultado
			mensagem='' # Inicializa mensagem a ser exibida
			for k in range(1,int(nRegioes)+1): # Itera entre as regioes da imagem segmentada
				l,c=self.calcLaCo(self.resultado,int(k*255/(nRegioes+1)))
				mensagem=mensagem+"\tSegmento "+str(k)+":\t\t\n"+"\t\tLargura = "+str(l)+"\t\t\n\t\tComprimento = "+str(c)+"\t\t\n"
			QMessageBox.about(self,"Largura e Comprimento (1=Mais Escuro; "+str(k)+"=Mais Claro)",mensagem)
			
	def calcLaCo(self,imagem,regiao):
		sh=np.shape(imagem)
		iMax=0
		iMin=sh[0]
		jMax=0
		jMin=sh[1]
		for i in range(sh[0]):
			for j in range(sh[1]):
				if imagem[i,j]==regiao: # Verifica se pixel faz parte da regiao
					# Atualiza maximos e minimos
					if iMax<i:
						iMax=i
					if iMin>i:
						iMin=i
					if jMax<j:
						jMax=j
					if jMin>j:
						jMin=j
		# Calcula largura e comprimento
		largura=jMax-jMin+1
		comprimento=iMax-iMin+1
		return largura, comprimento
	
	def area(self):
		if self.verificaImagem(self.imagem1): # Verifica se existe imagem
			self.preBinariza() # Converte a imagem em binaria, utilizando limiarização de Otsu
			segmentada,nRegioes = self.segmenta(self.imagem1)
			self.resultado=segmentada.astype('uint8') # Converte a imagem segmentada para uint8 e atribui à imagem resultado
			self.atualizarImagem('resultado') # Atualiza a imagem resultado
			mensagem='' # Inicializa mensagem a ser exibida
			for k in range(1,int(nRegioes)+1): # Itera entre as regioes da imagem segmentada
				area=self.calculaArea(self.resultado,int(k*255/(nRegioes+1)))
				mensagem=mensagem+"\tÁrea Segmento "+str(k)+" = "+str(area)+"\t\n"
			QMessageBox.about(self,"Área (1=Mais Escuro; "+str(k)+"=Mais Claro)",mensagem)
			
	def calculaArea(self,imagem,regiao):
		area = np.sum(imagem==regiao) # Soma os pixels que fazem parte da regiao
		return area
	
	def segmentacao(self):
		if self.verificaImagem(self.imagem1): # Verifica se existe imagem
			self.preBinariza() # Converte a imagem em binaria, utilizando limiarização de Otsu
			imSeg,nRegioes = self.segmenta(self.imagem1)
			print(nRegioes)
			self.resultado=imSeg.astype('uint8') # Converte o resultado para uint8
			print(np.unique(self.resultado))
			self.atualizarImagem('resultado') # Exibe o resultado
	
	def segmenta(self,imagem):
		sh=np.shape(imagem)
		imAux=-1*np.ones(sh)
		regioes=np.zeros(sh[0]*sh[1])
		regiao=0
		flag=0
		k=0
		for i in range(sh[0]):
			for j in range(sh[1]):
				if imagem[i,j]==0 and imAux[i,j]==-1:
					if regiao==0:
						regiao+=1
						regAt=regiao
						imAux[i,j]=regAt
					else:
						if imagem[i-1,j]==0 or imagem[i,j-1]==0:
							if imagem[i-1,j]==0:
								regAti=imAux[i-1,j]
							else:
								regAti=imAux[i,j-1]
							if imagem[i,j-1]==0:
								regAtj=imAux[i,j-1]
							else:
								regAtj=imAux[i-1,j]
							if regAti>regAtj:
								imAux[i-1,j]=regAtj
								regAt=regAtj
							elif regAti<regAtj:
								imAux[i,j-1]=regAti
								regAt=regAti
							else:
								regAt=regAti
						else:
							regiao+=1
							regAt=regiao
					
						imAux[i,j]=regAt
					if i<sh[0]-1:
						if imagem[i+1,j]==0:
							imAux[i+1,j]=regAt
					if j<sh[1]-1:
						if imagem[i,j+1]==0:
							imAux[i,j+1]=regAt
						
				
		for i in range(1,sh[0]-1):
			for j in range(1,sh[1]-1):
				
				if imAux[i,j]!=-1 and imAux[i-1,j]!=-1 and imAux[i,j]!=imAux[i-1,j]:
					m=np.min([imAux[i,j],imAux[i-1,j]])
					M=np.max([imAux[i,j],imAux[i-1,j]])
					imAux[imAux==M]=m
				elif imAux[i,j]!=-1 and imAux[i,j-1]!=-1 and imAux[i,j]!=imAux[i,j-1]:
					m=np.min([imAux[i,j],imAux[i,j-1]])
					M=np.max([imAux[i,j],imAux[i,j-1]])
					imAux[imAux==M]=m
		valores=np.unique(imAux[imAux!=-1])
		for k in range(1,len(valores)+1):
			imAux[imAux==valores[k-1]]=k
		nRegioes=np.max(imAux[imAux!=-1])
		imAux[imAux!=-1]*=255/(nRegioes+1)
		imAux[imAux==-1]=255
		return imAux,nRegioes
	
	def fazFechamento(self):
		self.est=elemento(int(self.fechaSize.lineEdit.text())) # Cria objeto do tipo do menu do elemento estruturante do tamanho desejado
		self.est.show() # Exibe a janela do elemento estruturante
		self.est.botao.clicked.connect(self.fechador) # Se o botao ok for selecionado
		self.fechaSize.close() # Fecha a caixa de dialogo
	
	def fechador(self):
		if self.est.okOk: # Verifica se tudo foi preenchido adequadamente
			if self.verificaImagem(self.imagem1): # Verifica se existe imagem
				self.preBinariza() # Converte a imagem em binaria, utilizando limiarização de Otsu
				aux=self.operaElemento(self.imagem1,1*self.est.brancoAtivo,'D') # Faz operação de dilatação com o elemento estruturante
				self.resultado=self.operaElemento(aux,1*self.est.brancoAtivo,'E') # Faz operação de erosão com o elemento estruturante
				self.resultado=self.resultado.astype('uint8') # Converte o resultado para uint8
				self.atualizarImagem('resultado') # Exibe o resultado
	
	def fazAbertura(self):
		self.est=elemento(int(self.abreSize.lineEdit.text())) # Cria objeto do tipo do menu do elemento estruturante do tamanho desejado
		self.est.show() # Exibe a janela do elemento estruturante
		self.est.botao.clicked.connect(self.abridor) # Se o botao ok for selecionado
		self.abreSize.close() # Fecha a caixa de dialogo
	
	def abridor(self):
		if self.est.okOk: # Verifica se tudo foi preenchido adequadamente
			if self.verificaImagem(self.imagem1): # Verifica se existe imagem
				self.preBinariza() # Converte a imagem em binaria, utilizando limiarização de Otsu
				aux=self.operaElemento(self.imagem1,1*self.est.brancoAtivo,'E') # Faz operação de erosão com o elemento estruturante
				self.resultado=self.operaElemento(aux,1*self.est.brancoAtivo,'D') # Faz operação de dilatação com o elemento estruturante
				self.resultado=self.resultado.astype('uint8') # Converte o resultado para uint8
				self.atualizarImagem('resultado') # Exibe o resultado
	
	def fazErosao(self):
		self.est=elemento(int(self.erodeSize.lineEdit.text())) # Cria objeto do tipo do menu do elemento estruturante do tamanho desejado
		self.est.show() # Exibe a janela do elemento estruturante
		self.est.botao.clicked.connect(self.erosor) # Se o botao ok for selecionado
		self.erodeSize.close() # Fecha a caixa de dialogo
	
	def erosor(self):
		if self.est.okOk: # Verifica se tudo foi preenchido adequadamente
			if self.verificaImagem(self.imagem1): # Verifica se existe imagem
				self.preBinariza() # Converte a imagem em binaria, utilizando limiarização de Otsu
				self.resultado=self.operaElemento(self.imagem1,1*self.est.brancoAtivo,'E') # Faz operação de erosão com o elemento estruturante
				self.resultado=self.resultado.astype('uint8') # Converte o resultado para uint8
				self.atualizarImagem('resultado') # Exibe o resultado
		
	def fazDilatacao(self):
		self.est=elemento(int(self.dilataSize.lineEdit.text())) # Cria objeto do tipo do menu do elemento estruturante do tamanho desejado
		self.est.show() # Exibe a janela do elemento estruturante
		self.est.botao.clicked.connect(self.dilatador) # Se o botao ok for selecionado
		self.dilataSize.close() # Fecha a caixa de dialogo
		
	def dilatador(self):
		if self.est.okOk: # Verifica se tudo foi preenchido adequadamente
			if self.verificaImagem(self.imagem1): # Verifica se existe imagem
				self.preBinariza() # Converte a imagem em binaria, utilizando limiarização de Otsu
				self.resultado=self.operaElemento(self.imagem1,1*self.est.brancoAtivo,'D') # Faz operação de dilatação com o elemento estruturante
				self.resultado=self.resultado.astype('uint8') # Converte o resultado para uint8
				self.atualizarImagem('resultado') # Exibe o resultado
	
	def operaElemento(self,imagem,pixelAtivo,qualTipo): # Faz operaçã de erosão (qualTipo='E') ou dilatação (qualTipo='D')
		elemento=self.est.elementoEstruturante==1 # Elemento estruturante como uma matriz de 0's e 1's
		if qualTipo=='E': # Caso seja erosão, espelha o elemento estruturante e utiliza o complemento da imagem
			elemento=np.flip(elemento,0) 
			elemento=np.flip(elemento,1)
			imagem=np.logical_not(imagem==255)*255
		N=self.est.tamanho # Tamanho do elemento estruturante
		sh=np.shape(imagem) # Shape da imagem
		# Inicializa array tridimensional com defasagens da imagem
		if pixelAtivo==1: # Píxel Ativo = Branco
			S=np.ones((sh[0],sh[1],N**2),dtype=bool)
		else: # Pixel Ativo = Preto
			S=np.ones((sh[0],sh[1],N**2),dtype=bool)
		C=int(np.floor(N/2)) # Encontra o meio do elemento
		n=0 # Contador pra a terceira dimensão do array
		for i in range(N):
			for j in range(N):
				dx=i-C # Translação em x
				dy=j-C # Translação em y
				S[:,:,n]=elemento[i,j]*(self.transladaRapido(imagem,dx,dy,not(pixelAtivo)*1)==255*pixelAtivo) # Translada imagem utilizando fundo inverso ao pixel ativo e verifica o píxels iguais ao píxel ativo 
				n+=1 # Incrementa o contador
		if qualTipo=='D': # Caso da dilatação
			U=S[:,:,0] # Primeira imagem transladada de S
			for k in range(1,n): # Alterna entre as demais matrizes
				aux=np.logical_or(U,S[:,:,k]) # E executa o OU lógico
				U=aux
			if pixelAtivo==1: # Píxel Ativo = Branco
				E=255*(U)
			else: # Píxel Ativo = Preto
				E=255*(np.logical_not(U))
		elif qualTipo=='E': # Caso da erosão
			U=S[:,:,0] # Primeira imagem transladada de S
			for k in range(1,n): # Alterna entre as demais matrizes
				aux=np.logical_or(U,S[:,:,k]) # E executa o OU lógico
				U=aux
			if pixelAtivo==1: # Píxel Ativo = Branco
				E=255*(np.logical_not(U))
			else: # Píxel Ativo = Preto
				E=255*(U)
		return E # Retorna E
	
	def preBinariza(self):
		limiar=self.limiarOtsu() # Obtem o limar Otimo de Otsu
		self.imagem1=(self.resultado>limiar)*255 # Converte em P&B com base no limiar
		self.imagem1=self.imagem1.astype("uint8") # Converte em uint8
		self.atualizarImagem("imagem1") # Exibe o resultado			
	
	def filtroPA(self): # Filtro Passa-Altas Básico
		if self.verificaImagem(self.imagem1): # Verifica se existe imagem
			K=(1/8)*np.array([[-1,-1,-1],[-1,8,-1],[-1,-1,-1]]) # Gera máscara
			imagem=self.imagem1.astype('double') # Para evitar truncamento da imagem
			S=self.operadorTemplate(imagem,K) # Convolui com a mascara desejada 
			S=255*(S-np.amin(S))/(np.amax(S)-np.amin(S)) # Normaliza imagem resultante (0 a 255)
			self.resultado=S
			self.resultado=self.resultado.astype('uint8')
			self.atualizarImagem('resultado') # Exibe resultado
			
	def filtroMediana(self):
		if self.verificaImagem(self.imagem1): # Verifica se existe imagem
			ok=True
			try: 
				N=int(self.medianaFilt.lineEdit.text()) # Recebe o tamanho do filtro desejado
			except: # Se nenhum tamanho for inserido, impede que seja feita a operação
				ok=False
			if ok:
				#R=self.varreMediana(self.imagem1,N)
				R=self.transMediana(self.imagem1,N) # Calcula as medianas
				self.resultado=R.astype('uint8')
				self.atualizarImagem('resultado') 
				self.medianaFilt.close() # Fecha a caixa de dialogo
			else: # Mensagem de erro, caso não seja inserido o tamanho
				QMessageBox.about(self,"Erro","Escolha primeiro o tamanho do filtro de mediana")
				
	def transMediana(self,imagem,N): # Filtragem por mediana
		mascara=np.ones((N,N)) # Gera mascara de uns NxN
		sh=np.shape(imagem) # Dimensões da imagem
		if len(sh)==3: # Colorida
			S=np.zeros((sh[0],sh[1],sh[2],N**2)) # 
		else: # Tons de Cinza
			S=np.zeros((sh[0],sh[1],N**2)) #
		C=int(np.floor(N/2)) # Encontra o centro da mascara 
		n=0 
		for i in range(N):
			for j in range(N):
				dx=i-C #  
				dy=j-C #
				if len(sh)==3: # Colorida
					S[:,:,:,n]=mascara[i,j]*self.transladaRapido(imagem,dx,dy,0) # Empilha resultado num array de 4 dimensões 
				else: # Tons de Cinza
					S[:,:,n]=mascara[i,j]*self.transladaRapido(imagem,dx,dy,0) # Empilha resultado num array de 3 dimensões
				n+=1
		if len(sh)==3: # Colorida
			M=np.median(S,3) # Calcula a mediana ao lonog da quarta dimensão
		else: # Tons de Cinza
			M=np.median(S,2) # Calcula a mediana ao lonog da quarta dimensão
		return M
	
	def filtroMedia(self): # Filtro de média
		if self.verificaImagem(self.imagem1): # Verifica se existe imagem
			ok=True
			try: 
				N=int(self.mediaFilt.lineEdit.text()) # Recebe o tamanho do filtro desejado
			except: # Se nenhum tamanho for inserido, impede que seja feita a operação
				ok=False
			if ok:
				K=(1/N**2)*np.ones((N,N)) # Gera máscara com o tamanho desejado
				imagem=self.imagem1.astype('double') # Para evitar truncamento da imagem
				S=self.operadorTemplate(imagem,K) # Convolui com a mascara desejada 
				self.resultado=S
				self.resultado=self.resultado.astype('uint8')
				self.atualizarImagem('resultado') 
				self.mediaFilt.close() # Fecha a caixa de dialogo
			else: # Mensagem de erro, caso não seja inserido o tamanho
				QMessageBox.about(self,"Erro","Escolha primeiro o tamanho do filtro de média")
		
	def filtroLaplaciano(self):
		ok=True
		if self.laplaceFilt.radioButton_3.isChecked(): # Verifica qual tamanho do Laplaciano selecionado
			K=(1/4)*np.array([[0,-1,0],[-1,4,-1],[0,-1,0]]) # Mascara do Laplaciano 3x3 normalizada
		elif self.laplaceFilt.radioButton_5.isChecked():
			K=(1/24)*np.array([[-1,-1,-1,-1,-1],[-1,-1,-1,-1,-1],[-1,-1,24,-1,-1],[-1,-1,-1,-1,-1],[-1,-1,-1,-1,-1]]) # Mascara do Laplaciano 5x5 normalizada
		elif self.laplaceFilt.radioButton_9.isChecked():
			K=(1/72)*np.array([[-1,-1,-1,-1,-1,-1,-1,-1,-1],[-1,-1,-1,-1,-1,-1,-1,-1,-1],[-1,-1,-1,-1,-1,-1,-1,-1,-1],[-1,-1,-1,8,8,8,-1,-1,-1],[-1,-1,-1,8,8,8,-1,-1,-1],[-1,-1,-1,8,8,8,-1,-1,-1],[-1,-1,-1,-1,-1,-1,-1,-1,-1],[-1,-1,-1,-1,-1,-1,-1,-1,-1],[-1,-1,-1,-1,-1,-1,-1,-1,-1]]) # Mascara do Laplaciano 9x9 normalizada
		else: # Se nenhum tamanho for selecionado, impede que seja feita a operação
			ok=False
		if ok:
			imagem=self.imagem1.astype('double')
			S=self.operadorTemplate(imagem,K) # Convolui com a mascara Laplaciana desejada 
			S=255*(S-np.amin(S))/(np.amax(S)-np.amin(S)) # Normaliza imagem resultante (0 a 255)
			self.resultado=S
			self.resultado=self.resultado.astype('uint8')
			self.atualizarImagem('resultado') 
			self.laplaceFilt.close() # Fecha a caixa de dialogo
		else: # Mensagem de erro, caso não seja selecionado o tamanho
			QMessageBox.about(self,"Erro","Escolha primeiro o tamanho do Laplaciano")
	
	def limiarizaOtsu(self): # Limiarização de Otsu
		if self.verificaImagem(self.imagem1): # Verifica se existe imagem
			limiar=self.limiarOtsu() # Obtem o limar Otimo de Otsu
			self.resultado=(self.resultado>limiar)*255 # Converte em P&B com base no limiar
			self.resultado=self.resultado.astype("uint8") # Converte em uint8
			self.atualizarImagem("resultado") # Exibe o resultado
			#show() # Mostra o histograma da imagem
			
	def limiarOtsu(self): # Encontra o Limiar Otimo
		self.conversaoCinza() # Convertem em Tons de Cinza
		h, _, _, _ = self.histograma(self.resultado,False) # Calcula os componentes do histograma, sem plotar
		Var=np.zeros(256) # Inicializa variável com as Variancias
		for T in range(256):
			G=h[0:T+1] # Componentes do histograma de 0 até T
			g=np.arange(0,T+1) # Array de 0 até T
			m=sum(G*g) # Intensidade media até T
			mg=sum(h*np.arange(256)) #Intensidade media global
			P1=sum(G) # Probabilidade de ocorrencia do conjunto G1
			Var[T]=(mg*P1-m)**2/(P1*(1-P1)+self.eps) # Calculo da Variancia
		limOtimo=np.argmax(Var) # Define como limiar maximo o valor de T que proporciona a maior variancia
		print('Limiar:',limOtimo)
		self.lcdNumber.display(limOtimo)
		return limOtimo
			
	def limiarizaGlobal(self):
		if self.verificaImagem(self.imagem1): # Verifica se existe imagem
			limiar=self.limiarGlobal() # Obtem o limar global
			self.resultado=(self.resultado>limiar)*255 # Converte em P&B com base no limiar
			self.resultado=self.resultado.astype("uint8") # Converte em uint8
			self.atualizarImagem("resultado") # Exibe o resultado
			#show() # Mostra o histograma da imagem
		
	def limiarGlobal(self):
		self.conversaoCinza() # Converte em tons de cinza
		h, _, _, _ = self.histograma(self.resultado,False) # Calcula os componentes do histograma, sem plotar
		T=127 # Inicializa T
		continua = True
		while continua:
			anT=1*T
			G1=h[0:int(np.floor(T+1))] # Grupo G1
			G2=h[int(np.floor(T+1)):256] # Grupo G2
			g1=np.arange(0,np.floor(T+1)) # Array dos valores contidos no grupo G1
			g2=np.arange(np.floor(T+1),256) # Array dos valores contidos no grupo G2
			M1=sum(G1*g1)/sum(G1+self.eps) # Media do grupo G1
			M2=sum(G2*g2)/sum(G2+self.eps) # Media do grupo G2
			T=(M1+M2)/2 # Novo T
			if abs(T-anT)<0.5: # Compara variação do T
				continua=False # Se for pequena o suficiente, encerra o loop
		print('Limiar:',T)
		self.lcdNumber.display(T)
		return T
		
	def equaliza(self):
		if self.verificaImagem(self.imagem1): # Verifica se existe imagem
			figure()
			if len(self.imagem1.shape)==3: # Imagem colorida
				_, hB, hG, hR = self.histograma(self.imagem1,True) # Calcula e plota o histograma de cada cor
				# Gera a cdf para cada histograma:
				FB=self.geraCDF(hB) #
				FG=self.geraCDF(hG) #
				FR=self.geraCDF(hR) #
				Fi=(1/255)*np.arange(256) # cdf ideal
				LB=np.zeros(256)
				LG=np.zeros(256)
				LR=np.zeros(256)
				auxIm=np.zeros(np.shape(self.imagem1))				
				for k in range(256): # Ajusta cada um dos níveis para o ponto mais proximo na cdf ideal em cada histograma
					LB[k]=np.argmin(np.absolute(FB[k]-Fi))
					auxIm[self.imagem1[:,:,0]==k,0]=LB[k]
					LG[k]=np.argmin(np.absolute(FG[k]-Fi))
					auxIm[self.imagem1[:,:,1]==k,1]=LG[k]
					LR[k]=np.argmin(np.absolute(FR[k]-Fi))
					auxIm[self.imagem1[:,:,2]==k,2]=LR[k]
				self.resultado=auxIm.astype('uint8')
				self.atualizarImagem("resultado") # Exibe resultado
				figure()
				_, hBeq, hGeq, hReq = self.histograma(self.resultado,True) # Calcula e plota o histograma de cada cor da imagem resultante
				# Gera a cdf para cada histograma:
				FBeq=self.geraCDF(hBeq)
				FGeq=self.geraCDF(hGeq)
				FReq=self.geraCDF(hReq)
				figure() # Plota as cdfs:
				plot(FB,'b--',label='Azul Original')
				plot(FG,'g--',label='Verde Original')
				plot(FR,'r--',label='Vermelho Original')
				plot(Fi,'k:',label='Ideal')
				plot(FBeq,'b',label='Azul Equalizado')
				plot(FGeq,'g',label='Verde Equalizado')
				plot(FReq,'r',label='Vermelho Equalizado')
				legend()
				show() # Exibe os plots
			else: # Imagem em tons de cinza
				h, _, _, _ = self.histograma(self.imagem1,True) # Calcula e plota o histograma
				F=self.geraCDF(h) # Gera a cdf para o histograma
				Fi=(1/255)*np.arange(256) # cdf ideal
				L=np.zeros(256)
				auxIm=np.zeros(np.shape(self.imagem1))				
				for k in range(256): # Ajusta cada um dos níveis para o ponto mais proximo na cdf ideal
					L[k]=np.argmin(np.absolute(F[k]-Fi))
					auxIm[self.imagem1==k]=L[k]
				self.resultado=auxIm.astype('uint8')
				self.atualizarImagem("resultado")
				figure()
				heq, _, _, _ = self.histograma(self.resultado,True) # Calcula e plota o histograma da imagem resultante
				Feq=self.geraCDF(heq) # Gera a cdf para o histograma
				figure() # Plota as cdfs:
				plot(F,'--',label='Original')
				plot(Fi,'k:',label='Ideal')
				plot(Feq,label='Equalizado')
				legend()
				show() # Exibe os plots
	
	def geraCDF(self,histograma): # Calcula a cdf, a partir de um histograma
		cdf=np.zeros(len(histograma))
		for k in range(len(histograma)):
			cdf[k]=sum(histograma[0:k+1])
		return cdf
	
	def autoEscala(self): # Adequa a imagem para apresentar um histograma com niveis de 0 a 255
		if self.verificaImagem(self.imagem1): # Verifica se existe imagem
			if len(self.imagem1.shape)==3: # Colorida
				self.histograma(self.imagem1,True) # Calcula e plota histogramas da imagem original
				# Calcula maximos e minimos:
				maximoB=np.max(self.imagem1[:,:,0])
				minimoB=np.min(self.imagem1[:,:,0])
				maximoG=np.max(self.imagem1[:,:,1])
				minimoG=np.min(self.imagem1[:,:,1])
				maximoR=np.max(self.imagem1[:,:,2])
				minimoR=np.min(self.imagem1[:,:,2])
				aux=np.zeros(np.shape(self.imagem1))
				# Ajusta as imagens
				aux[:,:,0]=np.around(255/(maximoB-minimoB)*(self.imagem1[:,:,0]-minimoB))
				aux[:,:,1]=np.around(255/(maximoG-minimoG)*(self.imagem1[:,:,1]-minimoG))
				aux[:,:,2]=np.around(255/(maximoR-minimoR)*(self.imagem1[:,:,2]-minimoR))
				self.resultado=aux.astype('uint8')
				figure()
				self.histograma(self.resultado,True)  # Calcula e plota histogramas da imagem ajustada
				self.atualizarImagem("resultado")
			else: # Tons de cinza
				figure()
				self.histograma(self.imagem1,True)  # Calcula e plota histograma da imagem original
				# Calcula maximo e minimo:
				maximo=np.max(self.imagem1)
				minimo=np.min(self.imagem1)
				self.resultado=np.around(255/(maximo-minimo)*(self.imagem1-minimo)) # Ajusta a imagem
				self.resultado=self.resultado.astype('uint8')
				figure()
				self.histograma(self.resultado,True)   # Calcula e plota histograma da imagem ajustada
				self.atualizarImagem("resultado")
			show() # Exibe os plots
			
	def geraHistograma(self):
		if self.verificaImagem(self.imagem1): # Verifica se existe imagem
			self.histograma(self.imagem1,True) # Calcula histograma
			show() # Exibe os plots
			
	def histograma(self,imagem,plota):
		hB=np.zeros(256)
		hG=np.zeros(256)
		hR=np.zeros(256)
		h=np.zeros(256)
		if len(imagem.shape)==3: # Colorida
			for k in range(256): # Calcula histograma
				hB[k]=sum(sum(imagem[:,:,0]==k))
				hG[k]=sum(sum(imagem[:,:,1]==k))
				hR[k]=sum(sum(imagem[:,:,2]==k))
			# Ajusta escala dos histogramas:
			hB=hB/np.size(imagem[:,:,0])
			hG=hG/np.size(imagem[:,:,1])
			hR=hR/np.size(imagem[:,:,2])
			if plota: # Plota histogramas, caso solicitado
				bar(np.arange(256),hB,color='blue',width=0.9)
				bar(np.arange(256),hG,color='green',width=0.9)
				bar(np.arange(256),hR,color='red',width=0.9)
		else: # Tons de Cinza
			for k in range(256): # Calcula histograma
				h[k]=sum(sum(imagem==k))
			h=h/np.size(imagem) # Ajusta escala do histograma
			if plota: # Plota histograma, caso solicitado
				bar(np.arange(256),h,color='black',width=0.9)
		return h, hB, hG, hR
		
	def laplaciano(self): # Detector de Bordas Laplaciano
		ok=True
		self.modoSlider='laplace'
		if self.laplace.radioButton_3.isChecked(): # Verifica qual tamanho do Laplaciano selecionado
			K=np.array([[0,-1,0],[-1,4,-1],[0,-1,0]])
		elif self.laplace.radioButton_5.isChecked():
			K=np.array([[-1,-1,-1,-1,-1],[-1,-1,-1,-1,-1],[-1,-1,24,-1,-1],[-1,-1,-1,-1,-1],[-1,-1,-1,-1,-1]])
		elif self.laplace.radioButton_9.isChecked():
			K=np.array([[-1,-1,-1,-1,-1,-1,-1,-1,-1],[-1,-1,-1,-1,-1,-1,-1,-1,-1],[-1,-1,-1,-1,-1,-1,-1,-1,-1],[-1,-1,-1,8,8,8,-1,-1,-1],[-1,-1,-1,8,8,8,-1,-1,-1],[-1,-1,-1,8,8,8,-1,-1,-1],[-1,-1,-1,-1,-1,-1,-1,-1,-1],[-1,-1,-1,-1,-1,-1,-1,-1,-1],[-1,-1,-1,-1,-1,-1,-1,-1,-1]])
		else: # Se nenhum tamanho for selecionado, impede que seja feita a operação
			ok=False
		if ok:
			S=self.operadorTemplate(self.imagem1,K) # Convolui com a mascara Laplaciana desejada 
			limiar=self.verticalSlider.value()
			self.resultado=(S>limiar)*255 # Limiariza a borda
			self.resultado=self.resultado.astype('uint8')
			self.atualizarImagem('resultado') 
			self.laplace.close() # Fecha a caixa de dialogo
		else: # Mensagem de erro, caso não seja selecionado o tamanho
			QMessageBox.about(self,"Erro","Escolha primeiro o tamanho do Laplaciano")
	
	def kirsch(self): # Detector de Bordas de Kirsch
		self.modoSlider='kirsch'
		# Mascaras de Kirsch:
		K0=np.array([[-3,-3,5],[-3,0,5],[-3,-3,5]])
		K1=np.array([[-3,5,5],[-3,0,5],[-3,-3,-3]])
		K2=np.array([[5,5,5],[-3,0,-3],[-3,-3,-3]])
		K3=np.array([[5,5,-3],[5,0,-3],[-3,-3,-3]])
		K4=np.array([[5,-3,-3],[5,0,-3],[5,-3,-3]])
		K5=np.array([[-3,-3,-3],[5,0,-3],[5,5,-3]])
		K6=np.array([[-3,-3,-3],[-3,0,-3],[5,5,5]])
		K7=np.array([[-3,-3,-3],[-3,0,5],[-3,5,5]])
		# Convolui com as mascaras
		S0=self.operadorTemplate(self.imagem1,K0)
		S1=self.operadorTemplate(self.imagem1,K1)
		S2=self.operadorTemplate(self.imagem1,K2)
		S3=self.operadorTemplate(self.imagem1,K3)
		S4=self.operadorTemplate(self.imagem1,K4)
		S5=self.operadorTemplate(self.imagem1,K5)
		S6=self.operadorTemplate(self.imagem1,K6)
		S7=self.operadorTemplate(self.imagem1,K7)
		# Encontra o maximo dos operadores
		aux0=np.maximum(S0,S1)
		aux1=np.maximum(aux0,S2)
		aux2=np.maximum(aux0,S3)
		aux3=np.maximum(aux0,S4)
		aux4=np.maximum(aux0,S5)
		aux5=np.maximum(aux0,S6)
		aux6=np.maximum(aux0,S7)
		limiar=self.verticalSlider.value()
		self.resultado=(aux6>limiar)*255 # Limiariza a borda
		self.resultado=self.resultado.astype('uint8')
		self.atualizarImagem('resultado')
		
	def sobel(self): # Detector de Bordas de Sobel
		self.modoSlider='sobel'
		mascaraX=np.array([[-1,0,1],[-2,0,2],[-1,0,1]]) # Mascara X de Sobel 
		mascaraY=np.array([[-1,-2,-1],[0,0,0],[1,2,1]]) # Mascara Y de Sobel
		# Convolui com as mascaras
		Sx=self.operadorTemplate(self.imagem1,mascaraX)
		Sy=self.operadorTemplate(self.imagem1,mascaraY)
		# Calcula a magnitude
		mag=np.sqrt(np.square(Sx)+np.square(Sy))
		limiar=self.verticalSlider.value()
		self.resultado=(mag>limiar)*255 # Limiariza a borda
		self.resultado=self.resultado.astype('uint8')
		self.atualizarImagem("resultado")
		
	def operadorTemplate(self,imagem,mascara): # Recebe uma mascara como entrada e retorna a convolução
		sh=np.shape(imagem)
		S=np.zeros(sh) # Gera matriz com tamanho da imagem
		Lx=np.size(mascara,0)
		Ly=np.size(mascara,1)
		Cx=int(np.floor(Lx/2)) # Encontra centro na direção x
		Cy=int(np.floor(Ly/2)) # Encontra centro na direção y
		for i in range(Lx):
			for j in range(Ly):
				dx=i-Cx # Deslocamento em x da posição da mascara
				dy=j-Cy # Deslocamento em y da posição da mascara
				S=S+mascara[i,j]*self.transladaRapido(imagem,dx,dy,0) # Gera as imagens transladadas
		return S
		
	def derivativo1(self): # Operador derivativo 1
		self.modoSlider='d1'
		mag= self.gradiente(self.imagem1,1) # Recebe a magnitude do gradiente de ordem 1
		limiar=self.verticalSlider.value()
		self.resultado=(mag>limiar)*255 # Limiariza a borda
		#aux2=self.imagem1 # Para exibir o contorno sobre a imagem
		#aux2[self.resultado==255]=127
		#self.resultado=aux2
		self.resultado=self.resultado.astype('uint8')
		self.atualizarImagem("resultado")
		
	def derivativo2(self): # Operador derivativo 2
		self.modoSlider='d2'
		mag= self.gradiente(self.imagem1,2) # Recebe a magnitude do gradiente de ordem 2
		limiar=self.verticalSlider.value()
		self.resultado=(mag>limiar)*255
		#aux2=self.imagem1 # Para exibir o contorno sobre a imagem
		#aux2[self.resultado==255]=127
		#self.resultado=aux2
		self.resultado=self.resultado.astype('uint8')
		self.atualizarImagem("resultado")
		
	def gradiente(self,imagem,nabla): # Calcula a magnitude do gradiente de ordem 1 ou 2
		if nabla==1: # Ordem 1
			ax=self.transladaRapido(imagem,1,0,0) # Im(x-1,y)
			ay=self.transladaRapido(imagem,0,1,0) # Im(x,y-1)
			dax=imagem-ax # Im(x,y)-Im(x-1,y)
			day=imagem-ay # Im(x,y)-Im(x,y-1)
		else: # Ordem 2
			axm=self.transladaRapido(imagem,1,0,0) # Im(x-1,y)
			aym=self.transladaRapido(imagem,0,1,0) # Im(x,y-1)
			axp=self.transladaRapido(imagem,-1,0,0) # Im(x+1,y)
			ayp=self.transladaRapido(imagem,0,-1,0) # Im(x,y+1)
			dax=axp-axm #Im(x+1,y)-Im(x-1,y)
			day=ayp-aym #Im(x,y+1)-Im(x,y-1)
		magnitude=np.sqrt(np.square(dax)+np.square(day))
		return magnitude
		
	def escalonamento(self):
		try: # Tratamento de exceções
			self.transformacao('esc',float(self.dEsc.lineEdit.text()),float(self.dEsc.lineEdit_2.text()),0,self.dEsc.checkBox.isChecked(),self.dEsc.checkBox_2.isChecked()) # Realiza transformação de escalonamento
		except: # Em caso de falha
			QMessageBox.about(self,"Erro","Um ou mais campos obrigatórios não foram preenchidos")
		self.dEsc.close() # Fecha a caixa de dialogo
		
	def rotacao(self):
		try: # Tratamento de exceções
			self.transformacao('rot',0,0,float(self.dRot.lineEdit_2.text()),self.dRot.checkBox.isChecked(),self.dRot.checkBox_2.isChecked()) # Realiza transformação de rotação
		except: # Em caso de falha
			QMessageBox.about(self,"Erro","Um ou mais campos obrigatórios não foram preenchidos")
		self.dRot.close() # Fecha a caixa de dialogo
		
	def translacao(self):
		try: # Tratamento de exceções
		# Método mais rápido:
			kx=int(round(float(self.dTrans.lineEdit.text())))
			ky=int(round(float(self.dTrans.lineEdit_2.text())))
			auxiliar=self.transladaRapido(self.imagem1,kx,ky,1)
			self.resultado=auxiliar.astype('uint8') # Converte resultado para uint8
			self.atualizarImagem('resultado') # Exibe o resultado
		# Método utilizado anteriormente:
			#self.transformacao('trans',float(self.dTrans.lineEdit.text()),float(self.dTrans.lineEdit_2.text()),0,False,False)  # Realiza transformação de translação
		except: # Em caso de falha
			QMessageBox.about(self,"Erro","Um ou mais campos obrigatórios não foram preenchidos") # Cobre todos os casos de campos obrigatórios deixados em branco
		self.dTrans.close() # Fecha a caixa de dialogo
		
	def transladaRapido(self,imagem,kx,ky,zero_um): # Faz a translação de maneira mais rapida, utilizando o índice das matrizes
		sh=np.shape(imagem)
		if zero_um==0: # Escolhe se a matriz de fundo será preenchida por 0 ou 255
			auxiliar=np.zeros(sh)
		else:
			auxiliar=np.ones(sh)*255
		if len(sh)==3:
			if kx>=0: # Translação positiva em x
				if ky>=0: # Translação positiva em y
					auxiliar[kx:sh[0],ky:sh[1],:]=imagem[0:sh[0]-kx,0:sh[1]-ky,:]
				else: # Translação negativa em y
					auxiliar[kx:sh[0],0:sh[1]-abs(ky),:]=imagem[0:sh[0]-kx,abs(ky):sh[1],:]
			else:  # Translação negativa em x
				if ky>=0: # Translação positiva em y
					auxiliar[0:sh[0]-abs(kx),ky:sh[1],:]=imagem[abs(kx):sh[0],0:sh[1]-ky,:]
				else: # Translação negativa em y
					auxiliar[0:sh[0]-abs(kx),0:sh[1]-abs(ky),:]=imagem[abs(kx):sh[0],abs(ky):sh[1],:]
		else:
			if kx>=0: # Translação positiva em x
				if ky>=0: # Translação positiva em y
					auxiliar[kx:sh[0],ky:sh[1]]=imagem[0:sh[0]-kx,0:sh[1]-ky]
				else: # Translação negativa em y
					auxiliar[kx:sh[0],0:sh[1]-abs(ky)]=imagem[0:sh[0]-kx,abs(ky):sh[1]]
			else:  # Translação negativa em x
				if ky>=0: # Translação positiva em y
					auxiliar[0:sh[0]-abs(kx),ky:sh[1]]=imagem[abs(kx):sh[0],0:sh[1]-ky]
				else: # Translação negativa em y
					auxiliar[0:sh[0]-abs(kx),0:sh[1]-abs(ky)]=imagem[abs(kx):sh[0],abs(ky):sh[1]]			
		return auxiliar
	
	def transformacao(self,qualTransformacao,X,Y,angulo,caixa,caixa2):
		if self.imagem1 is not None: # Verifica se existe a imagem1
			t=self.imagem1.shape # Recebe o formato da matriz da imagem
			imAux=255*np.ones((t[0],t[1],3)) # Cria matriz auxiliar
			centro=[int(round(t[0]/2)),int(round(t[1]/2))] # Calcula o centro da imagem

			x=np.arange(t[0]) # Vetor com os valores do eixo x
			y=np.arange(t[1]) # Vetor com os valores do eixo y
			if qualTransformacao == 'esc': # Transformação de escalonamento
				if caixa: # Em torno da origem
					mTrans=self.escMatrix([X,Y],[0,0]) # Gera matriz de escalonamento
				elif caixa2: # Em torno do centro
					mTrans=self.escMatrix([X,Y],centro) # Gera matriz de escalonamento
				else:
					C=[int(self.dEsc.lineEdit_3.text()),int(self.dEsc.lineEdit_4.text())] # Em torno dos valores inseridos nos campos
					mTrans=self.escMatrix([X,Y],C) # Gera matriz de escalonamento
			elif qualTransformacao == 'rot': # Transformação de rotação
				if caixa: # Em torno da origem
					mTrans=self.rotMatrix(angulo,[0,0]) # Gera matriz de rotação
				elif caixa2: # Em torno do centro
					mTrans=self.rotMatrix(angulo,centro) # Gera matriz de rotação
				else:
					C=[int(self.dRot.lineEdit_3.text()),int(self.dRot.lineEdit_4.text())] # Em torno dos valores inseridos nos campos
					mTrans=self.rotMatrix(angulo,C) # Gera matriz de rotação
			else:  # Transformação de translação
				mTrans=self.transMatrix([X,Y]) # Gera matriz de translação
			# Varredura das posições da imagem:
			for j in range(len(x)):
				for k in range(len(y)):
					vec=np.dot(mTrans,np.array([[x[j]],[y[k]],[1]])) # Realiza o produto matricial com as posições
					vec=np.round(vec) # Arredonda o resultado do produto
					vec=vec.astype('int') # Transforma os valores para inteiro, para garantir que possam ser usados como índices
					if (vec[0]<t[0] and vec[1]<t[1] and vec[0]>=0 and vec[1]>=0): # Utiliza somente as posições resultantes com x e y maiores que 0 e menores que seus respectivos limites
						imAux[x[j],y[k],:]=self.imagem1[vec[0],vec[1],:] # Matriz auxiliar recebe os valores da imagem nas posições obtidas 
			self.resultado=imAux.astype('uint8') # Converte resultado para uint8
			self.atualizarImagem('resultado') # Exibe o resultado
		else: # Caso não exista a imagem1
			QMessageBox.about(self,"Erro","Imagem 1 Inexistente") 
	
	def escMatrix(self,esc,center): # Gera matriz de escalonamento, podendo definir o fator de escalamento e em torno de que ponto será realizada a transformação 
		matrix=np.dot(np.array([[1,0,center[0]],[0,1,center[1]],[0,0,1]]),np.array([[(1/esc[0]),0,-(1/esc[0])*center[0]],[0,(1/esc[1]),-(1/esc[1])*center[1]],[0,0,1]])) # Matriz de escalonamento
		return matrix
	
	def rotMatrix(self,rot,center): # Gera matriz de rotação, podendo definir o angulo de rotação e em torno de que ponto será realizada a transformação
		rot=pi*rot/180 # Coloca o angulo em radianos
		matrix=np.array([[cos(-rot),-sin(-rot),(center[0]*(1-cos(-rot))+center[1]*sin(-rot))],[sin(-rot),cos(-rot),(center[1]*(1-cos(-rot))-center[0]*sin(-rot))],[0,0,1]]) # Matriz de rotação
		return matrix
	
	def transMatrix(self,trans): # Gera matriz de translação, podendo definir o valores da translação
		matrix=np.array([[1,0,-trans[0]],[0,1,-trans[1]],[0,0,1]]) # Matriz de translação
		return matrix
	
	def imagensXOR(self):
		if self.imagem1 is None:
			QMessageBox.about(self,"Erro","Imagem 1 Inexistente")
		if self.imagem2 is None:
			QMessageBox.about(self,"Erro","Imagem 2 Inexistente")
		if (self.imagem1 is not None) and (self.imagem2 is not None):
			if(self.imagem1.shape==self.imagem2.shape): # Verifica se as imagens tem o mesmo tamanho
				self.preBool(2) # Operação com 2 imagens - converte ambas para imagem binária
				aux1=(self.imagem1==255)
				aux2=(self.imagem2==255)
				aux=np.logical_xor(aux1,aux2) # Operação lógica XOR entre as imagens
				self.resultado=aux*255 # False=0 e True=255
				self.resultado=self.resultado.astype("uint8") # Transforma em uint8
				self.atualizarImagem("resultado") # Exibe o resultado
			else:
				QMessageBox.about(self,"Erro","Dimensões inconsistentes")
		
	def imagemNOT(self):
		if self.imagem1 is None:
			QMessageBox.about(self,"Erro","Imagem 1 Inexistente")
		else:
			self.preBool(1) # Operação com 1 imagem - converte para imagem binária
			aux1=(self.imagem1==255)
			aux=np.logical_not(aux1) # Operação lógica NOT na imagem
			self.resultado=aux*255 # False=0 e True=255
			self.resultado=self.resultado.astype("uint8") # Transforma em uint8
			self.atualizarImagem("resultado") # Exibe o resultado
	
	def imagensOR(self):
		if self.imagem1 is None:
			QMessageBox.about(self,"Erro","Imagem 1 Inexistente")
		if self.imagem2 is None:
			QMessageBox.about(self,"Erro","Imagem 2 Inexistente")
		if (self.imagem1 is not None) and (self.imagem2 is not None):
			if(self.imagem1.shape==self.imagem2.shape): # Verifica se as imagens tem o mesmo tamanho
				self.preBool(2) # Operação com 2 imagens - converte ambas para imagem binária
				aux1=(self.imagem1==255)
				aux2=(self.imagem2==255)
				aux=np.logical_or(aux1,aux2) # Operação lógica OR entre as imagens
				self.resultado=aux*255 # False=0 e True=255
				self.resultado=self.resultado.astype("uint8") # Transforma em uint8
				self.atualizarImagem("resultado") # Exibe o resultado
			else:
				QMessageBox.about(self,"Erro","Dimensões inconsistentes")
	
	def imagensAND(self):
		if self.imagem1 is None:
			QMessageBox.about(self,"Erro","Imagem 1 Inexistente")
		if self.imagem2 is None:
			QMessageBox.about(self,"Erro","Imagem 2 Inexistente")
		if (self.imagem1 is not None) and (self.imagem2 is not None):
			if(self.imagem1.shape==self.imagem2.shape): # Verifica se as imagens tem o mesmo tamanho
				self.preBool(2) # Operação com 2 imagens - converte ambas para imagem binária
				aux1=(self.imagem1==255)
				aux2=(self.imagem2==255)
				aux=np.logical_and(aux1,aux2) # Operação lógica AND entre as imagens
				self.resultado=aux*255 # False=0 e True=255
				self.resultado=self.resultado.astype("uint8") # Transforma em uint8
				self.atualizarImagem("resultado") # Exibe o resultado
			else:
				QMessageBox.about(self,"Erro","Dimensões inconsistentes")
	
	def preBool(self,nImagens): # Converte as imagens que passarão pela operação booleana em binárias
		if nImagens==2: # A operação será realizada com 2 imagens
			self.conversaoBinaria()
			self.usarResultado()
			self.imagem1to2()
			self.conversaoBinaria()
			self.usarResultado()
			self.imagem1to2()
			self.atualizarImagem("imagem1")
			self.atualizarImagem("imagem2")
		elif nImagens==1: # A operação será realizada com apenas 1 imagem
			self.conversaoBinaria()
			self.usarResultado()
			self.atualizarImagem("imagem1")
	
	def adicaoImagens(self):
		if self.imagem1 is None:
			QMessageBox.about(self,"Erro","Imagem 1 Inexistente")
			if (self.imagem2 is None) and (not self.dAdd.checkBox_2.isChecked()):
				QMessageBox.about(self,"Erro","Imagem 2 Inexistente")
		else:
			if self.dAdd.checkBox_2.isChecked(): # Checa se a operação será com apenas 1 imagem (soma com constante)
				try:
					self.opAritmeticas('soma',self.dAdd.checkBox.isChecked(),True) # Faz a operação de soma com constante
				except:
					QMessageBox.about(self,"Erro","Constante Inválida\nInsira um valor inteiro")
			elif self.imagem2 is None:
				QMessageBox.about(self,"Erro","Imagem 2 Inexistente")
			elif(self.imagem1.shape==self.imagem2.shape): # Checa se as 2 imagens são do mesmo tamanho
				self.opAritmeticas('soma',self.dAdd.checkBox.isChecked(),False) # Faz a operação de soma das 2 imagens
			else: # Há um erro de dimensões
				QMessageBox.about(self,"Erro","Dimensões inconsistentes")
		self.dAdd.close() # Fecha a caixa de dialogo
	
	def subtracaoImagens(self):
		if self.imagem1 is None:
			QMessageBox.about(self,"Erro","Imagem 1 Inexistente")
			if (self.imagem2 is None) and (not self.dSub.checkBox_2.isChecked()):
				QMessageBox.about(self,"Erro","Imagem 2 Inexistente")
		else:
			if self.dSub.checkBox_2.isChecked(): # Checa se a operação será com apenas 1 imagem (subtração com constante)
				try:
					self.opAritmeticas('sub',self.dSub.checkBox.isChecked(),True) # Faz a operação de subtração com constante
				except:
					QMessageBox.about(self,"Erro","Constante Inválida\nInsira um valor inteiro")
			elif self.imagem2 is None:
				QMessageBox.about(self,"Erro","Imagem 2 Inexistente")
			elif(self.imagem1.shape==self.imagem2.shape): # Checa se as 2 imagens são do mesmo tamanho
				self.opAritmeticas('sub',self.dSub.checkBox.isChecked(),False) # Faz a operação de subtração das 2 imagens
			else: # Há um erro de dimensões
				QMessageBox.about(self,"Erro","Dimensões inconsistentes")
		self.dSub.close() # Fecha a caixa de dialogo
	
	def multiplicacaoImagens(self):
		if self.imagem1 is None:
			QMessageBox.about(self,"Erro","Imagem 1 Inexistente")
		else:
			try:
				self.opAritmeticas('mult',False,False) # Faz a operação de multiplicação por constante
			except:
				QMessageBox.about(self,"Erro","Constante Inválida\nInsira um valor real")
		self.dMult.close() # Fecha a caixa de dialogo
	
	def divisaoImagens(self):
		if self.imagem1 is None:
			QMessageBox.about(self,"Erro","Imagem 1 Inexistente")
		else:
			try:
				self.opAritmeticas('div',False,False) # Faz a operação de divisão por constante
			except:
				QMessageBox.about(self,"Erro","Constante Inválida\nInsira um valor real")
		self.dDiv.close() # Fecha a caixa de dialogo
	
	def opAritmeticas(self,qualOperacao,normaliza,constante):
		# Verifica qual a operação a ser realizada (soma, subtração, multiplicação, divisão)
		if qualOperacao=='soma':
			if constante: # soma com constante
				aux=self.imagem1.astype("int")+int(self.dAdd.lineEdit.text())
			else: # soma entre imagens
				aux=self.imagem1.astype("int")+self.imagem2.astype("int")			
		elif qualOperacao=='sub':
			if constante: # subtração com constante
				aux=self.imagem1.astype("int")-int(self.dSub.lineEdit.text())
			else: # subtração entre imagens
				aux=self.imagem1.astype("int")-self.imagem2.astype("int")
		elif qualOperacao=='mult': # multiplicação por constante
			aux=self.imagem1.astype("int")*float(self.dMult.lineEdit.text())
		else: # divisão por constante
			aux=self.imagem1.astype("int")/float(self.dDiv.lineEdit.text())
		
		if normaliza: # Normaliza operação?
			aux=255*(aux-np.amin(aux))/(np.amax(aux)-np.amin(aux))
		else:
			aux[aux>255]=255
			aux[aux<0]=0
		self.resultado=aux
		self.resultado=self.resultado.astype("uint8")
		self.atualizarImagem("resultado") # Exibe resultado
			
	def sairPrograma(self): # Fecha programa
		sys.exit()
	
	def usarResultado(self): # Transfere resultado para a imagem1
		self.imagem1=self.resultado
		if self.resultado is not None:
			self.atualizarImagem('imagem1')
			self.modoSlider='pb'
		else:
			QMessageBox.about(self,"Erro","Imagem Resultado Inexistente")
	
	def imagem1to2(self): # Troca imagem1 com imagem2
		if self.imagem1 is None:
			QMessageBox.about(self,"Erro","Imagem 1 Inexistente")
		if self.imagem2 is None:
			QMessageBox.about(self,"Erro","Imagem 2 Inexistente")
		auxiliar=self.imagem1
		self.imagem1=self.imagem2
		self.imagem2=auxiliar
		if (self.imagem1 is not None) and (self.imagem2 is not None):
			self.atualizarImagem("imagem1")
			self.atualizarImagem("imagem2")
			self.modoSlider='pb'
			
	def abreImagem1(self):
		self.modoSlider='pb' # Define a conversão binaria como função padrão do slider 
		filename = QFileDialog.getOpenFileName(self)
		self.imagem1 = cv2.imread(filename[0])
		if self.imagem1 is not None:
			self.atualizarImagem('imagem1')
	
	def abreImagem2(self):
		filename = QFileDialog.getOpenFileName(self)
		self.imagem2 = cv2.imread(filename[0])
		if self.imagem2 is not None:
			self.atualizarImagem('imagem2')
	
	def salvaResultado(self):
		if self.resultado is None:
			QMessageBox.about(self,"Erro","Imagem Resultado Inexistente")
		else:
			filename = QFileDialog.getSaveFileName(self)
			cv2.imwrite(filename[0],self.resultado)
	
	def atualizarImagem(self,qualImagem): # Exibe imagem desejada
		if qualImagem=="imagem1":
			imagem=self.imagem1
			labImagem=self.labImagem1
		elif qualImagem=="imagem2":
			imagem=self.imagem2
			labImagem=self.labImagem2
		elif qualImagem=="resultado":
			imagem=self.resultado
			labImagem=self.labResultado
		else:
			imagem=self.auxiliar
			labImagem=self.labAuxiliar
		try:	
			if len(imagem.shape)==3:
				B,G,R=cv2.split(imagem)
				qImagem=QImage(cv2.merge((R,G,B)), imagem.shape[1], imagem.shape[0], imagem.strides[0], QImage.Format_RGB888)
			else:
				qImagem=QImage(imagem, imagem.shape[1], imagem.shape[0], imagem.strides[0], QImage.Format_Indexed8)
				qImagem.setColorTable([qRgb(i,i,i) for i in range(256)])
			mapaPixels=QPixmap.fromImage(qImagem)
			mapaPixels=mapaPixels.scaled(labImagem.size(),Qt.KeepAspectRatio,Qt.SmoothTransformation)
			labImagem.setPixmap(mapaPixels)	
		except:
			QMessageBox.about(self,"Erro","Imagem Inexistente")
	
	def converteToCinza(self):
		if self.imagem1 is None: # Caso não tenha imagem, solicita a abertura
			QMessageBox.about(self,"Erro","Imagem 1 Inexistente!\nPrimeiro, abra uma Imagem.")
		else:
			self.conversaoCinza() # Converte em tons de cinza
			self.atualizarImagem("resultado")
	
	def conversaoCinza(self):
		if len(self.imagem1.shape)==3:
			self.resultado=0.1140*self.imagem1[:,:,0]+0.5870*self.imagem1[:,:,1]+0.2989*self.imagem1[:,:,2] #B-0G-1R-2
		else:
			self.resultado=self.imagem1
		self.resultado=self.resultado.astype("uint8") # Converte em uint8
	
	def converteBinaria(self):
		self.modoSlider='pb'
		if self.imagem1 is None: # Caso não tenha imagem, solicita a abertura
			QMessageBox.about(self,"Erro","Imagem 1 Inexistente!\nPrimeiro, abra uma Imagem.")
		else:
			self.conversaoBinaria() # Converte em imagem binária
			self.atualizarImagem("resultado")
	
	def conversaoBinaria(self):
		self.conversaoCinza() # Converte em cinza
		limiar=self.verticalSlider.value() # Detecta limiar do slider
		self.resultado=(self.resultado>limiar)*255 # Converte em P&B com base no limiar
		self.resultado=self.resultado.astype("uint8") # Converte em uint8
	
	def mudouLimiar(self): # Verifica mudança no limiar
		self.lcdNumber.display(self.verticalSlider.value()) # Exibe no display novo valor do limiar
		if self.imagem1 is not None:
			# Seleciona a funcionalidade do slider
			if self.modoSlider=='laplace':
				self.laplaciano()
			elif self.modoSlider=='kirsch':
				self.kirsch()
			elif self.modoSlider=='sobel':
				self.sobel()
			elif self.modoSlider=='d1':
				self.derivativo1()
			elif self.modoSlider=='d2':
				self.derivativo2()
			else:
				self.converteBinaria() # Executa conversão da imagem para binaria
	def verificaImagem(self,imagem):
		if imagem is None: # Caso não tenha imagem, solicita a abertura e indica a ausencia da imagem
			QMessageBox.about(self,"Erro","Imagem 1 Inexistente!\nPrimeiro, abra uma Imagem.")
			temImagem=False
		else:
			temImagem=True
		return temImagem
# Principal

app=QApplication(sys.argv)
janela=interfaceApp()
#janela=elemento(3)
janela.show()

sys.exit(app.exec_())

