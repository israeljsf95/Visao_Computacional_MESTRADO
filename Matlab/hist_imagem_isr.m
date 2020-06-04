function [h, p_r, bins] = hist_imagem_isr(A)
    %esta função supõe que a imagem A está já está em nível de cinza
    % B = rgb2gray(A);
    B = A;
    L = 256;
    h = zeros(1,L);
    bins = 0:L-1;
    %Processameneto do histograma para a imagem B
    B = B(:);
    for k = 0:L-1
        h(k+1) = sum(B==k);
    end
    p_r = h/numel(B);%Normalizando
    p_r = p_r/sum(p_r);
    %garantindo que o retorno sejam vetores colunas
    p_r = p_r(:);
    bins = bins(:);
    h = h(:);
end