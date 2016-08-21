%% MyMainScript

tic;
%% Your code here

tic;
clc;
clear;

a = dir('../data/');
% for fname = 3:5
%     im = imread(strcat('../data/', a(fname).name));
% 	printImage(im)
% 	printImage(myLinearContrastStretching(im));
% end
% 
% for fname = 3:5
%     im = imread(strcat('../data/', a(fname).name));
% 	printImage(im)
% 	printImage(myHE(im));
% end

small_box = [120 120 200]; 

for fname = 5:5
    im = imread(strcat('../data/', a(fname).name));
	printImage(im)
	printImage(myAHE(im, small_box(fname-2), small_box(fname-2)));
end

% small_box = [100 100 180];    
% threshold = [0.05 0.05 0.001];
% 
% for fname = 3:5
%     im = imread(strcat('../data/', a(fname).name));
% 	printImage(im)
% 	printImage(myCLAHE(im, small_box(fname-2), small_box(fname-2), threshold(fname-2)));
% end

toc


