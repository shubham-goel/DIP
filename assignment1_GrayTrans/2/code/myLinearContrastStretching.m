function newim = myLinearContrastStretching(im)

digits(4);
newim = im;
for k = 1:size(newim,3)
	im1 = im2double(im(:,:,k));
	[m,n] = size(im1);
	maxP = max(im1(:));
	minP = min(im1(:));
	newim1 = zeros(m, n);
	newim1 = double(newim1);
	im1 = double(im1);
	p = 0.7;
	s1 = 0.1;
	s2 = 10;
	x1 = minP + ((1-p)/2)*(maxP - minP);
	x2 = x1 + p*(maxP - minP);
	y1 = s1*(x1 - minP);
	y2 = s2*(x2 - x1) + y1;
	for i = 1:size(newim1,1)
	    for j = 1:size(newim1,2)
	        pixel = im1(i, j);
	        if(pixel <= x1)
	            newim1(i, j) = (pixel - minP)*s1;
	        elseif(pixel <= x2)
	            newim1(i, j) = (pixel - x1)*s2 + y1;
	        else
	            newim1(i, j) = (pixel - x2)*s1 + y2;
	        end
	    end
	end
	newmax = max(newim1(:));
	newim1 = newim1*255/newmax;
	newim(:,:,k) = newim1;
end
