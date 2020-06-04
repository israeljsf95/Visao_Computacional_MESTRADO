clear all, clc, close all;

X = load('digit_xtest.csv');
X = X(1:7000)./255;
X = X - repmat(mean(X,2), 1, size(X,2));
X = X ./ repmat(std(X')', 1, size(X,2));
X_ruido = X + 0.3*randn(size(X)); %adicao de ruido branco
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
W11 = 2*rand(512, size(W1,1)) - 1;
W11 = W11*sqrt(2/size(W11,1));
mmt11 = zeros(size(W11));

B1 = 2*rand(size(W1,1),1) - 1;
mmtB1 = zeros(size(B1));
B1 = B1*sqrt(2/size(B1,1));
B11 = 2*rand(size(W11,1),1) - 1;
mmtB11 = zeros(size(B11));
B11 = B11*sqrt(2/size(B11,1));


%AE2 parametros
W2 = 2*rand(128, size(W11,1)) - 1;
mmt2 = zeros(size(W2));
W2 = W2*sqrt(2/size(W2,1));
W22 = 2*rand(32, size(W2,1)) - 1;
W22 = W22*sqrt(2/size(W22,1));
mmt22 = zeros(size(W22));

B2 = 2*rand(size(W2,1),1) - 1;
mmtB2 = zeros(size(B2));
B2 = B2*sqrt(2/size(B2,1));
B22 = 2*rand(size(W22,1),1) - 1;
mmtB22 = zeros(size(B22));
B22 = B22*sqrt(2/size(B22,1));

%AE3 parametros

W3 = 2*rand(8, size(W22,1)) - 1;
mmt3 = zeros(size(W3));
W3 = W3*sqrt(2/size(W3,1));
W33 = 2*rand(2, size(W3,1)) - 1;
W33 = W33*sqrt(2/size(W33,1));
mmt33 = zeros(size(W33));

B3 = 2*rand(size(W3,1),1) - 1;
mmtB3 = zeros(size(B3));
B3 = B3*sqrt(2/size(B3,1));
B33 = 2*rand(size(W33,1),1) - 1;
mmtB33 = zeros(size(B33));
B33 = B33*sqrt(2/size(B33,1));


%AE4 parametros

W4 = 2*rand(8, size(W33,1)) - 1;
mmt4 = zeros(size(W4));
W4 = W4*sqrt(2/size(W4,1));
W44 = 2*rand(32, size(W4,1)) - 1;
W44 = W44*sqrt(2/size(W44,1));
mmt44 = zeros(size(W44));

B4 = 2*rand(size(W4,1),1) - 1;
mmtB4 = zeros(size(B4));
B4 = B3*sqrt(2/size(B4,1));
B44 = 2*rand(size(W44,1),1) - 1;
mmtB44 = zeros(size(B44));
B44 = B44*sqrt(2/size(B44,1));



%AE5 parametros

W5 = 2*rand(128, size(W44,1)) - 1;
mmt5 = zeros(size(W5));
W5 = W5*sqrt(2/size(W5,1));
W55 = 2*rand(512, size(W5,1)) - 1;
W55 = W55*sqrt(2/size(W55,1));
mmt55 = zeros(size(W55));

B5 = 2*rand(size(W5,1),1) - 1;
mmtB5 = zeros(size(B5));
B5 = B5*sqrt(2/size(B5,1));
B55 = 2*rand(size(W55,1),1) - 1;
mmtB55 = zeros(size(B55));
B55 = B55*sqrt(2/size(B55,1));


%AE6 parametros

W6 = 2*rand(1024, size(W55,1)) - 1;
mmt6 = zeros(size(W6));
W6 = W6*sqrt(2/size(W6,1));
W66 = 2*rand(784, size(W6,1)) - 1;
W66 = W66*sqrt(2/size(W66,1));
mmt66 = zeros(size(W66));

B6 = 2*rand(size(W6,1),1) - 1;
mmtB6 = zeros(size(B6));
B6 = B6*sqrt(2/size(B6,1));
B66 = 2*rand(size(W66,1),1) - 1;
mmtB66 = zeros(size(B66));
B66 = B66*sqrt(2/size(B66,1));


epoch = 65000;
alfa1 = 1e-5;
beta1 = 1e-4;
J = zeros(epoch, 1);
ee = 0;
% figure
%Primeira camada
% figure(2)
% figure(3)

%Configuração do objeto para gravar o video 
for eee = 1:epoch
    I = randperm(size(X,2));
    parfor i = 1:length(I)
        x = X_ruido(:,I(i));

        %passo forward sera dividido varios autoencoders para evitar
        %o problema do gradiente ir a zero

        %AE1
        a1  = relu(W1*x + B1);
        a11 = relu(W11*a1 + B11);
        a2  = relu(W2*a11 + B2);
        a22 = relu(W22*a2 + B22);
        a3  = relu(W3*a22 + B3);
        a33 = relu(W33*a3 + B33);
        a4  = relu(W4*a33 + B4);
        a44 = relu(W44*a4 + B44);
        a5  = relu(W5*a44 + B5);
        a55 = relu(W55*a5 + B55);
        a6  = relu(W6*a55 + B6);
       
        y1 = sigmoid(W66*a6 + B66);
        
        %backprop AE1
        a1_p  = a1 > 0;
        a11_p = a11 > 0;
        a2_p  = a2 > 0;
        a22_p = a22 > 0;
        a3_p  = a3 > 0;
        a33_p = a33 > 0;
        a4_p  = a4 > 0;
        a44_p = a44 > 0;
        a5_p  = a5 > 0;
        a55_p = a55 > 0;
        a6_p  = a6 > 0;
        
        y1_p  = y1.*(1 - y1);

        e = x - y1;
        delta_1 = e.*y1_p;
        
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
        dE6_dW66 = alfa1*delta_1*a6';
        dE6_dW6  = alfa1*delta_2*a55';
        dE5_dW55 = alfa1*delta_3*a5';
        dE5_dW5  = alfa1*delta_4*a44';
        dE4_dW44 = alfa1*delta_5*a4';
        dE4_dW4  = alfa1*delta_6*a33';
        dE3_dW33 = alfa1*delta_7*a3';
        dE3_dW3  = alfa1*delta_8*a22';
        dE2_dW22 = alfa1*delta_9*a2';
        dE2_dW2  = alfa1*delta_10*a11';
        dE1_dW11 = alfa1*delta_11*a1';
        dE1_dW1  = alfa1*delta_12*x';
        
        mmt66 = dE6_dW66 + beta1*mmt66;
        mmt6  = dE6_dW6 + beta1*mmt6;
        mmt55 = dE5_dW55 + beta1*mmt55;
        mmt5  = dE5_dW5 + beta1*mmt5;
        mmt44 = dE4_dW44 + beta1*mmt44;
        mmt4  = dE4_dW4 + beta1*mmt4;
        mmt33 = dE3_dW33 + beta1*mmt33;
        mmt3  = dE3_dW3 + beta1*mmt3;
        mmt22  = dE2_dW22 + beta1*mmt22;
        mmt2  = dE2_dW2 + beta1*mmt2;
        mmt11 = dE1_dW11 + beta1*mmt11;
        mmt1  = dE1_dW1 + beta1*mmt1;
        
        %atualizacao dos limiares
        dE6_dB66 = alfa1*delta_1;
        dE6_dB6  = alfa1*delta_2;
        dE5_dB55 = alfa1*delta_3;
        dE5_dB5  = alfa1*delta_4;
        dE4_dB44 = alfa1*delta_5;
        dE4_dB4  = alfa1*delta_6;
        dE3_dB33 = alfa1*delta_7;
        dE3_dB3  = alfa1*delta_8;
        dE2_dB22 = alfa1*delta_9;
        dE2_dB2  = alfa1*delta_10;
        dE1_dB11 = alfa1*delta_11;
        dE1_dB1  = alfa1*delta_12; 
        
        
        mmtB66 = dE6_dB66 + beta1*mmtB66;
        mmtB6  = dE6_dB6 + beta1*mmtB6;
        mmtB55 = dE5_dB55 + beta1*mmtB55;
        mmtB5  = dE5_dB5 + beta1*mmtB5;
        mmtB44 = dE4_dB44 + beta1*mmtB44;
        mmtB4  = dE4_dB4 + beta1*mmtB4;
        mmtB33 = dE3_dB33 + beta1*mmtB33;
        mmtB3  = dE3_dB3 + beta1*mmtB3;
        mmtB22 = dE2_dB22 + beta1*mmtB22;
        mmtB2  = dE2_dB2 + beta1*mmtB2;
        mmtB11 = dE1_dB11 + beta1*mmtB11;
        mmtB1  = dE1_dB1 + beta1*mmtB1;
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
        ee = ee + mean(e.^2);

    end
    
    J(eee,1) = ee/size(X,2);
    fprintf('Custo: %.6f\n', J(eee,1));
    ee = 0;
end


