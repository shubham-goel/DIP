function newim = myBilateralFiltering(im, sigmaS, sigmaI)

digits(4);
[m,n] = size(im);
epsilon = power(10, -4);
W = 0;
im = double(im);
newim = double(zeros(m, n));
while(true)
    if normpdf(W, 0, sigmaS)*255 <= epsilon
        break;
    else
        W = W + 1;
    end
end
W = 2*W - 1;
W = W + 1 - mod(W, 2);
halfW = (W - 1)/2;
spaceMask = fspecial('gaussian', W, sigmaS);
tempim = padarray(im, [halfW, halfW]);
for i = halfW+1:m+halfW
    for j = halfW+1:n+halfW
        temp1 = tempim(i-halfW:i+halfW, j-halfW:j+halfW);
        temp2 = normpdf(temp1 - tempim(i, j), 0, sigmaI);
        numerMat = temp1.*temp2.*spaceMask;
        denomMat = temp2.*spaceMask;
        numer = sum(numerMat(:));
        denom = sum(denomMat(:));
        newim(i - halfW, j - halfW) = numer/denom;
    end
end

end