%% MyMainScript

tic;
%% Your code here
im = imread('../data/barbara256.png');

% figure;
% imagesc(im);
% colormap gray;
% colorbar;

[m,n]=size(im);
im2=padarray(im,[m/2,n/2]);
F = fftshift(fft2(im2));
%display the imge in freq domain
figure;
imagesc(log(abs(F)+1));
daspect([1 1 1]);
title 'Image in freq. domain'
colorbar;

D=[40 80]
for i=1:2
    myIdealLowPassFilter(im,D(i));
end
sigma=[40 80]
for i=1:2
    myGaussianLowPassFilter(im,sigma(i));
end
pause
toc;
