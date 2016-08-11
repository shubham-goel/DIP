%% MyMainScript

tic;
%% Your code here
im = imread('../data/circles_concentric.png');
imshow(im);
colormap(jet(200));
axis tight;
colorbar;
waitforbuttonpress; 

imshow(myShrinkImageByFactorD(im, 2));
colormap(jet(200));
axis tight;
colorbar
waitforbuttonpress; 

imshow(myShrinkImageByFactorD(im, 3));
colormap(jet(200));
axis tight;
colorbar
waitforbuttonpress; 

im = imread('../data/barbaraSmall.png');
imshow(im);
colormap(jet(200));
axis tight;
colorbar;
waitforbuttonpress; 

imshow(mat2gray(myBilinearInterpolation(im)));
colormap(jet(200));
axis tight;
colorbar;
waitforbuttonpress; 

imshow(mat2gray(myNearestNeighborInterpolation(im)));
colormap(jet(200));
axis tight;
colorbar;
waitforbuttonpress; 

toc;
