function mult_img = gray2multilevel(fonte, limiares)
%Funcao que sera usada para criar uma limiarizacao inicial a ser usada 
%no sistema de segmentaca

mult_img = zeros(size(img));
mult_img(fonte < limiares(1)) = 1;
n_limiar = length(limiares);
if (n_limiar > 1)
    for i = 1:n_limiar - 1
        mult_img(font >= limiar(1) & fontee <limiar(i+1)) = i + 1;
    end
    mult_img(fonte >= limiar(n_limiar)) = i + 2;
else
    mult_img(fonte >= limiar(1)) = 2;
end