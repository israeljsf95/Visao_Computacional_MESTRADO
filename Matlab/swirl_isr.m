function [imaux] = swirl_isr(Im, alpha)
    [xx, yy] = meshgrid(1:size(Im,1), 1:size(Im,2));
    xx = xx(:);
    yy = yy(:);
    xc = floor(size(Im,1)/2);
    yc = floor(size(Im,2)/2);
    dx = xx - xc;
    dy = yy - yc;
    r = sqrt(dx.^2 + dy.^2);
    theta = atan2(dy, dx) + alpha*((max(r) - r)/max(r));
    X = zeros(size(xx));
    Y = zeros(size(yy));
    X(r <= max(r)) = xc + r(r <= max(r)).*cos(theta);
    X(r > max(r)) = xx(r > max(r));

    Y(r <= max(r)) = yc + r(r <= max(r)).*sin(theta);
    Y(r > max(r)) = yy(r > max(r));
    imaux = zeros(size(Im));

    X = X - min(X);
    X = X/max(X);
    X = floor(size(Im,1)*X) + 1;

    Y = Y - min(Y);
    Y = Y/max(Y);
    Y = floor(size(Im,1)*Y) + 1;
    for i = 1:length(xx)
        imaux(X(i), Y(i)) = Im(xx(i), yy(i));
    end
    
    imaux = uint8(imaux);
end