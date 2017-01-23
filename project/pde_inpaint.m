function [img] = pde_inpaint(img,mask,window_size,gaussian_sigma,dt,iter)
    [m,n,k]=size(img);
    G=fspecial('gaussian',2,gaussian_sigma);
    A=zeros(m,n,k,2,2);
    Asigma=zeros(m,n,k,2,2);
    As=zeros(2,2);
    
    ini_min = min(min(min(img)))
    ini_max = max(max(max(img)))
    
    for i = 1:m
        for j = 1:n
            if(mask(i,j)>0)
                for l = 1:k
                    img(i,j,l) = (ini_max-ini_min)/2 + ini_min;
                end
            end
        end
    end
    
    for i=1:iter
        I=img;
        
        imgnan = sum(sum(sum(sum(sum(isnan(img))))))
        
        [Ix,Iy]=gradient(I);
        
        
        A(:,:,:,2,2)=Iy.*Iy;
        A(:,:,:,2,1)=Ix.*Iy;
        A(:,:,:,1,2)=Ix.*Iy;
        A(:,:,:,1,1)=Ix.*Ix;
        
        amin = min(min(min(min(min(A)))))
        amax = max(max(max(max(max(A)))))
        anan = sum(sum(sum(sum(sum(isnan(A))))))

        Asigma(:,:,:)=imfilter(A(:,:,:),G); %smoothened structure tensor
        for x=1+floor(window_size/2):m-floor(window_size/2)
            for y=1+floor(window_size/2):n-floor(window_size/2)
                if(mask(x,y) > 0)
                    for z=1:k
                        As(:,:)=Asigma(x,y,z,:,:);
                        
                        if(sum(sum(isnan(As))))
                            x,y,z
                            mask(x,y)
                        end
                        
                        [V,D]=eig(As);
                        fminus=1/sqrt(1+D(1,1)+D(2,2));
                        fplus=fminus^2;
%                         T=fplus*V(:,2)*V(:,2).'+fminus*V(:,1)*V(:,1).';
                        T=V(:,2)*V(:,2).';
                        GTt=getGTt(T,window_size,dt,1);
                        img(x,y,z)= sum(sum(GTt.*I(x-floor(window_size/2):x+floor(window_size/2),y-floor(window_size/2):y+floor(window_size/2),z)).');
                    end
                end
            end
        end
        imshow(mat2gray(img));
    end
end