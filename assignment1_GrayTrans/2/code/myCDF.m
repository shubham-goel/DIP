function mycdf = myCDF(im)

digits(4);
mycdf = zeros(size(im, 3), 256);
edges = 0:256;
for k = 1:size(im,3)
%     im1 = im(:,:,k);
%     for i = 1:size(im1,1)
%         for j = 1:size(im1,2)
%             if(im1(i,j) >= 0)
%                 cdf(k, im1(i,j) + 1) = cdf(k, im1(i,j) + 1) + 1;
%             end
%         end
%     end
%     for i = 1:255
%        cdf(k, i + 1) = cdf(k, i + 1) + cdf(k, i);
%     end
%     cdf(k, :) = cdf(k, :)*255/max(cdf(k, :));
      mypdf = histcounts(im(:,:,k),edges);
      mycdf(k, :) = cumsum(mypdf);
      mycdf(k, :) = mycdf(k, :)*255/max(mycdf(k, :));
end

end
