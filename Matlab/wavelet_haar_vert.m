function [B] = wavelet_haar_vert(A)
    B = [A(1:2:size(A,1),:)+ A(2:2:size(A,1),:); A(1:2:size(A,1),:) - A(2:2:size(A,1),:)]/sqrt(2);
end