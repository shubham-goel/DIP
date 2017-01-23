function [] = myGaussianLowPassFilter(im, sigma)
    [m,n]=size(im);
    im2 = padarray(im,[m/2 n/2]);
    F = fftshift(fft2(im2));
    
    %constructing the gaussian low pass filter
    G = fspecial('gaussian',[2*m,2*n],sigma);
    %displaying the filter
    figure;
    imagesc(log(G+1));
    daspect([1 1 1]);
    ti=sprintf('Gaussian low pass filter, sigma=%f',sigma);
    title(ti);
    colorbar;
    
    F=F.*G;
    
    im2=real(ifft2(ifftshift(F)));
    im2=im2(m/2+1:m/2+m,n/2+1:n/2+n);
    %display filtered image
    figure;
    imagesc(im2);
    daspect([1 1 1]);
    ti=sprintf('Image from gaussian low pass filter with sigma=%f',sigma);
    title(ti);
    colormap gray;
    colorbar;

end