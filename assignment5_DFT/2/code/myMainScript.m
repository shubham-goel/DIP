%% MyMainScript

tic;
%% Your code here
im = load('../data/image_low_frequency_noise.mat')
im = im.Z;

u0=[108,148]
v0=[117,140]
threshold=75.5
myNotchFilter(im, u0, v0,threshold);
toc;
