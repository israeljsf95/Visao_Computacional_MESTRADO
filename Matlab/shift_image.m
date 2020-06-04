% Shifts / translates an image to the right by 500 pixels and down by 200 pixels.
% Area shifted in is black.
clc;    % Clear the command window.
close all;  % Close all figures (except those of imtool.)
clear;  % Erase all existing variables. Or clearvars if you want.
workspace;  % Make sure the workspace panel is showing.
format long g;
format compact;
fontSize = 20;

grayImage = imread('concordorthophoto.png');
[rows, columns, numberOfColorChannels] = size(grayImage);
subplot(1, 2, 1);
imshow(grayImage);
axis on;
title('Original Image', 'fontSize', fontSize);
% Enlarge figure to full screen.
set(gcf, 'Units', 'Normalized', 'OuterPosition', [0 0 1 1]);

deltaX = 500; % Shift x by 500 pixels.
deltaY = 200; % Shift y by 200 pixels.
D = zeros(rows, columns, 2);
D(:,:,1) = -deltaX; % Shift x by 500 pixels.
D(:,:,2) = -deltaY; % Shift x by 200 pixels.
warpedImage = imwarp(grayImage, D);
subplot(1, 2, 2);
imshow(warpedImage);
axis on;
title('Shifted Image', 'fontSize', fontSize);