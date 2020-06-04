%% tranz deu errado na interpolação esse codigo agora vai ser com 
%% o processo de mapeamento inverso

clear
clc

s = imread('exp.bmp');
s(:,1:6) =[];
s(1:3,:) = [];
s = double(s);

s1 = 3;
s2 = 3;
m = [s1,0;0,s2];
mi = inv(m);

[lin,col] = size(s);
nlin = ceil(lin*s1);
ncol = ceil(col*s2);
count = 0 ;
ns = zeros(nlin,ncol);

% % for k1 = 1:nlin
% %     for k2 = 1:ncol
% %         kn = mi*[k1;k2];
% %         xi = floor(kn(2,1));
% %         yi = floor(kn(1,1));
% %         if(xi>0&&xi<col-3&&yi>0&&yi<lin-3)
% %         M4 = s(yi:yi+3,xi:xi+3);
% %         ns(k1,k2) = ibicubica(M4,kn(1,1)-yi,kn(2,1)-xi);
% %         end
% %         
% %     end
% % end

% % for k1 = 1:nlin
% %     for k2 = 1:ncol
% %         kn = mi*[k1;k2];
% %         xi = ceil(kn(2,1));
% %         yi = ceil(kn(1,1));
% %         if(xi>1&&xi<col-2&&yi>1&&yi<lin-2)
% %         M4 = s(yi-1:yi+2,xi-1:xi+2);
% %         ns(k1,k2) = ibicubica(M4,kn(1,1)-yi+1,kn(2,1)-xi+1);
% %         end
% %         
% %     end
% % end

for k1 = 1:nlin
    for k2 = 1:ncol
        kn = mi*[k1;k2];
        xi = floor(kn(2,1));
        yi = floor(kn(1,1));
        if(xi>1&&xi<col-2&&yi>1&&yi<lin-2)
        M4 = s(yi-1:yi+2,xi-1:xi+2);
        ns(k1,k2) = ibicubica(M4,kn(1,1)-yi+1,kn(2,1)-xi+1);
        end
        
    end
end

imshow(uint8(ns))
hold on 
imshow(uint8(s))
