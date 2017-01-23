function [cornernessMeasure,eigenValue] = myHarrisCornerDetector(img, sigmaS, sigmaW,k,harris_threshold)
    %get image dimensions
    [m,n]=size(img);
    halfW=ceil(sigmaW*3);
    %smoothing mask
    G = fspecial('gaussian',ceil(6*sigmaS),sigmaS);
    %w(u,v) for harris corner detection
    W = fspecial('gaussian',ceil(sigmaW*3)*2+1,sigmaW);
    %get the smoothened image
    smoothened_img = imfilter(img , G);
    paddedim = padarray(smoothened_img, [ceil(sigmaW*3), ceil(sigmaW*3)]);
    %get the gradient
    [Ix, Iy]=gradient(paddedim);
    %display gradient images
    figure
    imagesc(Ix(halfW+1:halfW+m,halfW+1:halfW+n));
    colormap gray
    title('Gradient along x');
    daspect([1,1,1])
    colorbar
    figure
    imagesc(Iy(halfW+1:halfW+m,halfW+1:halfW+n));
    colormap gray
    title('Gradient along x');
    daspect([1,1,1])
    colorbar

    Ixx=Ix.*Ix;
    Ixy=Ix.*Iy;
    Iyy=Iy.*Iy;
    %cornerness measure and eigen values to be returned
    cornernessMeasure=zeros(m,n);
    eigenValue=zeros(m,n,2);

    for i=halfW+1:halfW+m
        for j=halfW+1:halfW+n
            %for each pixel in image
            Sxx = Ixx(i-halfW:i+halfW,j-halfW:j+halfW).*W;
            Sxx = sum(sum(Sxx));
            Sxy = Ixy(i-halfW:i+halfW,j-halfW:j+halfW).*W;
            Sxy = sum(sum(Sxy));
            Syy = Iyy(i-halfW:i+halfW,j-halfW:j+halfW).*W;
            Syy = sum(sum(Syy));
            %get the structure tensor
            A=[Sxx,Sxy;Sxy,Syy];
            %get eigen values and cornerness measure
            e=eig(A);
            eigenValue(i-halfW,j-halfW,:)=[e(1),e(2)];
            cornernessMeasure(i-halfW,j-halfW) = det(A)-k*trace(A)*trace(A);
            %applying thresholding
            if(cornernessMeasure(i-halfW,j-halfW)<harris_threshold)
                cornernessMeasure(i-halfW,j-halfW)=0;
            end
        end
    end
    %non maximum cornerness suppression
    for i=1:m
        for j=1:n
            %iterate over window
            cornerness=0;
            for k=max(i-1,1):min(m,i+1)
                for l=max(i-1,1):min(n,i+1)
                    if(k==i||l==j)
                        continue
                    end
                    cornerness=max(cornerness,cornernessMeasure(l,k));
                end
            end
            if(cornerness>cornernessMeasure(i,j))
               cornernessMeasure(i,j)=0 ;
            end
        end
    end
end
