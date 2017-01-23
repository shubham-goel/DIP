%% MyMainScript

clear;
clc;
tic;

%% Your code here
att_faces = uigetdir();
% att_faces = '../../CroppedYale/';
dir_list = dir(att_faces);
X= zeros(192*168,38*40);
for i = 3:40
    oldfolder=cd(strcat(att_faces,'/',dir_list(i).name));
    innerlist = dir('./**');
    for j = 3:42
        X(:,(i-3)*40+j-2)=reshape(imread(innerlist(j).name),192*168,1);
    end
    cd(oldfolder);
end
K=[2, 10, 20, 50, 75, 100, 125, 150, 175];
myDisplayEigenFaces(X,K);

toc;
