function x = amostrando_discre_dist(P, n)
    F = cumsum(P);
    x = zeros(n,1);
    for i = 1:n 
        U = rand();
        for k = 1:length(P)
            if U <= F(k)
                x(i) = k;
                break;
            end
        end
    end
    
end