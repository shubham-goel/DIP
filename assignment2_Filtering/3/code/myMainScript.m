%% MyMainScript

tic;
%% Your code here

% Load Image
im = load('../data/barbara.mat');
im = im.imageOrig;

% Downsample Image because it takes too long to run
im = myDownsample(im);
[m, n] = size(im);

% Add noise to image
variance = 0.05*(max(im(:)) - min(im(:)));
G = (variance).*randn(m, n);
noisyim = im + G;

% Parameters for filtering image
patchSize = 9;      % Patch Size
windowSize = 25;    % Window Size
stdDev = 0.25;      % h
newIM = myPatchBasedFiltering(noisyim, patchSize, windowSize, stdDev);

% Calculate RSMD of filtered image
fprintf('RSMD = %f\n',RMSD(im,newIM));

% Plot all 3 Images side by side
subplot(1,3,1), imagesc(im);
daspect ([1 1 1]);
colormap(gray(200));
colorbar;
subplot(1,3,2), imagesc(noisyim);
daspect ([1 1 1]);
colormap(gray(200));
colorbar;
subplot(1,3,3), imagesc(newIM);
daspect ([1 1 1]);
colormap(gray(200));
colorbar;

waitforbuttonpress;
toc;
