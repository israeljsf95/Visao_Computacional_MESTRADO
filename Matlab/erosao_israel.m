function [Eroded] = erosao_israel(fonte, estruc_el)

    % store number of rows in P and number of columns in Q.             
[P, Q]=size(estruc_el);  
  
% create a zero matrix of size I.         
Eroded = zeros(size(I, 1), size(I, 2));  
  
for i = ceil(P/2):size(I, 1)-floor(P/2) 
    for j = ceil(Q/2):size(I, 2)-floor(Q/2) 
  
        % take all the neighbourhoods. 
        on = I(i-floor(P/2):i+floor(P/2), j-floor(Q/2):j+floor(Q/2));  
  
        % take logical se 
        nh = on(logical(se));  
        
        % compare and take minimum value of the neighbor  
        % and set the pixel value to that minimum value.  
        Eroded(i, j) = min(nh(:));       
    end
end
  
end