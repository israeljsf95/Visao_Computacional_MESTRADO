%reading and converting the image
clear all, clc;
inImage=imread('Lena.jpg');
inImage=rgb2gray(inImage);
inImageD=double(inImage);
subplot(211)
imagesc(inImage), colormap(gray);
% decomposing the image using singular value decomposition
[U,S,V]=svds(inImageD, size(inImage,1),'smallestnz');

% Using different number of singular values (diagonal of S) to compress and
% reconstruct the image
dispEr = zeros(size(U,1),1);
numSVals = zeros(size(U,1),1);
subplot(212)
for N = 1:ceil(size(U,1)/2)
    % store the singular values in a temporary var
    C = S;

    % discard the diagonal values not required for compression
    C(N+1:size(S,1):end)=0;

    % Construct an Image using the selected singular values
    D=U*C*V';

    error=sum(sum((inImageD-D).^2))/(size(D,1)*size(D,2));

    % store vals for display
    dispEr(N) = error;
    numSVals(N) = N;
    imagesc(D), colormap(gray), drawnow, pause(0.1), axis off; 
end

% dislay the error graph
figure; 
title('Erro na Compressao');
plot(numSVals, dispEr);
grid on
xlabel('Valores Singulares');
ylabel('EQM - Original e Reconstrucao');
