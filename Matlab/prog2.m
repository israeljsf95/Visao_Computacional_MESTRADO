clc;
clear;
close all;
x=imread('2.jpeg');
figure(1)
subplot(2,1,1)
image(x);
axis equal 
[m1,m2,m3]=size(x);

P1 = [ 0 1
      -1 0];

P2 = [0 -1
      1  0];

th = 30;
A = [cosd(th)   -sind(th); sind(th) cosd(th)];

[xmax, ymax,q1,q2] = frame_adjust(m1,m2,A,P1,P2);


y = zeros(xmax,ymax,3)+255;

for i=1:m1
    for j=1:m2
        v = ceil(P2*A*P1*[i,j]'+[q1,q2]');
        if(v(1)==0); v(1)=1; end
        if(v(2)==0); v(2)=1; end
        y(v(1),v(2),:)=x(i,j,:);
    end
end
subplot(2,1,2)
image(uint8(y));
axis equal




function [xmax,ymax,q1,q2] = frame_adjust(m1,m2,A,P1,P2)

 
w1 = [m1  m1  0
     0   m2 m2];
 
w2 = P2*A*P1*w1;

ind1 = find(w2(1,:)<0);
ind2 = find(w2(2,:)<0);

xmax = ceil(max(w2(1,:)));
ymax = ceil(max(w2(2,:)));

q1 = 0;
q2 = 0;

if length(ind1)>0
     q1 = -min(w2(1,find(w2(1,:)<0)));
     xmax = ceil(max(w2(1,:)+q1));
end

if length(ind2)>0
    q2 = -min(w2(2,find(w2(2,:)<0)));
    ymax = ceil(max(w2(2,:)+q2));
end


end