function [fp, fn] = myEigenFacesTest(X,Tnew,Told,K,threshold)
    [d,n]=size(X);
    [d,tnew]=size(Tnew);
    [d,told]=size(Told);
    fp = 0;
    fn = 0;
    x=sum(X,2)./n;
    X=bsxfun(@minus,X,x);
    Tnew=bsxfun(@minus,Tnew,x);
    Told=bsxfun(@minus,Told,x);
    [V,D]=eig(X'*X);
    vk=V(:,n-K+1:n);
    Vk=X*vk;
    Vk=normc(Vk);
    
    alpha = zeros(K,n);
    alphaProbeNew = zeros(K,tnew);
    alphaProbeOld = zeros(K,told);
    
    alpha(:,1:n)=Vk'*X;
    alphaProbeNew(:,1:tnew)=Vk'*Tnew;
    alphaProbeOld(:,1:told)=Vk'*Told;
    
    IDXnew = knnsearch(alpha', alphaProbeNew');
    IDXold = knnsearch(alpha', alphaProbeOld');
    
    for j=1:tnew
        if(norm(alpha(:,IDXnew(j))-alphaProbeNew(:,j)) < threshold)
            fp=fp+1;
        end
    end
    
    for j=1:told
        if(norm(alpha(:,IDXold(j))-alphaProbeOld(:,j)) > threshold)
            fn=fn+1;
        end
    end   
    
end