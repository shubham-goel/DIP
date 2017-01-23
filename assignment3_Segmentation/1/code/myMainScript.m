%% MyMainScript
clear();
tic;
%% Harris Corner Detection
%lad the image
img = load('../data/boat.mat');
img=img.imageOrig;

%sigma for smoothing
sigmaS=1.5
%sigma for gaussian weights in window
sigmaW=0.5
%value of k for cornerness measure
k=0.05
%threshold for cornerness measure
harris_threshold=400;
%function call
[cornernessMeasure,eigenValue]=myHarrisCornerDetector(img,sigmaS,sigmaW,k,harris_threshold);
cornernessMeasure=imadjust(cornernessMeasure,stretchlim(cornernessMeasure),[0,1]);

%display original image
figure
colormap gray
imagesc(img);
daspect ([1 1 1])
colorbar

%display cornerness measure
figure
colormap gray
imagesc(cornernessMeasure);
title('Cornerness measure');
daspect ([1 1 1])
colorbar

%display the eigen values
figure
colormap gray
subplot(1,2,1), imagesc(eigenValue(:,:,1))
title('Eigen value along x');
daspect ([1 1 1])
colorbar

subplot(1,2,2), imagesc(eigenValue(:,:,2))
title('Eigen value along y');
daspect ([1 1 1])
colorbar
toc;
