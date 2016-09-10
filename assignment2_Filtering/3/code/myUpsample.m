function newim = myUpsample(im)

digits(4);
[m,n] = size(im);
mNew = 2*m;
nNew = 2*n;
newim = zeros(mNew, nNew);
newim = double(newim);
for i = 1:size(newim,1)
	for j = 1:size(newim,2)
		if(mod(i,2) == 1 && mod(j,2) == 1)
			newim(i,j) = im((i+1)/2,(j+1)/2);
		end
	end
end
for i = 1:size(newim,1)
	for j = 1:size(newim,2)
		if(mod(i,2) == 1 && mod(j,2) == 0)
			if(j<size(newim,2))
				newim(i,j) = (newim(i,(j+1)) + newim(i,(j-1)))/2;
			else
				newim(i,j) = newim(i,(j-1));
		end
	end
end
for i = 1:size(newim,1)
	for j = 1:size(newim,2)
		if(mod(i,2) == 0)
			if(i<size(newim,1))
				newim(i,j) = (newim((i+1),j) + newim((i-1),j))/2;
			else
				newim(i,j) = newim((i-1),j);
			end
		end
	end
end
end
