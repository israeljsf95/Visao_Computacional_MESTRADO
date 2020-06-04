function  C  = conv2d(A, B)

%rotina que calcula a convolu��o 2d resultando no shape original da imagem

%matriz que recebera a opera��o
C = zeros(size(A));

% vetoriza��o e para e invers�o dos eixos da mascara para a opera��o de con
%volucao
kernel_vetorizado = reshape(flip(flip(B,1),2)' ,[] , 1);

% preenchendo com zeros a matriz para opera��o da convolu��o e fazendo a
% opera��o em cima da matriz orignal uma 
Imagem_zeros = padarray(A, [floor(size(B,1)/2) floor(size(B,2)/2)]);


for i = 1:size(A,1)
    for j = 1:size(A,2)
        imagem_vet_zeros = reshape(Imagem_zeros(i: i + size(B,1) - 1, j:j + size(B,2) - 1)',1,[]);
        C(i,j) = imagem_vet_zeros*ima;
    end
end

end  