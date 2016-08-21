%% MyMainScript

tic;
%% Your code here
im = imread('../data/circles_concentric.png');
printImage(im);

printImage(myShrinkImageByFactorD(im, 2));

printImage(myShrinkImageByFactorD(im, 3));

im = imread('../data/barbaraSmall.png');
printImage(im);

printImage(myBilinearInterpolation(im));

printImage(myNearestNeighborInterpolation(im));

toc;
