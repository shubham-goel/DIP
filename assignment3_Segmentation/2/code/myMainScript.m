%% MyMainScript
clear();
tic;
%% Mean Shift Segmentation

% Load the image
img = imread('../data/baboonColor.png');
img = myDownsample(img);

% Contrast stretch the original image
img=imadjust(img,stretchlim(img),[0,1]);
img=im2double(img);

% Parameters
hr = 0.14
hs = 20
neighbours = 1600
numIter = 10

% Segment the Image
segmented_img = myMeanShiftSegmentation(img,hr,hs,neighbours,numIter);

% Display the original and segmented image
figure
subplot(1,2,1), imagesc(img)
daspect ([1 1 1])
colorbar
subplot(1,2,2), imagesc(segmented_img)
daspect ([1 1 1])
colorbar
waitforbuttonpress;

toc;
