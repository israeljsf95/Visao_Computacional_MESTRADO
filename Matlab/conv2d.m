function  C  = conv2d(A, B)

%rotina que calcula a convolução 2d resultando no shape original da imagem

%matriz que recebera a operação
C = zeros(size(A));

% vetorização e para e inversão dos eixos da mascara para a operação de con
%volucao
kernel_vetorizado = reshape(flip(flip(B,1),2)' ,[] , 1);

% preenchendo com zeros a matriz para operação da convolução e fazendo a
% operação em cima da matriz orignal uma 
Imagem_zeros = padarray(A, [floor(size(B,1)/2) floor(size(B,2)/2)]);


for i = 1:size(A,1)
    for j = 1:size(A,2)
        imagem_vet_zeros = reshape(Imagem_zeros(i: i + size(B,1) - 1, j:j + size(B,2) - 1)',1,[]);
        C(i,j) = imagem_vet_zeros*ima;
    end
end

end  