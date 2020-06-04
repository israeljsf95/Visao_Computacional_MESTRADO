function f = ibicubica( V,x,y )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

passos = [0,1,2,3]'; %% passo inteiro dado para cada deslocamento em V
%% V é dada por uma superficie aproximada de 16 coeficientes
%% com graus graus de liberdade em cada direção x e y 
By = [passos.^0 passos.^1 passos.^2 passos.^3];%% matriz com todos os graus de y
%% a transposta é Bx que da todos os graus do deslocamento em x
L = inv(By);
A = L*V*L';
f = [y^0 y^1 y^2 y^3]*A*[x^0 x^1 x^2 x^3]';

end

