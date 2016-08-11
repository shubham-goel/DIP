function newim = myLinearContrastStretching(im)

digits(4);
[m,n] = size(im);
maxP = max(im(:));
minP = min(im(:));
newim = zeros(m, n);
newim = double(newim);
im = double(im);
for i = 1:size(newim,1)
    for j = 1:size(newim,2)
        newim(i, j) = (im(i, j) - minP)*255.0/(maxP - minP);
    end
end
end