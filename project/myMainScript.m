clear;
clc;
%% my main scipt for vector image regularization wih pdes
tic
img=imread('images/peppers.png');
img=255*im2double(img);
[m, n, k] = size(img);
imshow((mat2gray(img)));
waitforbuttonpress;
% Add noise to image
variance = 0.05*(max(img(:)) - min(img(:)));
G = (variance)*(randn(m, n, k));
size(img)
noisyim = img + G;
imwrite(mat2gray(noisyim),'output/peppers_noisy.png')
imshow((mat2gray(noisyim)));
figure()
new_img=pde_regularize(img,noisyim,5,0.5,3.5,11,1);
imwrite(mat2gray(new_img),'output/peppers_regularized.png')
imshow((mat2gray(new_img)));

toc

%% magnification
% tic
% 
% img = imread('images/lena64.png');
% img=255*im2double(img);
% 
% mag_img = imresize(img,4,'nearest');
% mag_img=255*im2double(mag_img);
% imshow(mat2gray(mag_img));
% waitforbuttonpress;
% figure()
% new_img=pde_regularize(mag_img,mag_img,7,20,20,100,0);
% 
% toc

%% Improvement of Lossy Compressed Images
tic
img = imread('images/lenna_compressed.jpg');
img=255*im2double(img);

printImage(img);
waitforbuttonpress;
figure()
new_img=pde_regularize(img,img,7,4,1.75,10,0);
imwrite(mat2gray(new_img),'output/lenna_compressed_regularized.jpg');
toc


%% inpainting
tic

img = imread( 'images/parrot.ppm' );
mask = imread( 'images/parrot_mask.pgm' );

img=255*im2double(img);
[m, n, k] = size(img);
imshow((mat2gray(img)));
waitforbuttonpress;
figure()

new_img = pde_inpaint(img, mask, 5, 0.5, 500, 50);

toc


