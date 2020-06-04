% Funcoes uteis para o detector Canny

fonte = imread('lena.jpg');
limiar_baixo = 0.05;
limiar_alto = 0.15;
fraco = 15;
forte = 255;
mascara = kernel_gaussiano(5, 1.25); 
fonte_suavizada = conv2d_isr(fonte, mascara);
[~, ~, grad_fonte_sobel, fase_fonte_sobel] = sobel_canny(fonte_suavizada);
non_max_fonte = non_max_sup(grad_fonte_sobel, fase_fonte_sobel);
fonte_limiarizada = limiar_aux_canny(non_max_fonte, fraco , forte, limiar_baixo, limiar_alto);
resultado = hysteresis(fonte_limiarizada, fraco, forte); 
imshow(uint8(resultado));


function  C  = conv2d_isr(A, B)

    A = double(A);
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
            C(i,j) = imagem_vet_zeros*kernel_vetorizado;
        end
    end
end



function [H] = kernel_gaussiano(tam,  sigma)
    tam = fix(tam/2); %divisao inteira
    [xx, yy] = meshgrid(-tam:tam, -tam:tam);
    H = exp(-(xx.^2 + yy.^2)/(2*sigma^2))*(1/(2*pi*sigma^2));
end

function [M_x, M_y, Grad, Fase] = sobel_canny(fonte)
    %E assumido que a fonte sera passada como double
    
    sobel_x = [-1 0 1; -2 0 2; -1 0 1];
    sobel_y = [-1 -2 -1; 0 0 0; 1 2 1];
    M_x = conv2d_isr(fonte, sobel_x);
    M_y = conv2d_isr(fonte, sobel_y);
    Grad = sqrt(M_x.^2 + M_y.^2);
    Fase = atan2d(M_y, M_x);
    
end

function [Z] = non_max_sup(fonte_pre, Fase)
    
    Z = zeros(size(fonte_pre));
    [linha, coluna] = size(fonte_pre);
    Fase(Fase < 0) = Fase(Fase < 0) + 180;
    
    for i = 2:linha - 1
        for j = 2:coluna - 1
            q = 255;
            r = 255;
 
            if or(0 <= Fase(i,j) < 22.5, 157.5 <= Fase(i,j) <= 180)
                q = fonte_pre(i, j+1);
                r = fonte_pre(i, j-1);
                else if (22.5 <= Fase(i,j) < 67.5)
                    q = fonte_pre(i+1, j-1);
                    r = fonte_pre(i-1, j+1); 
                    else if (67.5 <= Fase(i,j) < 112.5)
                        q = fonte_pre(i+1, j);
                        r = fonte_pre(i-1, j);
                        else if (112.5 <= Fase(i,j) < 157.5 )
                             q = fonte_pre(i-1, j-1);
                             r = fonte_pre(i+1, j+1);
                            end
                        end
                    end
            end
            if and(fonte_pre(i,j) >= q, fonte_pre(i,j) >= r)
                Z(i,j) = fonte_pre(i,j);
            end
        end
    end


end


function [resultado, fraco, forte] = limiar_aux_canny(fonte_pro, fraco, forte, limiar_baixo_taxa, limiar_alto_taxa) 
    limiar_alto = max(fonte_pro(:))*limiar_alto_taxa;
    limiar_baixo = limiar_alto*limiar_baixo_taxa;
    [x_forte, y_forte, ~] = find(fonte_pro >= limiar_alto);
    ind_forte = sub2ind(size(fonte_pro),x_forte,y_forte);
    [x_fraco, y_fraco, ~] = find(and(fonte_pro <= limiar_alto, fonte_pro>= limiar_baixo));
    ind_fraco = sub2ind(size(fonte_pro),x_fraco,y_fraco);
    resultado = zeros(size(fonte_pro));
    for ind = 1:length(ind_forte)
        resultado(ind_forte(ind)) = forte;
    end
    for ind = 1:length(ind_fraco)
        resultado(ind_fraco(ind)) = fraco;
    end
    
    
end

function [resultado] = hysteresis(img, fraco, forte)
    resultado = img;
    [M, N, ~] = size(resultado);
    for i = 2:M-1
        for j = 2:N-1
            if resultado(i,j) == fraco
                if ((resultado(i+1, j-1) == forte) || (resultado(i+1, j-0) == forte) ||...
                   (resultado(i+1, j+1) == forte) || (resultado(i+0, j-1) == forte) ||...
                   (resultado(i+0, j+1) == forte) || (resultado(i-1, j-1) == forte) ||...
                   (resultado(i-1, j-0) == forte) || (resultado(i-1, j+1) == forte))
                    resultado(i,j) = forte;
                else
                    resultado(i,j) = fraco;
                end
            end
        end
    end
    
    
end
