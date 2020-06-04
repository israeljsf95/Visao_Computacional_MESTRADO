function [decode] = decodificador(X, W4, W44, W5, W55, W6, W66, B4, B44, B5, B55, B6, B66)
    a4  = reshape(relu(W4*X + B4),  size(W4,1), size(B4,2));
    a44 = reshape(relu(W44*a4 + B44), size(W44,1), size(B44,2));
    a5  = reshape(relu(W5*a44 + B5),  size(W5,1), size(B5,2));
    a55 = reshape(relu(W55*a5 + B55), size(W55,1), size(B55,2));
    a6  = reshape(relu(W6*a55 + B6),  size(W6,1), size(B66,2));
    decode = sigmoid(W66*a6 + B66);
end