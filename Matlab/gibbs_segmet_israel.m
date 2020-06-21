function clust = gibbs_segmet_israel(fonte, label, beta, n_regioes, iter)
%

fonte = padarray(fonte, [1 1], 'replicate', 'both');
label = padarray(label, [1 1], 'replciate', 'both');
[linha, coluna] = size(fonte);

%Parâmetros da Têmpera Simulada
T = 4; C = 0.97; k = 0;

[mus, sigs] = estas_regiao(fonte(2:end-1, 2:end-1), ...
                           label(2:end-1, 2:end-1), n_regioes);
vars = (sigs + .01).^2; %para evitar erro numerico
for i = 1:k
    %Amostrando um numero da distribuicao uniforme na faixa
    %da linha e da coluna
    U = random('Uniform', 0, 1, linha, coluna);
    for i = 2:linha-1
        for j = 2:coluna - 1
            %Calculo Da Energia para cara regiao do Sistema (nossa Imagem)
            ss = label(i,j);
            soma_energia = 0;
            e = zeros(n_regioes, 1);
            for s = 1:n_regioes
                e(s) = exp(-energia_total_israel(fonte, label, mus, vars,...
                       i, j, s, beta))/T;
                soma_energia = soma_energia + e(s);
            end
            %Iniciando de amostragem da Distribuicao de Energia de Gibbs
            F = 0;
            for s = 1:n_regioes
                F = F + e(s)/soma_energia;
                if F >= U(i,j)
                    label(i,j) = s;
                    break;
                end
            end
        end
    end
    T = T*C;
    [mus, sigs] = estas_regiao(fonte(2:end-1, 2:end-1), ...
                           label(2:end-1, 2:end-1), n_regioes);
    vars = (sigs + .01).^2; %para evitar erro numerico
 
end
   clust = label;                    
end