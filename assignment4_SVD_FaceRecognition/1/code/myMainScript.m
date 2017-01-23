%% MyMainScript

clear;
clc;
tic;

%% ORL database

% Get ORL directory
att_faces = uigetdir();
% att_faces = '../../att_faces/'; % Used for debugging
dir_list = dir(att_faces);
% Train images, X and Test images, T
X= zeros(92*112,32*6);
T= zeros(92*112,32*4);
% Work through the dir and populate X and T
for i = 4:35
    oldfolder=cd(strcat(att_faces,'/',dir_list(i).name));
    innerlist = dir('./**');
    for j = 3:8
        X(:,(i-4)*6+j-2)=reshape(imread(innerlist(j).name),92*112,1);
    end
    for j = 9:12
        T(:,(i-4)*4+j-8)=reshape(imread(innerlist(j).name),92*112,1);
    end
    cd(oldfolder);
end
% List of values of K to use
K=[1,2,3,5,10,15,20,30,50,75,100,150,170];
% Recognition rate for various values
[recogRate]=myEigenFaces(X,T,K,0,6,4);
% Plot the result
figure;
plot(K,recogRate,'-o');
xlabel('k'), ylabel('Recognition Rate'), title('ORL database');

%% Yale database
att_faces = uigetdir();
% att_faces = '../../CroppedYale/'; % Used for debugging
dir_list = dir(att_faces);
% Train images, X and Test images, T
X= zeros(192*168,38*40);
T= zeros(192*168,38*20);
% Work through the dir and populate X and T
for i = 3:40
    oldfolder=cd(strcat(att_faces,'/',dir_list(i).name));
    innerlist = dir('./**');
    for j = 3:42
        X(:,(i-3)*40+j-2)=reshape(imread(innerlist(j).name),192*168,1);
    end
    for j = 43:62
        T(:,(i-3)*20+j-42)=reshape(imread(innerlist(j).name),192*168,1);
    end
    cd(oldfolder);
end
% List of values of K to use
K=[1, 2, 3, 5, 10, 15, 20, 30, 50, 60, 65, 75, 100, 200, 300, 500, 1000];
% Recognition rate for various values
recogRate=myEigenFaces(X,T,K,3,40,20);
% Plot the result
figure;
plot(K,recogRate,'-o');
xlabel('k'), ylabel('Recognition Rate'), title('Yale database');

toc;
