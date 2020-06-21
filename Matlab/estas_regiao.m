function [mu, std] = estas_regiao(fonte, img_reg, n_classes)
    
%Esta funcao calcula as estatisticas de cada regiao da imagem associadas ao
%aos labels iniciais

    mu = zeros(size(n_classes, 1));
    std = mu;
    for i = 1:n_classes
            H = fonte(img_reg == i);
            if ~isempty(H)
                mu(i) = mean(H);
                std(i) = std(H);
            else
                mu(i) = 0;
                std(i) = 0;
            end
    end
            
end