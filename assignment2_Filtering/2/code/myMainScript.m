%% MyMainScript

tic;
%% Your code here
im = load('../data/barbara.mat');
im = im.imageOrig;
[m, n] = size(im);
printImage(im);

variance = 0.05*(max(im(:)) - min(im(:)));
G = sqrt(variance).*randn(m, n);
noisyim = im + G;
printImage(noisyim);

sigmaS = 10;
sigmaI = 5;
printImage(mat2gray(myBilateralFiltering(noisyim, sigmaS, sigmaI)));

toc;
