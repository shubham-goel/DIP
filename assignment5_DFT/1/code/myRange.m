function rng = myRange( i1,i2, j1,j2, m,n, patch_size )
    XX = zeros(i2-i1+1,j2-j1+1);
    XX(:,1) = (i1-1:i2-1)*(n-patch_size+1);
    YY = (j1:j2);
    for z = i1:i2
        XX(z-i1+1,:) = XX(z-i1+1,1)+YY;
    end
    rng = XX(:);
end

