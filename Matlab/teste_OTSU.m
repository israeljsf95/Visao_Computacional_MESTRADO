clc

fonte = imread('casa.jpg');
fonte = double(fonte);
% fonte = (fonte(:,:,1) + fonte(:,:,2) + fonte(:,:,3))/3;
[~, p_r, ~] = hist_imagem_isr(fonte);
K = [0:255];

disp('Medindo tempo para OTSU MATLAB');
tic;
T1 = round(255*graythresh(fonte/255));
toc;


disp('Medindo tempo para OTSU FOR');
tic;
T2 = limiar_otsu_isr(p_r, K);
toc;


disp('Medindo tempo para OTSU SEM FOR');
tic;
% [~, p_r, ~] = hist_imagem_isr(fonte);
T3 = limiar_otsu_isr2(p_r, K);
toc;


function [T] = limiar_otsu_isr2(im_hist, K)

    p_i = im_hist;
    P1_k = cumsum(p_i);
%     P2_k = 1 - P1_k;
    M_k = cumsum(K'.*p_i + eps);
    mg = K*p_i;
    sig_b_2 = ((mg*P1_k - M_k).^2)./((P1_k.*(1 - P1_k)) + eps);
    [~, I] = max(sig_b_2);
    T = K(I(1)+1);
end


function [T] = limiar_otsu_isr(im_hist, K)
    total = sum(im_hist); % total number of pixels in the image 
    %% OTSU automatic thresholding
    L = 256;
    soma_fundo = 0;
    fundo = 0;
    maximum = 0.0;
    media_total = K*im_hist;
    for ii = 1:L
        nao_fundo = total - fundo;
        if and(fundo > 0, nao_fundo > 0)
            media_nao_fundo = (media_total - soma_fundo) / nao_fundo;
            val = fundo*nao_fundo*((soma_fundo/fundo) - media_nao_fundo)^2;
            if ( val >= maximum )
                T = ii;
                maximum = val;
            end
        end
        fundo = fundo + im_hist(ii);
        soma_fundo = soma_fundo + (ii-1) * im_hist(ii);
    end
end



