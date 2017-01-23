function [] = myIdealLowPassFilter(im,D)
    [m,n]=size(im);
    im2=padarray(im,[m/2,n/2]);
    F = fftshift(fft2(im2));
    
    %display the filter in frequency domain
    H=zeros([2*m 2*n]);    
    for u=1:sqrt(D*D)
        for v=1:sqrt(D*D)
            if u*u+v*v<=D*D
                H(u+m,v+n)=1;
                H(u+m,-v+n)=1;
                H(-u+m,v+n)=1;
                H(-u+m,-v+n)=1;
            end
        end
    end  
    %displaying the filter
    figure;
    imagesc(log(H+1));
    daspect([1 1 1]);
    ti=sprintf('Idal low pass filter D=%f',D );
    title(ti);
    colorbar;
    
    %applying the filter
    F=F.*H;

    im2=real(ifft2(ifftshift(F)));
    im2=im2(m/2+1:m+m/2,n/2+1:n/2+n);

    %displaying the filtered image
    figure;
    imagesc(im2);
    daspect([1 1 1]);
    ti=sprintf('Image, from ideal low pass filter D=%f',D);
    title(ti);
    colorbar;
    colormap gray;
end