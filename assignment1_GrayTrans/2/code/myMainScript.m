%% MyMainScript

tic;
%% Your code here

clc;
clear;
% im = imread('../data/TEM.png');
% imshow(im);
% colormap(jet(200));
% axis tight;
% colorbar;
% waitforbuttonpress; 
% newim = im;
% size(newim,3)
% for i = 1:size(newim,3)
%    im1 = im2double(im(:,:,i));
%    im1 = myLinearContrastStretching(im1);
%    newim(:,:,i) = im1;
% end
% imshow(newim);
% colormap(jet(200));
% axis tight;
% colorbar
% waitforbuttonpress; 


% im = imread('../data/TEM.png');
% imshow(im);
% colormap(jet(200));
% axis tight;
% colorbar;
% waitforbuttonpress; 
% newim = myHE(im);
% imshow(mat2gray(newim));
% colormap(jet(200));
% axis tight;
% colorbar
% waitforbuttonpress;


im = imread('../data/TEM.png');
imshow(im);
% colormap(jet(200));
axis tight;
colorbar;
waitforbuttonpress; 

small_box = 51;

tic;
% newim = myAHE(im, small_box, small_box);
newim = myCLAHE(im, small_box, small_box, 0.1);
toc

imshow(mat2gray(newim));
colormap(gray(200));
axis tight;
colorbar
waitforbuttonpress;

