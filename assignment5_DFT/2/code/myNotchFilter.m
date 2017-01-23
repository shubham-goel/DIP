function [] = myNotchFilter(im, u0, v0,threshold)
    %displaying the log of the fourier transform
    [m,n] = size(im);
    t = size(u0,2)
    im = padarray(im,[m/2,n/2]);
    F = fft2(im);
    F = fftshift(F);
    lF = abs(F);
    lF = log(lF+1);
    figure;
    imagesc(mat2gray(lF));
    daspect([1 1 1]);
%    colormap gray;
    colorbar;
        
    %Notch filter
    for u=1:m
        for v=1:n
            for i=1:t
                if (u-u0(i))*(u-u0(i))+(v-v0(i))*(v-v0(i))<threshold
                    F(u+m/2,v+n/2)=0;
                end
            end
        end
    end
    
    F = ifftshift(F);
    im2 = ifft2(F);
    im2 = real(im2);
    im2=im2(m/2+1:m+m/2,n/2+1:n+n/2);
    figure;
    imagesc(im2);
    daspect([1 1 1]);
    colormap gray;
    colorbar;
end