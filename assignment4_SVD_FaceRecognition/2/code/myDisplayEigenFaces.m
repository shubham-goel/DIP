function myDisplayEigenFaces(X,K)
    [d,n]=size(X);
    x=sum(X,2)./n;
    X=bsxfun(@minus,X,x);
    [V,D]=eig(X'*X);
    Vd=X*V;
    Vd=normc(Vd);
    
    figure;
    for i=1:size(K')
        Vk=Vd(:,n-K(i)+1-3:n-3);
        alpha=Vk'*X(:,1);
        Xr=Vk*alpha;
        subplot(3,3,i);
        imshow(mat2gray(reshape(Xr,192,168)));
        title(strcat('k = ', int2str(K(i))));
    end
    waitforbuttonpress;
    
    figure;
    for i= n-25+1:n
        subplot(5,5,n-i+1);
        imshow(mat2gray(reshape(Vd(:,i),192,168)));
    end
    suptitle('Top 25 eigenfaces in decreasing order of eigenvalues'); 
    waitforbuttonpress;
    
end