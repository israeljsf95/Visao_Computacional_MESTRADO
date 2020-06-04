clear all



sobel_x = [-1 0 1; -2 0 2; -1 0 1];
sobel_y = [-1 -2 -1; 0 0 0; 1 2 1];
    
im = imread('Lena.jpg');
if size(im,3) == 3
        im = (0.2989*im(:,:,1) + 0.5870*im(:,:,2) + 0.1140*im(:,:,3));
end
[U, S, V] = svd(sobel_x);
aux_1 = zeros(size(im));
aux_2 = zeros(size(im));

for j = 1:size(im,2)
    aux_1(:,j) = conv(im(:,j), U(:,1), 'same');
end
for j = 1:size(im,1)
    aux_2(j,:) = S(1)*conv(aux_1(j,:), V(:,1)', 'same');
end

M_x = aux_2;


[U, S, V] = svd(sobel_y);
aux_1 = zeros(size(im));
aux_2 = zeros(size(im));

for j = 1:size(im,2)
    aux_1(:,j) = conv(im(:,j), U(:,1), 'same');
end
for j = 1:size(im,1)
    aux_2(j,:) = S(1)*conv(aux_1(j,:), V(:,1)', 'same');
end


M_y = aux_2;


Grad_mod = sqrt(M_x.^2 + M_y.^2);

M_x = M_x - min(M_x(:));
M_x = 255*(M_x/max(M_x(:)));
M_y = M_y - min(M_y(:));
M_y = 255*(M_y/max(M_y(:)));

Grad_mod = Grad_mod - min(Grad_mod(:));
Grad_mod = 255*(Grad_mod/max(Grad_mod(:)));
subplot(131)
imshow(uint8(Grad_mod)), axis equal;
subplot(132)
imshow(uint8(M_x)), axis equal;
subplot(133)
imshow(uint8(M_y)), axis equal;
