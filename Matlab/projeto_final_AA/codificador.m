


function [code] = codificador(X, W1, W11, W2, W22, W3, W33, B1, B11, B2, B22, B3, B33)
    a1  = reshape(relu(W1*X + B1), size(W1,1), size(B1,2));
    a11 = reshape(relu(W11*a1 + B11), size(W11,1), size(B11,2));
    a2  = reshape(relu(W2*a11 + B2),  size(W2,1), size(B2,2));
    a22 = reshape(relu(W22*a2 + B22), size(W22,1), size(B22,2));
    a3  = reshape(relu(W3*a22 + B3),  size(W3,1), size(B3,2));
    code = reshape(relu(W33*a3 + B33), size(W33,1), size(B33,2));
end

