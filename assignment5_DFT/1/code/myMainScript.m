%% MyMainScript

tic;
%% Your code here
% load the image
im = imread('../data/barbara256.png');
im1 = double(im) + randn(size(im))*20;
printImage(im, 'Original');
printImage(im1, 'Noisy');

% Parameters for PCA Denoising
patch_size = 7;
var = 400;

% Parameters for Bilateral Filtering
sigmaS = 20;
sigmaI = 10;

%Denoise Image using different methods
im2 = myPCADenoising1(im1, patch_size, var);
printImage(im2, 'Denoised PCA');
mse_PCA = RMSD(im2,im)^2

im3 = myPCADenoising2(im1, patch_size, var);
printImage(im3, 'Denoised PCA (K nearest)');
mse_PCA_Knn = RMSD(im3,im)^2

im4 = myBilateralFiltering(im1, sigmaS, sigmaI);
printImage(im4, 'Bilateral Filtered');
mse_Bilateral = RMSD(im4,im)^2

toc;