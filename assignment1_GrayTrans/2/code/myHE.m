function newim = myHE(im)

digits(4);
newim = im;
cdf = myCDF(im);
for k = 1:size(im,3)
    newim(:,:,k) = arrayfun(@(x) cdf(k, x + 1), im);
end
end