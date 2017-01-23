%% MyMainScript

clear;
tic;

%% Your code here
att_faces = uigetdir();
% att_faces = '../../att_faces/';
dir_list = dir(att_faces);
X= zeros(92*112,32*6);
Told= zeros(92*112,32*4);
Tnew= zeros(92*112,8*10);
for i = 4:35
    oldfolder=cd(strcat(att_faces,'/',dir_list(i).name));
    innerlist = dir('./**');
    for j = 3:8
        X(:,(i-4)*6+j-2)=reshape(imread(innerlist(j).name),92*112,1);
    end
    for j = 9:12
        Told(:,(i-4)*4+j-8)=reshape(imread(innerlist(j).name),92*112,1);
    end
    cd(oldfolder);
end
for i = 36:43
    oldfolder=cd(strcat(att_faces,'/',dir_list(i).name));
    innerlist = dir('./**');
    for j = 3:12
        Tnew(:,(i-36)*10+j-2)=reshape(imread(innerlist(j).name),92*112,1);
    end
    cd(oldfolder);
end
K=25
threshold=1965 
[false_positive,false_negative]=myEigenFacesTest(X,Tnew,Told,K,threshold)
