function rmsd = RMSD(im1, im2)

digits(4);
[m, n] = size(im1);
A = im1 - im2;
A = A.*A;
temp = sum(A(:))/(m*n);
rmsd = sqrt(temp);

end