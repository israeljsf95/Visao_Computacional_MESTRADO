function [B] = wavelet_haar_hor(A)
    A = A';
    B = [A(1:2:size(A,1),:)+ A(2:2:size(A,1),:); A(1:2:size(A,1),:) - A(2:2:size(A,1),:)]/sqrt(2);
    B = B';
end

