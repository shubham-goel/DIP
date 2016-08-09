function newim = myNearestNeighborInterpolation(im)

digits(4);
[m,n] = size(im);
newim = zeros(3*m -2, 2*n - 1);
newim = double(newim);
for i = 1:size(newim,1)
    for j = 1:size(newim,2)
        if(mod(i,3) == 1 && mod(j,2) == 1)
            newim(i, j) = im((i + 2)/3, (j + 1)/2.0);
        end
    end
end
for i = 1:size(newim,1)
    for j = 1:size(newim,2)
        if(mod(i,3) == 1 && mod(j,2) == 0)
            newim(i, j) = newim(i, (j + 1));
        end
    end
end
for i = 1:size(newim,1)
    for j = 1:size(newim,2)
        if(mod(i,3) == 2)
            newim(i, j) = newim(i - 1, j);
        elseif(mod(i,3) == 0)
            newim(i, j) = newim(i + 1, j);
        end
    end
end

end