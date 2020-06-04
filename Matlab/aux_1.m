


%imA e imB imagens do tipot uint8
imB = getimage(handles.axes3); % e posso testar com isempty(imB)

imA = double(imA);
imB = double(imB);
imC = imA + imB;
imC = uint8(255*(imC - min(imC(:)))/(max(imC(:)) - min(imC(:))));





