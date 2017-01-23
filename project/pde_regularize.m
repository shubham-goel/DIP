function [img] = pde_regularize(imgorig,img,window_size,gaussian_sigma,dt,iter,show_mse)
    [m,n,k]=size(img);
    G=fspecial('gaussian',2,gaussian_sigma);
    A=zeros(m,n,k,2,2);
    Asigma=zeros(m,n,k,2,2);
    As=zeros(2,2);
    for i=1:iter
        I=img;
        [Ix,Iy]=gradient(I);
        A(:,:,:,2,2)=Iy.*Iy;
        A(:,:,:,2,1)=Ix.*Iy;
        A(:,:,:,1,2)=Ix.*Iy;
        A(:,:,:,1,1)=Ix.*Ix;
        
        Asigma(:,:,:)=imfilter(A(:,:,:),G); %smoothened structure tensor
        for x=1+floor(window_size/2):m-floor(window_size/2)
            for y=1+floor(window_size/2):n-floor(window_size/2)
                for z=1:k
                    As(:,:)=Asigma(x,y,z,:,:);
                    [V,D]=eig(As);
                    fminus=1/sqrt(1+D(1,1)+D(2,2));
                    fplus=fminus^2;
                    T=fplus*V(:,2)*V(:,2).'+fminus*V(:,1)*V(:,1).';
                    GTt=getGTt(T,window_size,dt,0);
                    img(x,y,z)= sum(sum(GTt.*I(x-floor(window_size/2):x+floor(window_size/2),y-floor(window_size/2):y+floor(window_size/2),z)).');
                end
            end
        end
        imshow(mat2gray(img));
        if show_mse==1
            mse(imgorig,img);
        end
        i=i
    end
end