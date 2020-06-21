
% read image 

I=imread('lua.tif');    
  
% convert to binary   
I=im2bw(I);  
  
% create structuring element               
se = [0 1 0; 1 0 1; 0 1 0];

A = erosao_israel(I, se);
  
 