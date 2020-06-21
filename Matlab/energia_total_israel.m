function energia = energia_total_israel(fonte, clus, mus, vars, i, j, label, beta)

    energia = prob_logaritmica(fonte, mus, vars, i, j, label) + ...
              energia_gibbs(clus, i, j, label, beta);
end


function p_lol = prob_logaritmica(img,mu,vars,i,j,label)
% img e a imagem em nivel de cinza
p_lol = log((2.0*pi*vars(label)^0.5)) + ...
    (img(i,j)-mu(label))^2/(2.0*vars(label));
end

function energia = energia_gibbs(img,i,j,label,beta)
% img e a imagem com os agrupamentos
energia = 0;
%Norte, sul, Leste, Oeste
if (label == img(i-1,j)) 
    energia = energia-beta;
else
    energia = energia+beta;
end
if (label == img(i,j+1)) 
    energia = energia-beta;
else
    energia = energia+beta;
end
if (label == img(i+1,j)) 
    energia = energia-beta;
else
    energia = energia+beta;
end
if (label == img(i,j-1)) 
    energia = energia-beta;
else
    energia = energia+beta;
end
%Diagonais
if (label == img(i-1,j-1)) 
    energia = energia-beta;
else
    energia = energia+beta;
end
if (label == img(i-1,j+1)) 
    energia = energia-beta;
else
    energia = energia+beta;
end
if (label == img(i+1,j+1)) 
    energia = energia-beta;
else
    energia = energia+beta;
end
if (label == img(i+1,j-1)) 
    energia = energia-beta;
else
    energia = energia+beta;
end

end