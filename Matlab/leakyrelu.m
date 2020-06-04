function y = leakyrelu(x)
    y = max(0,x);
    y(y < 0) = 0.001.*y(y < 0);
    y = y(:);
end