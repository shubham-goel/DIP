%% MyMainScript

tic;
%% SVD
A = dlmread('matA.txt');

[U, V, S] = MySVD(A)

% Verifying equality of A and USV'
% Note that they are not exactly equal because of numerical imprecision
% during calculation
reconstructionWorks = all(all(checkEqual(A,U*diag(S)*V')))

toc;
