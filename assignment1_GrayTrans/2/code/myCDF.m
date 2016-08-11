function mycdf = myCDF(im)

digits(4);
mycdf = zeros(size(im, 3), 256);
edges = 0:256;
for k = 1:size(im,3)

      mypdf = histcounts(im(:,:,k),edges);
      mycdf(k, :) = cumsum(mypdf);
      mycdf(k, :) = mycdf(k, :)*255/max(mycdf(k, :));
      mycdf(k, :) = round(mycdf(k, :));

end

end
