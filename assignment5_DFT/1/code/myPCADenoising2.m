function res = myPCADenoising2( im, patch_size, var )
%myPCADenoising2 Denoises using PCA, uses K nearest neighbors
N_HOOD = 15;
K = 200;

% Constructing P
[m,n] = size(im);
N = (m-patch_size+1)*(n-patch_size+1);
P = zeros(patch_size^2, N);
P_den = P;

for i = 1:m-patch_size+1
    for j = 1:n-patch_size+1
        P(:,(i-1)*(n-patch_size+1)+j) = reshape(im(i:i+patch_size-1,j:j+patch_size-1),[],1);
    end
end

im2_dat = zeros(m,n);
im2_cnt = zeros(m,n);

for i = 1:m-patch_size+1
    for j = 1:n-patch_size+1
        z = (i-1)*(n-patch_size+1)+j;
        
        % Find 31x31 neighbourhood
        myRng = myRange(max(1,i-N_HOOD), min(m-patch_size+1,i+N_HOOD), max(1,j-N_HOOD), min(n-patch_size+1,j+N_HOOD),m,n,patch_size);
        Q = P(:,myRng);
        
        % Find 200 closest neighbours
        [IDX,D] = knnsearch(Q',P(:,z)','K',K);
        Q = Q(:,IDX);
        
        % Finding Alpha_denoised using their eigenspace
        [V,D] = eig(Q*Q');
        Alpha = V'*Q;
        Alpha_mean = max(0,diag(Alpha*Alpha')/K-var);
        fact = (((Alpha_mean/var).^(-1))+1).^(-1);
        Alpha_Denoised = diag(fact)*Alpha(:,1);

        P_den(:,z) = V*Alpha_Denoised;
    end
end

for i = 1:m-patch_size+1
    for j = 1:n-patch_size+1
        im2_dat(i:i+patch_size-1,j:j+patch_size-1) = im2_dat(i:i+patch_size-1,j:j+patch_size-1) + reshape(P_den(:,(i-1)*(n-patch_size+1)+j),[],patch_size);
        im2_cnt(i:i+patch_size-1,j:j+patch_size-1) = im2_cnt(i:i+patch_size-1,j:j+patch_size-1) + 1;
    end
end

res = im2_dat./im2_cnt;
end

