clear all, clc, close all;

X = load('digit_xtest.csv');
X = X(1:2500, :)./255;
X = X - repmat(mean(X,2), 1, size(X,2));
% X = (X - min(X(:)));
X = X/max(X(:));
% X = X ./ repmat(std(X')', 1, size(X,2));
X_ruido = X + 0.1*randn(size(X)); %adicao de ruido branco
% X_ruido = X_ruido - min(X_ruido(:));
X_ruido = X_ruido/max(X_ruido(:));
X = X';
X_ruido = X_ruido';
% exemplos = reshape(X(50,:),28,28);
% exemplos = [exemplos reshape(X_ruido(50,:), 28, 28)];
% imagesc(exemplos), colormap(gray), axis off;


%Construção considerando os dados alocados vetores coluna
%Construção dos Pesos Sinápticos
%AE1 parametros
W1 = 2*rand(1024, size(X,1)) - 1;
W1 = W1*sqrt(2/size(W1,1));
mmt1 = zeros(size(W1));
W11 = 2*rand(424, size(W1,1)) - 1;
W11 = W11*sqrt(2/size(W11,1));
mmt11 = zeros(size(W11));

B1 = 2*rand(size(W1,1), 1) - 1;
mmtB1 = zeros(size(B1));
B1 = B1*sqrt(2/size(B1,1));
B11 = 2*rand(size(W11,1), 1) - 1;
mmtB11 = zeros(size(B11));
B11 = B11*sqrt(2/size(B11,1));


%AE2 parametros
W2 = 2*rand(96, size(W11,1)) - 1;
mmt2 = zeros(size(W2));
W2 = W2*sqrt(2/size(W2,1));
W22 = 2*rand(32, size(W2,1)) - 1;
W22 = W22*sqrt(2/size(W22,1));
mmt22 = zeros(size(W22));

B2 = 2*rand(size(W2,1), 1) - 1;
mmtB2 = zeros(size(B2));
B2 = B2*sqrt(2/size(B2,1));
B22 = 2*rand(size(W22,1), 1) - 1;
mmtB22 = zeros(size(B22));
B22 = B22*sqrt(2/size(B22,1));

%AE3 parametros

W3 = 2*rand(8, size(W22,1)) - 1;
mmt3 = zeros(size(W3));
W3 = W3*sqrt(2/size(W3,1));

W33 = 2*rand(2, size(W3,1)) - 1;
W33 = W33*sqrt(2/size(W33,1));
mmt33 = zeros(size(W33));

B3 = 2*rand(size(W3,1), 1) - 1;
mmtB3 = zeros(size(B3));
B3 = B3*sqrt(2/size(B3,1));
B33 = 2*rand(size(W33,1), 1) - 1;
mmtB33 = zeros(size(B33));
B33 = B33*sqrt(2/size(B33,1));


%AE4 parametros

W4 = 2*rand(8, size(W33,1)) - 1;
mmt4 = zeros(size(W4));
W4 = W4*sqrt(2/size(W4,1));
W44 = 2*rand(32, size(W4,1)) - 1;
W44 = W44*sqrt(2/size(W44,1));
mmt44 = zeros(size(W44));

B4 = 2*rand(size(W4,1), 1) - 1;
mmtB4 = zeros(size(B4));
B4 = B3*sqrt(2/size(B4,1));
B44 = 2*rand(size(W44,1), 1) - 1;
mmtB44 = zeros(size(B44));
B44 = B44*sqrt(2/size(B44,1));



%AE5 parametros

W5 = 2*rand(96, size(W44,1)) - 1;
mmt5 = zeros(size(W5));
W5 = W5*sqrt(2/size(W5,1));
W55 = 2*rand(424, size(W5,1)) - 1;
W55 = W55*sqrt(2/size(W55,1));
mmt55 = zeros(size(W55));

B5 = 2*rand(size(W5,1), 1) - 1;
mmtB5 = zeros(size(B5));
B5 = B5*sqrt(2/size(B5,1));
B55 = 2*rand(size(W55,1), 1) - 1;
mmtB55 = zeros(size(B55));
B55 = B55*sqrt(2/size(B55,1));


%AE6 parametros

W6 = 2*rand(1024, size(W55,1)) - 1;
mmt6 = zeros(size(W6));
W6 = W6*sqrt(2/size(W6,1));
W66 = 2*rand(784, size(W6,1)) - 1;
W66 = W66*sqrt(2/size(W66,1));
mmt66 = zeros(size(W66));

B6 = 2*rand(size(W6,1), 1) - 1;
mmtB6 = zeros(size(B6));
B6 = B6*sqrt(2/size(B6,1));
B66 = 2*rand(size(W66,1), 1) - 1;
mmtB66 = zeros(size(B66));
B66 = B66*sqrt(2/size(B66,1));

%Configuracao dos Ganhos Adaptativos
ganhos_adap_W1 = ones(size(W1));
ganhos_adap_W11 = ones(size(W11));
ganhos_adap_W2 = ones(size(W2));
ganhos_adap_W22 = ones(size(W22));
ganhos_adap_W3 = ones(size(W3));
ganhos_adap_W33 = ones(size(W33));
ganhos_adap_W4 = ones(size(W4));
ganhos_adap_W44 = ones(size(W44));
ganhos_adap_W5 = ones(size(W5));
ganhos_adap_W55 = ones(size(W55));
ganhos_adap_W6 = ones(size(W6));
ganhos_adap_W66 = ones(size(W66));

ganhos_adap_B1 = ones(size(B1));
ganhos_adap_B11 = ones(size(B11));
ganhos_adap_B2 = ones(size(B2));
ganhos_adap_B22 = ones(size(B22));
ganhos_adap_B3  = ones(size(B3));
ganhos_adap_B33 = ones(size(B33));
ganhos_adap_B4 = ones(size(B4));
ganhos_adap_B44 = ones(size(B44));
ganhos_adap_B5 = ones(size(B5));
ganhos_adap_B55 = ones(size(B55));
ganhos_adap_B6 = ones(size(B6));
ganhos_adap_B66 = ones(size(B66));



ganho_min = 0.00001;
epoch = 1500;
alfa = 0.001e-3;
beta1 = 0.0015e-3;
J = zeros(epoch, 1);
ee = 0;
atual = 1;
% figure
%Primeira camada
% figure(2)
% figure(3)

%Configuração do objeto para gravar o video 
for eee = atual + 1: 2*epoch
    for i = 1:2500
        x = X_ruido(:,i);
        %passo forward sera dividido varios autoencoders para evitar
        %o problema do gradiente ir a zero
%         
%         X_ruido_shuffle = zeros(size(X));
%         I = randperm(size(X,2));
%         for i = 1:length(I)
%             X_ruido_shuffle(:,i) = X_ruido(:,I(i));
%         end
        %AE1
        a1  = reshape(relu(W1*x + B1), size(W1,1), size(B1,2));
        a11 = reshape(relu(W11*a1 + B11), size(W11,1), size(B11,2));
        a2  = reshape(relu(W2*a11 + B2),  size(W2,1), size(B2,2));
        a22 = reshape(relu(W22*a2 + B22), size(W22,1), size(B22,2));
        a3  = reshape(relu(W3*a22 + B3),  size(W3,1), size(B3,2));
        a33 = reshape(tanh(W33*a3 + B33), size(W33,1), size(B33,2));
        a4  = reshape(relu(W4*a33 + B4),  size(W4,1), size(B4,2));
        a44 = reshape(relu(W44*a4 + B44), size(W44,1), size(B44,2));
        a5  = reshape(relu(W5*a44 + B5),  size(W5,1), size(B5,2));
        a55 = reshape(relu(W55*a5 + B55), size(W55,1), size(B55,2));
        a6  = reshape(relu(W6*a55 + B6),  size(W6,1), size(B66,2));
       
        y1 = tanh(W66*a6 + B66);
        
        %backprop AE1
        a1_p  = (a1 > 0);
%         a1_p(a1_p == 0) = 0.00001;
        a11_p = a11 > 0;
%         a11_p(a11_p == 0) = 0.00001;
        a2_p  = a2 > 0;
%         a2_p(a2_p == 0) = 0.00001;
        a22_p = a22 > 0;
%         a22_p(a22_p == 0) = 0.00001;
        a3_p  = a3 > 0;
%         a3_p(a3_p == 0) = 0.00001;
%         a33_p  = a33.*(1 - a33);%logistic function derivative
        a33_p  = (1 - a33.^2);%tanh derivative
%         a3_p(a3_p == 0) = 0.00001;
        a4_p  = a4 > 0;
%         a4_p(a4_p == 0) = 0.00001;
        a44_p = a44 > 0;
%         a44_p(a44_p == 0) = 0.00001;
        a5_p  = a5 > 0;
%         a5_p(a5_p == 0) = 0.00001;
        a55_p = a55 > 0;
%         a55_p(a55_p == 0) = 0.00001;
        a6_p  = a6 > 0;
%         a6_p(a6_p == 0) = 0.00001;
        y1_p  = (1 - y1.^2);%tanh derivative
%         y1_p  = y1.*(1 - y1);%logistic function derivative

        e = x - y1;
        delta_1 = e;
        
        e1 = W66'*delta_1;
        delta_2 = a6_p.*e1;
        
        e2 = W6'*delta_2;
        delta_3 = a55_p.*e2;
        
        e3 = W55'*delta_3;
        delta_4 = a5_p.*e3;
        
        e4 = W5'*delta_4;
        delta_5 = a44_p.*e4;
        
        e5 = W44'*delta_5;
        delta_6 = a4_p.*e5;
        
        e6 = W4'*delta_6;
        delta_7 = a33_p.*e6;
        
        e7 = W33'*delta_7;
        delta_8 = a3_p.*e7;
        
        e8 = W3'*delta_8;
        delta_9 = a22_p.*e8;
        
        e9 = W22'*delta_9;
        delta_10 = a2_p.*e9;
        
        e10 = W2'*delta_10;
        delta_11 = a11_p.*e10;
        
        e11 = W11'*delta_11;
        delta_12 = a1_p.*e11;
        
        %atualizacao das sinapses
        dE6_dW66 = delta_1*a6';
        dE6_dW6  = delta_2*a55';
        dE5_dW55 = delta_3*a5';
        dE5_dW5  = delta_4*a44';
        dE4_dW44 = delta_5*a4';
        dE4_dW4  = delta_6*a33';
        dE3_dW33 = delta_7*a3';
        dE3_dW3  = delta_8*a22';
        dE2_dW22 = delta_9*a2';
        dE2_dW2  = delta_10*a11';
        dE1_dW11 = delta_11*a1';
        dE1_dW1  = delta_12*x';
        
%       Codigo para ajuste de todo mundo atraves de ganhos adaptativos singulares         
%         ganhos_eta = (ganhos_eta + .05) .* (sign(y_grad) ~= sign(incre_y))...
%                  + (ganhos_eta + .02) .* (sign(y_grad) == sign(incre_y));
%         
        
       ganhos_adap_W66 = (ganhos_adap_W66 + .00003).*(sign(dE6_dW66) ~= sign(mmt66))...
                         + (ganhos_adap_W66 + .00006).*(sign(dE6_dW66) == sign(mmt66));
       ganhos_adap_W66(ganhos_adap_W66 < ganho_min) = ganho_min;
       
       ganhos_adap_W6 = (ganhos_adap_W6 + .00003).*(sign(dE6_dW6) ~= sign(mmt6))...
                         + (ganhos_adap_W6 + .00006).*(sign(dE6_dW6) == sign(mmt6));
       ganhos_adap_W6(ganhos_adap_W6 < ganho_min) = ganho_min; 
       
       ganhos_adap_W55 = (ganhos_adap_W55 + .00003).*(sign(dE5_dW55) ~= sign(mmt55))...
                         + (ganhos_adap_W55 + .00006).*(sign(dE5_dW55) == sign(mmt55));
       ganhos_adap_W55(ganhos_adap_W55 < ganho_min) = ganho_min;
       
       ganhos_adap_W5 = (ganhos_adap_W5 + .00003).*(sign(dE5_dW5) ~= sign(mmt5))...
                         + (ganhos_adap_W5 + .00006).*(sign(dE5_dW5) == sign(mmt5));
       ganhos_adap_W5(ganhos_adap_W5 < ganho_min) = ganho_min;

       ganhos_adap_W44 = (ganhos_adap_W44 + .00003).*(sign(dE4_dW44) ~= sign(mmt44))...
                         + (ganhos_adap_W44 + .00006).*(sign(dE4_dW44) == sign(mmt44));
       ganhos_adap_W44(ganhos_adap_W44 < ganho_min) = ganho_min;
       
       ganhos_adap_W4 = (ganhos_adap_W4 + .00003).*(sign(dE4_dW4) ~= sign(mmt4))...
                         + (ganhos_adap_W4 + .00006).*(sign(dE4_dW4) == sign(mmt4));
       ganhos_adap_W4(ganhos_adap_W4 < ganho_min) = ganho_min;
      
       ganhos_adap_W33 = (ganhos_adap_W33 + .00008).*(sign(dE3_dW33) ~= sign(mmt33))...
                         + (ganhos_adap_W33 + .00006).*(sign(dE3_dW33) == sign(mmt33));
       ganhos_adap_W33(ganhos_adap_W33 < ganho_min) = ganho_min;
       
       ganhos_adap_W3 = (ganhos_adap_W3 + .00008).*(sign(dE3_dW3) ~= sign(mmt3))...
                         + (ganhos_adap_W3 + .00006).*(sign(dE3_dW3) == sign(mmt3));
       ganhos_adap_W3(ganhos_adap_W3 < ganho_min) = ganho_min;
       
       ganhos_adap_W22 = (ganhos_adap_W22 + .00008).*(sign(dE2_dW22) ~= sign(mmt22))...
                         + (ganhos_adap_W22 + .00006).*(sign(dE2_dW22) == sign(mmt22));
       ganhos_adap_W22(ganhos_adap_W22 < ganho_min) = ganho_min;
       
       ganhos_adap_W2 = (ganhos_adap_W2 + .00008).*(sign(dE2_dW2) ~= sign(mmt2))...
                         + (ganhos_adap_W2 + .00006).*(sign(dE2_dW2) == sign(mmt2));
       ganhos_adap_W2(ganhos_adap_W2 < ganho_min) = ganho_min;
       
       ganhos_adap_W11 = (ganhos_adap_W11 + .00008).*(sign(dE1_dW11) ~= sign(mmt11))...
                         + (ganhos_adap_W11 + .00006).*(sign(dE1_dW11) == sign(mmt11));
       ganhos_adap_W11(ganhos_adap_W11 < ganho_min) = ganho_min;
       
       ganhos_adap_W1 = (ganhos_adap_W1 + .00008).*(sign(dE1_dW1) ~= sign(mmt1))...
                         + (ganhos_adap_W1 + .00006).*(sign(dE1_dW1) == sign(mmt1));
       ganhos_adap_W1(ganhos_adap_W1 < ganho_min) = ganho_min;
       
        mmt66 = alfa*(dE6_dW66.*ganhos_adap_W66) + beta1*mmt66;
        mmt6  = alfa*(dE6_dW6.*ganhos_adap_W6) + beta1*mmt6;
        mmt55 = alfa*(dE5_dW55.*ganhos_adap_W55) + beta1*mmt55;
        mmt5  = alfa*(dE5_dW5.*ganhos_adap_W5) + beta1*mmt5;
        mmt44 = alfa*(dE4_dW44.*ganhos_adap_W44) + beta1*mmt44;
        mmt4  = alfa*(dE4_dW4.*ganhos_adap_W4) + beta1*mmt4;
        mmt33 = alfa*(dE3_dW33.*ganhos_adap_W33) + beta1*mmt33;
        mmt3  = alfa*(dE3_dW3.*ganhos_adap_W3) + beta1*mmt3;
        mmt22  = alfa*(dE2_dW22.*ganhos_adap_W22) + beta1*mmt22;
        mmt2  = alfa*(dE2_dW2.*ganhos_adap_W2) + beta1*mmt2;
        mmt11 = alfa*(dE1_dW11.*ganhos_adap_W11) + beta1*mmt11;
        mmt1  = alfa*(dE1_dW1.*ganhos_adap_W1) + beta1*mmt1;
        
        %atualizacao dos limiares
        dE6_dB66 = delta_1;
        dE6_dB6  = delta_2;
        dE5_dB55 = delta_3;
        dE5_dB5  = delta_4;
        dE4_dB44 = delta_5;
        dE4_dB4  = delta_6;
        dE3_dB33 = delta_7;
        dE3_dB3  = delta_8;
        dE2_dB22 = delta_9;
        dE2_dB2  = delta_10;
        dE1_dB11 = delta_11;
        dE1_dB1  = delta_12; 
        
        ganhos_adap_B66 = (ganhos_adap_B66 + .00003).*(sign(dE6_dB66) ~= sign(mmtB66))...
                         + (ganhos_adap_B66 + .00004).*(sign(dE6_dB66) == sign(mmtB66));
       ganhos_adap_B66(ganhos_adap_B66 < ganho_min) = ganho_min;
       
       ganhos_adap_B6 = (ganhos_adap_B6 + .00003).*(sign(dE6_dB6) ~= sign(mmtB6))...
                         + (ganhos_adap_B6 + .00004).*(sign(dE6_dB6) == sign(mmtB6));
       ganhos_adap_B6(ganhos_adap_B6 < ganho_min) = ganho_min; 
       
       ganhos_adap_B55 = (ganhos_adap_B55 + .00003).*(sign(dE5_dB55) ~= sign(mmtB55))...
                         + (ganhos_adap_B55 + .00004).*(sign(dE5_dB55) == sign(mmtB55));
       ganhos_adap_B55(ganhos_adap_B55 < ganho_min) = ganho_min;
       
       ganhos_adap_B5 = (ganhos_adap_B5 + .00003).*(sign(dE5_dB5) ~= sign(mmtB5))...
                         + (ganhos_adap_B5 + .00004).*(sign(dE5_dB5) == sign(mmtB5));
       ganhos_adap_B5(ganhos_adap_B5 < ganho_min) = ganho_min;

       ganhos_adap_B44 = (ganhos_adap_B44 + .00003).*(sign(dE4_dB44) ~= sign(mmtB44))...
                         + (ganhos_adap_B44 + .00004).*(sign(dE4_dB44) == sign(mmtB44));
       ganhos_adap_B44(ganhos_adap_B44 < ganho_min) = ganho_min;
       
       ganhos_adap_B4 = (ganhos_adap_B4 + .00003).*(sign(dE4_dB4) ~= sign(mmtB4))...
                         + (ganhos_adap_B4 + .00004).*(sign(dE4_dB4) == sign(mmtB4));
       ganhos_adap_B4(ganhos_adap_B4 < ganho_min) = ganho_min;
      
       ganhos_adap_B33 = (ganhos_adap_B33 + .00006).*(sign(dE3_dB33) ~= sign(mmtB33))...
                         + (ganhos_adap_B33 + .00004).*(sign(dE3_dB33) == sign(mmtB33));
       ganhos_adap_B33(ganhos_adap_B33 < ganho_min) = ganho_min;
       
       ganhos_adap_B3 = (ganhos_adap_B3 + .00006).*(sign(dE3_dB3) ~= sign(mmtB3))...
                         + (ganhos_adap_B3 + .00004).*(sign(dE3_dB3) == sign(mmtB3));
       ganhos_adap_B3(ganhos_adap_B3 < ganho_min) = ganho_min;
       
       ganhos_adap_B22 = (ganhos_adap_B22 + .00006).*(sign(dE2_dB22) ~= sign(mmtB22))...
                         + (ganhos_adap_B22 + .00004).*(sign(dE2_dB22) == sign(mmtB22));
       ganhos_adap_B22(ganhos_adap_B22 < ganho_min) = ganho_min;
       
       ganhos_adap_B2 = (ganhos_adap_B2 + .00006).*(sign(dE2_dB2) ~= sign(mmtB2))...
                         + (ganhos_adap_B2 + .00004).*(sign(dE2_dB2) == sign(mmtB2));
       ganhos_adap_B2(ganhos_adap_B2 < ganho_min) = ganho_min;
       
       ganhos_adap_B11 = (ganhos_adap_B11 + .00006).*(sign(dE1_dB11) ~= sign(mmtB11))...
                         + (ganhos_adap_B11 + .00004).*(sign(dE1_dB11) == sign(mmtB11));
       ganhos_adap_B11(ganhos_adap_B11 < ganho_min) = ganho_min;
       
       ganhos_adap_B1 = (ganhos_adap_B1 + .00006).*(sign(dE1_dB1) ~= sign(mmtB1))...
                         + (ganhos_adap_B1 + .00004).*(sign(dE1_dB1) == sign(mmtB1));
       ganhos_adap_B1(ganhos_adap_B1 < ganho_min) = ganho_min;
        
        mmtB66 = alfa*(dE6_dB66.*ganhos_adap_B66) + beta1*mmtB66;
        mmtB6  = alfa*(dE6_dB6.*ganhos_adap_B6) + beta1*mmtB6;
        mmtB55 = alfa*(dE5_dB55.*ganhos_adap_B55) + beta1*mmtB55;
        mmtB5  = alfa*(dE5_dB5.*ganhos_adap_B5) + beta1*mmtB5;
        mmtB44 = alfa*(dE4_dB44.*ganhos_adap_B44) + beta1*mmtB44;
        mmtB4  = alfa*(dE4_dB4.*ganhos_adap_B4) + beta1*mmtB4;
        mmtB33 = alfa*(dE3_dB33.*ganhos_adap_B33) + beta1*mmtB33;
        mmtB3  = alfa*(dE3_dB3.*ganhos_adap_B3) + beta1*mmtB3;
        mmtB22 = alfa*(dE2_dB22.*ganhos_adap_B22) + beta1*mmtB22;
        mmtB2  = alfa*(dE2_dB2.*ganhos_adap_B2) + beta1*mmtB2;
        mmtB11 = alfa*(dE1_dB11.*ganhos_adap_B11) + beta1*mmtB11;
        mmtB1  = alfa*(dE1_dB1.*ganhos_adap_B1) + beta1*mmtB1;
        %visualizacao 
%         if mod(i,450) == 0
%             for j = 1:size(X,2)
%                 a111 = relu(W1*X(:,j) + B1);
%                 a222 = relu(W11*a111 + B11);
%                 a333 = relu(W2*a222 + B2);
%                 y33(:,j) = a333;
%             end
%             figure(3), subplot(211)
%             scatter3(y33(1,:),y33(2,:),y33(3,:), ms, X(1,:), 'filled')
%             colormap jet(256)
%             for j = 1:size(X,2)
%                 a111 = relu(W1*X(:,j) + B1);
%                 a222 = relu(W11*a111 + B11);
%                 a333 = relu(W2*a222 + B2);
%                 a444 = relu(W22*a333 + B22);
%                 y33(:,j) = sigmoid(W3*a444 + B3);
%             end
%             figure(3), subplot(212)
%             scatter3(y33(1,:),y33(2,:),y33(3,:), ms, X(1,:), 'filled')
%             colormap jet(256)
%             drawnow
%         end
%         
        
        
        W66  = W66 + (mmt66);
        W6  = W6 + (mmt6);
        W55  = W55 + (mmt55);
        W5 = W5 + mmt5;
        W44  = W44 + (mmt44);
        W4  = W4 + (mmt4);
        W33  = W33 + (mmt33);
        W3  = W3 + (mmt3);
        W22  = W22 + (mmt22);
        W2  = W2 + (mmt2);
        W11  = W11 + (mmt11);
        W1  = W1 + (mmt1);
        
        B66 = B66 + mmtB66;
        B6 = B6 + mmtB6;
        B55 = B55 + mmtB55;
        B5 = B5 + mmtB5;
        B44 = B44 + mmtB44;
        B4 = B4 + mmtB4;
        B33 = B33 + mmtB33;
        B3 = B3 + mmtB3;
        B22 = B22 + mmtB22;
        B2 = B2 + mmtB2;
        B11 = B11 + mmtB11;
        B1 = B1 + mmtB1;
        ee = ee + mean(e(:).^2);
    end
    J(eee,1) = ee;
    fprintf('Epoch: %d \nCusto: %.20f\n', eee, J(eee,1));
    ee = 0;
end


