function recogRate = myEigenFaces(X,T,K,drop,nx,nt)
    [d,n]=size(X);
    [d,t]=size(T);
    recogRate=zeros(size(K));
    x=sum(X,2)./n;
    X=bsxfun(@minus,X,x);
    T=bsxfun(@minus,T,x);
    [V,D]=eig(X'*X);
    Vd=X*V;
    Vd=normc(Vd);
    for i=1:size(K')
        alpha = zeros(K(i),n);
        alphaProbe = zeros(K(i),t);
        Vk=Vd(:,n-K(i)+1-drop:n-drop);
        alpha(:,1:n)=Vk'*X;
        alphaProbe(:,1:t)=Vk'*T;
        IDX = knnsearch(alpha', alphaProbe');
        for j=1:t
            if(ceil(IDX(j)/nx)==ceil(j/nt)) 
                recogRate(i)=recogRate(i)+1;
            end
        end    
    end    
    recogRate=recogRate./t;
end