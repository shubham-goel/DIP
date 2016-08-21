function newim = myHE(im)

disp('Started HE')

digits(4);
newim = im;
cdf = myCDF(im);
for k = 1:size(im,3)
    newim(:,:,k) = arrayfun(@(x) cdf(k, x + 1), im(:,:,k));
end

disp('Ended HE')

end