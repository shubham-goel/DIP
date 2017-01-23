%% MyMainScript

tic;
%% Your code here
im = load('../data/barbara.mat');
im = im.imageOrig;
[m, n] = size(im);
figure
printImage(im);

variance = 0.05*(max(im(:)) - min(im(:)));
G = sqrt(variance).*randn(m, n);
noisyim = im + G;
figure
printImage(noisyim);

sigmaS = 10;
sigmaI = 5;
figure
printImage(mat2gray(myBilateralFiltering(noisyim, sigmaS, sigmaI)));

toc;
